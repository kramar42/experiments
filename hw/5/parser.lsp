; chars, that can be in <num>
; will be initialized in init func
(defparameter num-values nil)
; chars, that can be separators in (<expr>)
(defparameter separators '(#\( #\)))
; chars, that can be separators in +- <term>
(defparameter expr-signs '(#\+ #\-))
; chars, that can be separators in */ <factor>
(defparameter term-signs '(#\* #\/))
; current token
(defparameter token nil)
; input list
(defparameter input nil)
; output list
(defparameter output nil)
; accumulator for <num> lexem
(defparameter num-accum nil)
; table of all identifiers and their codes
; separators, sights are identifiers
; will be initialized in init func
(defparameter identif-table '(0))
; table of all numbers and their codes
(defparameter numbers-table '(100))



; LEXER FUNCTIONS

(defun lexer (input)
  (lexer* (coerce input 'list)))


(defun lexer* (input)
  (init)
  (setf input input)
  (scan)
  (lexer-expander)
  (setf output (reverse output))
  output)


(defun lexer-expander ()
  ; process number
  (cond
    ((member token num-values)
     (read-num)) 
    ; or any other valid symbol
    ((not (null (assoc token
                       (cdr identif-table))))
     (progn
       (out (get-identif token))
       (scan)))
    (t (out nil)))
  (if (null token)
    nil
    (lexer-expander)))



; PARSER FUNCTIONS

(defun parser (input)
  (setf input input)
  (scan)
  (expr))
(defun expr ()
  (remove nil
          (list
           'expression
           (term)
           (expr-list))))


(defun term ()
  (remove nil
          (list
           'term
           (factor)
           (term-list))))


(defun factor ()
  (cond
    ; opening bracket
    ((eq token (get-identif #\())
     (progn
       (scan)
       (list
        'factor
        '[
        ; then -> expression
        (expr)
        ; closing bracket
        (if (eq token (get-identif #\)))
          ']
          nil))))
    ((not (null (get-number token)))
     (remove nil
             (list 'number (get-number token))))))


(defun expr-list ()
  ; if token eq + or -
  (let ((sign (rget-identif token)))
    (if (member sign expr-signs)
      (progn
        (scan)
        (remove nil
                (list
                 (get-sign sign)
                 (term)
                 (expr-list)))))))


(defun term-list ()
  (scan)
  ; if token eq * or /
  (let ((sign (rget-identif token)))
    (if (member sign term-signs)
    (progn
        (scan)
        ; return new list without nils
        (remove nil
                (list
                 (get-sign sign)
                 (factor)
                 (term-list)))))))



; SOME ADDITIONAL FUNCTIONS

(defun test ()
  (lexer "1*(2*(3-4)-5)*6-7+8-9")
  (parser output))


(defun read-num ()
  (if (member token num-values)
    (progn
      (push token num-accum)
      (scan)
      (read-num))
    (progn
      (out (add-number (process-num)))
      (setf num-accum nil))))


(defun process-num ()
  (reduce (lambda (ack digit) (+ digit (* 10 ack)))
          (reverse (mapcar (lambda (char)
                             (- (char-code char)
                                (char-code #\0)))
                           num-accum))))


(defun init ()
  (setf num-values (mapcar #'code-char
                                 (range 10
                                        (char-code #\0))))
  (setf token nil)
  (setf output nil)
  (setf num-accum nil)
  (setf identif-table '(0))
  (setf numbers-table '(100))
  
  (mapcar (lambda (elem) (add-identif elem))
        (concatenate 'list
                     separators
                     expr-signs
                     term-signs)))


(defun range (count &optional (start 0) (step 1))
  (loop repeat count for i from start by step collect i))


(defun add-identif (identif)
  (let ((new-id (1+ (car identif-table))))
    (setf identif-table
          (cons new-id
                ; constructing new list of identifiers
                (cons
                 ; just adding new dotted pair
                 (cons identif new-id)
                 (cdr identif-table))))))


(defun add-number (number)
  (let ((id (assoc number (cdr numbers-table)))
        (new-id (1+ (car numbers-table))))
    (if (null id)
      (progn
        ; create new table        
        (setf numbers-table
          ; with new id number on first place
          (cons new-id
                ; constructing new list of identifiers
                (cons
                 ; just adding new dotted pair
                 (cons number new-id)
                 (cdr numbers-table))))
        new-id)
      (cdr id))))


(defun out (identif)
  (push identif output))


(defun scan ()
  (setf token (car input))
  (setf input (cdr input)))


(defun get-identif (identif)
  (cdr (assoc identif (cdr identif-table))))


(defun rget-identif (identif)
  (car (rassoc identif (cdr identif-table))))


(defun get-number (number)
  (car (rassoc number (cdr numbers-table))))


(defun get-sign (sign)
  (intern (coerce (list sign) 'string)))
