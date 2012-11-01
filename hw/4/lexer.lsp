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
; merged all tables
(defparameter tables nil)

(defun lexer (input)
  "Lexer analyzer from string."
  (lexer* (coerce input 'list)))


(defun lexer* (input)
  "Lexer analyzer from list of chars."
  (init)
  (setf input input)
  (scan)
  (expr)
  (reverse output))


(defun scan ()
  (setf token (car input))
  (setf input (cdr input)))


(defun out (identif)
  (push identif output))


(defun expr ()
  (term)
  ; do not need to scan
  ; factor inside
  (expr-list))


(defun expr-list ()
  ; if token eq + or -
  (if (member token expr-signs)
    (progn
       (out (get-identif token))
       (scan)
       (term)
       ;(scan)
       (expr-list))))


(defun term ()
  (factor)
  ; do not need to scan
  ; factor already scaned, next value is already in token
  (term-list))


(defun term-list ()
  ; if token eq * or /
  (if (member token term-signs)
    (progn
       (out (get-identif token))
       (scan)
       (factor)
       ; do not need to scan
       ; factor already scaned, next value is already in token
       (term-list))))


(defun factor ()
  (cond
    ; opening bracket
    ((eq token #\( )
     (progn
       (out (get-identif token))
       (scan)
       ; then -> expression
       (expr)
       ;(scan)
       ; closing bracket
       (if (eq token #\))
         (progn
           (out (get-identif token))
           (scan))
         (print "FACTOR ERROR"))))
    ((member token num-values)
     (num))
    (t (print "FACTOR ERROR"))))


(defun num ()
  (if (member token num-values)
    (progn
      (push token num-accum)
      (scan)
      (num))
    (progn
      (out (get-number (process-num)))
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
  
  (mapcar (lambda (elem) (get-identif elem))
        (concatenate 'list
                     separators
                     expr-signs
                     term-signs)))


(defun range (count &optional (start 0) (step 1))
  (loop repeat count for i from start by step collect i))


(defun get-identif (identif)
  (let ((id (assoc identif (cdr identif-table)))
        (new-id (1+ (car identif-table))))
    (if (null id)
      (progn
        ; create new table        
        (setf identif-table
          ; with new id number on first place
          (cons new-id
                ; constructing new list of identifiers
                (cons
                 ; just adding new dotted pair
                 (cons identif new-id)
                 (cdr identif-table))))
        new-id)
      (cdr id))))


(defun get-number (number)
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

(defun delexer (lexems)
  (setf tables (append (cdr identif-table) (cdr numbers-table))) 
  (join-string-list
  (mapcar (lambda (x)
            (get-char-by-id x tables))
          lexems)))

(defun get-char-by-id (id table)
  (cond
    ((eq id (cdar table))
     (let ((obj (caar table)))
       (if (typep obj 'number)
         (write-to-string obj)
         (string obj))) )
    ((null table)
     nil)
    (t
     (get-char-by-id id (cdr table)))))

(defun join-string-list (string-list)
  "Concatenates a list of strings
and puts spaces between the elements."
  (format nil "~{~A~^~}" string-list))

(defun test ()
  (let ((cases
          '("4+4+4+4")))
    (mapcar (lambda (str)
              (if (equal str
                         (delexer (lexer str)))
                (print "Passed")
                (print "Failed")))
            cases)))
