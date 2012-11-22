(defparameter num-values nil)
(defparameter separators '(#\( #\)))
(defparameter expr-signs '(#\+ #\-))
(defparameter term-signs '(#\* #\/))

(defparameter _token_ nil)
(defparameter _input_ nil)
(defparameter _output_ nil)

(defparameter num-accum nil)
(defparameter identif-table nil)
(defparameter numbers-table nil)


; LEXER FUNCTIONS

(defun lexer (input)
  (lexer* (coerce input 'list)))


(defun lexer* (input)
  (let ((old-input _input_)
        (old-output _output_)
        (old-token _token_)
        (result nil))
    
    (setf _input_ input)
    (scan)
    (lexer-expander)
    (setf _output_ (reverse _output_))

    (setf result _output_)
    (setf _input_ old-input)
    (setf _output_ old-output)
    (setf _token_ old-token)
    result))


(defun lexer-expander ()
  ; process number
  (cond
    ((member _token_ num-values)
     (read-num)) 
    ; or any other valid symbol
    ((not (null (assoc _token_
                       (cdr identif-table))))
     (progn
       (out (get-identif _token_))
       (scan)))
    (t (out nil)))
  (if (not (null _token_))
    (lexer-expander)))



; PARSER FUNCTIONS

(defun parser (input)
  (let ((old-input _input_)
        (old-token _token_)
        (result (gensym)))
    (setf _input_ input)
    (scan)
    (setf result (expr))

    (setf _input_ old-input)
    (setf _token_ old-token)
    result))


(defun expr ()
  (let ((term-val (term))
        (expr-val (expr-list)))
    (remove nil
          (list
           'expr
           (car expr-val)
           term-val
           (cdr expr-val)))))


(defun term ()
  (let ((factor-val (factor))
        (term-val (term-list)))
    (if (null term-val)
      factor-val
      (remove nil
          (list
           'term
           (car term-val)
           factor-val
           (cdr term-val))))))


(defun factor ()
  (cond
    ; opening bracket
    ((eq _token_ (get-identif #\())
     (progn
       (scan)
       (list
        'factor
        '[
        ; then -> expression
        (expr)
        ; closing bracket
        (if (eq _token_ (get-identif #\)))
          ']
          nil))))
    ((not (null (get-number _token_)))
     (list 'num (get-number _token_)))))


(defun expr-list ()
  ; if token eq + or -
  (let ((sign (rget-identif _token_)))
    (if (member sign expr-signs)
      (progn
        (scan)
        (let ((term-val (term))
              (expr-val (expr-list))
              (sign (get-sign sign)))
          (remove nil
                  (if (null expr-val)
                    (cons sign term-val)
                    (list
                     sign
                     (car expr-val)
                     term-val
                     (cdr expr-val)))))))))


(defun term-list ()
  (scan)
  ; if token eq * or /
  (let ((sign (rget-identif _token_)))
    (if (member sign term-signs)
    (progn
        (scan)
        ; return new list without nils
        (let ((factor-val (factor))
              (term-val (term-list))
              (sign (get-sign sign)))
          (remove nil
                  (if (null term-val)
                    (cons sign factor-val)
                    (list
                     sign
                     (car term-val)
                     factor-val
                     (cdr term-val)))))))))



; SOME ADDITIONAL FUNCTIONS

(defun read-num ()
  (if (member _token_ num-values)
    (progn
      (push _token_ num-accum)
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
  (setf _token_ nil)
  (setf _input_ nil)
  (setf _output_ nil)
  (setf num-accum nil)
  (setf identif-table '(0))
  (setf numbers-table '(100))
  
  (mapcar (lambda (elem) (add-identif elem))
        (concatenate 'list
                     separators
                     expr-signs
                     term-signs))
  T)


(defun refresh ()
  (setf _token_ nil)
  (setf _input_ nil)
  (setf _output_ nil)
  T)


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
  (push identif _output_))


(defun scan ()
  (setf _token_ (car _input_))
  (setf _input_ (cdr _input_)))


(defun get-identif (identif)
  (cdr (assoc identif (cdr identif-table))))


(defun rget-identif (identif)
  (car (rassoc identif (cdr identif-table))))


(defun get-number (number)
  (car (rassoc number (cdr numbers-table))))


(defun get-sign (sign)
  (intern (coerce (list sign) 'string)))


(defun parse (input)
  (parser (lexer input)))


(set-macro-character #\! (get-macro-character #\)))
(set-dispatch-macro-character #\# #\!
                              (lambda (stream sub-char arg)
                                (let ((cmd (read stream t nil t))
                                      (string (read stream t nil t)))
                                  (list sub-char arg)
                                  (setf _input_ (lexer string))
                                  (scan)
                                  (list 'quote (funcall cmd)))))
