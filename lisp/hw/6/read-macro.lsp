(defparameter num-values nil)
(defparameter separator #\;)
(defparameter expr-signs '(#\+ #\-))
(defparameter term-signs '(#\* #\/))
(defparameter scopes '(#\( #\)))

(defparameter const (coerce "const" 'list))
(defparameter eq-sign (coerce ":=" 'list))

(defparameter _token_ nil)
(defparameter _input_ nil)
(defparameter _output_ nil)

(defparameter num-accum nil)
(defparameter identif-table '(0))
(defparameter numbers-table '(100))


; LEXER FUNCTIONS

(defun lexer (input)
  "Process input as lexems. Type of input - string."
  (lexer* (coerce input 'list)))


(defun lexer* (input)
  "Process input as lexems. Type of input - list of chars."
  (let ((old-input _input_)
        (old-output _output_)
        (old-token _token_)
        (result nil))
    
    (setf _input_ input)
    (scan)
    (lexer-expander)
    (setf result (reverse _output_))

    (setf _input_ old-input)
    (setf _output_ old-output)
    (setf _token_ old-token)
    result))


(defun lexer-expander ()
  "Recurcive function that parse input as lexems."
  (cond
    ; Process number
    ((member _token_ num-values)
     (read-num))

    ; const
    ((eq _token_ (car const))
      (progn
        (print "const")
        (labels ((read-const (const)
          (scan)
          (if (eq _token_ (car const))
            (progn
              (scan)
              (read-const (cdr const)))
            (if (null const)
              (out 1)
              (out nil)))))
        (read-const const))))

    ; Or any other valid symbol
    ((not (null (assoc _token_
     (cdr identif-table))))
    (progn
     (out (get-identif _token_))
     (scan)))

    ; Unknown submol
    (t (out nil)))
  (if (not (null _token_))
    (lexer-expander)))



; PARSER FUNCTIONS

(defun parser (input)
  "Parse input from top of grammar rules."
  (let ((old-input _input_)
        (old-token _token_)
        (result nil))
    (setf _input_ input)
    (setf _token_ nil)

    (scan)
    (setf result (expr))

    (setf _input_ old-input)
    (setf _token_ old-token)
    result))


(defun expr ()
  "Parse input as expression.
  <term> <expr-list>"
  (let* ((term-val (term))
        (expr-val (expr-list)))
  (append
    (list
     'expr
     (car expr-val)
     term-val)
    (cdr expr-val))))


(defun term ()
  "Parse input as term.
  <factor> <term-list>"
  (let* ((factor-val (factor))
         (term-val (term-list)))
  (append
    (list
      'expr
      (car factor-val)
      factor-val)
    term-val)))


(defun factor ()
  "Parse input as factor.
  ( <expr> )
  | <num>
  | <id>"
  (cond
    ; Opening bracket
    ((eq _token_ (get-identif #\())
     (progn
       (scan)
       (list
        'factor
        ; Then -> expression
        (expr))))
    ((not (null (get-number _token_)))
     (list 'num (get-number _token_)))))


(defun expr-list ()
  "Parse input as list of expressions.
  <empty>
  | <expr-sign> <term> <expr-list>"
  ; If token eq + or -
  (let ((sign (rget-identif _token_)))
    (if (member sign expr-signs)
      (progn
        (scan)
        (let* ((term-val (term))
          (expr-val (expr-list))
          (sign (get-sign sign)))
        (append
          (list
            sign
            term-val)
          expr-val))))))


(defun term-list ()
  "Parse input as list of terms.
  <empty>
  | <term-sign> <factor> <term-list>"
  (scan)
  ; If token eq * or /
  (let ((sign (rget-identif _token_)))
    (if (member sign term-signs)
    (progn
        (scan)
        (let ((factor-val (factor))
              (term-val (term-list))
              (sign (get-sign sign)))
        (if (null term-val)
          (cons sign factor-val)
          (list
           sign
           factor-val
           term-val)))))))



; SOME ADDITIONAL FUNCTIONS

(defun read-num ()
  "Read numbers from input & push result to output."
  (if (member _token_ num-values)
    (progn
      (push _token_ num-accum)
      (scan)
      (read-num))
    (progn
      (labels ((process-num ()
        "Process digits from num-accum to number & returns it."
          (reduce (lambda (ack digit) (+ digit (* 10 ack)))
            (reverse (mapcar (lambda (char)
             (- (char-code char)
              (char-code #\0)))
            num-accum))))

        (add-number (number)
          "Add number to numbers-table."
          (let ((id (assoc number (cdr numbers-table)))
            (new-id (1+ (car numbers-table))))

          ; If there is no such number
          (if (null id)
            (progn
              ; Create new table
              (setf numbers-table
                ; With new id number on first place
                (cons new-id
                  ; Constructing new list of identifiers
                  (cons
                    ; Just adding new dotted pair
                    (cons number new-id)
                    (cdr numbers-table))))
              new-id)

            ; Or return associated id
            (cdr id)))))

      (out (add-number (process-num))))
      (setf num-accum nil))))


(defun add-identif (identif)
  "Add identifier to identif-table. Used only in init function."
  (let ((new-id (1+ (car identif-table))))
    (setf identif-table
          (cons new-id
                ; constructing new list of identifiers
                (cons
                 ; just adding new dotted pair
                 (cons identif new-id)
                 (cdr identif-table))))))


(defun get-identif (identif)
  "Get identif associated with identif."
  (cdr (assoc identif (cdr identif-table))))


(defun rget-identif (identif)
  "Get right associated identif."
  (car (rassoc identif (cdr identif-table))))


(defun get-number (number)
  "Get number from numbers-table."
  (car (rassoc number (cdr numbers-table))))


(defun get-sign (sign)
  "Get sign symbol from sign char."
  (case sign
    (#\+ 'add)
    (#\- 'sub)
    (#\* 'mul)
    (#\/ 'div)))


(defun out (identif)
  "Push identif to output."
  (push identif _output_))


(defun scan ()
  "Scan next token from input."
  (setf _token_ (car _input_))
  (setf _input_ (cdr _input_)))


(defun init ()
  "Initial fill of num-values & identif-table."
  (setf num-values (mapcar #'code-char
    (labels ((range (count start)
      (loop repeat count for i from start by 1 collect i)))
    (range 10
      (char-code #\0)))))
  
  (mapcar (lambda (elem) (add-identif elem))
    (concatenate 'list
      (list separator const eq-sign)
      expr-signs
      term-signs
      scopes))
  T)
(init)


(set-macro-character #\! (get-macro-character #\)))
(set-dispatch-macro-character #\# #\!
  (lambda (stream sub-char arg)
    (let ((cmd (read stream t nil t))
      (string (read stream t nil t)))

    ; Just for get rid from warnings
    (list sub-char arg)
    ; Process string through lexer
    (setf _input_ (lexer string))
    ; Scan first token
    (scan)
    ; Run specific command
    `(,cmd))))
