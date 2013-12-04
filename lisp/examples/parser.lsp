(defun signp (sym)
    (or (eq sym #\+) (eq sym #\*) (eq sym #\-) (eq sym #\/) (eq sym #\() (eq sym #\))))
    
(defun signer (sym)
    (or
        (and (eq sym #\+) 'plus)
        (and (eq sym #\-) 'minus)
        (and (eq sym #\*) 'mul)
        (and (eq sym #\/) 'div)))
    
(defun normalize-list (list1)
  (remove-if #'null
             (map 'list
                  (lambda (x)
                    (cond 
                      ((or (eq x #\ ) (eq x #\Newline) (eq x #\Tab)) nil)
                      ((signp x) x)
                      ((digit-char-p x))
                      ((or (alpha-char-p x) (eq x #\?)) x)
                      (t 'ERR)))
             list1)))
            
(defun expres (str &key (number 0) (read-var nil) (var nil))
    (cond
        ((null str) nil)
        ((eq (car str) #\()
            (cons 'lpt (expres (cdr str))))
        ((eq (car str) #\))
            (cons 'rpt (expres (cdr str))))
        ((signp (car str))
            (cons (signer (car str)) (expres (cdr str))))
        ((numberp (car str))
            (if (numberp (cadr str))
                (expres (cdr str) :number (+ (* number 10) (car str)))
                (append (list (list 'num (+ (* number 10) (car str)))) (expres (cdr str)))))
        ((eq (car str) #\?)
         (if (alpha-char-p (cadr str))
           (expres (cdr str) :read-var t :var '(#\?))
           (cons '"Expected name after ? symbol" (expres (cdr str)))))
        ((and (alpha-char-p (car str)) read-var)
         (if (and (cadr str) (alpha-char-p (cadr str)))
           (expres (cdr str) :read-var t :var (cons (car str) var))
           (cons (list 'var (intern (coerce (reverse (mapcar #'char-upcase
                                                             (cons (car str)
                                                                   var)))
                                            'string)))
                 (expres (cdr str)))))
        (t (cons '"Unknown symbol" (expres (cdr str))))))
        
(defun lexer(str)
    (expres (normalize-list str)))

    
;_____________Syntax analyser_____________

(defun parser(str)
    (defun scan() (pop str))
    (defun unscan (el) (push el str))
    (expr)
    )

(defun swapper (lst)
"Swaps first and second elements of the list, 
 used to transform ((num 1) add (num 2)) into (add (num 1) (num 2))"
    (if (cddr lst)
        (cons (cadr lst) (cons (car lst) (cddr lst)))
        lst))

(defun expr()
    ;(print "expr")
    (make-node (term) (expr-list (scan))))
    
(defun expr-list(ts)
    ;(print (cons "expr-list" ts))
    (cond
        ((eq ts 'plus) (list 'add (make-node (term) (expr-list (scan)))))
        ((eq ts 'minus) (list 'sub (make-node (term) (expr-list (scan)))))
        (t (unscan ts) nil)))
        
(defun term()
    ;(print "term")
    (make-node (factor (scan)) (term-list (scan))))
    
(defun term-list(ts)
    ;(print (cons "term-list" ts))
    (cond
        ((eq ts 'mul) (list 'mul (make-node (term) (term-list (scan)))))
        ((eq ts 'div) (list 'div (make-node (term) (term-list (scan)))))
        (t (unscan ts) nil)))
    
(defun factor(ts)
    ;(print (cons "factor" ts))
    (cond
        ((and (listp ts) (eq (car ts) 'num)) (list 'expr 'num ts))
        ((and (listp ts) (eq (car ts) 'var)) ts)
;        ((symbolp ts) ts)
        (t (prog1 (expr) (scan)))))

(defun parse-expr (str)
    (parser (lexer str)))
      
(defun make-node (arg1 arg2)
"Forms and returns node of 2 expressions"
    (if arg2
        (cons 'expr (swapper (cons arg1 arg2)))
        arg1))

(defun parse-num (str)
  (let* ((lstr (first (lexer str)))
         (fst-lstr (first lstr))
         (snd-lstr (second lstr)))
    (if (and (symbolp fst-lstr)
             (case fst-lstr
               (num (numberp snd-lstr))
               (var (symbolp snd-lstr))))
      lstr
      (error "Not a valid number!"))))
      
;_____________Unit tests_____________
(defun test()
    (print (parse-expr (print "")))
    (print (parse-expr (print "1")))
    (print (parse-expr (print "1 + 2")))
    (print (parse-expr (print "1 + 2 + 3")))
    (print (parse-expr (print "1 + 2 * 3")))
    (print (parse-expr (print "1 * 2 + 3")))
    (print (parse-expr (print "1 + 2 * 3 + 4")))
    (print (parse-expr (print "1 + 2 + 3 * 4")))
    (print (parse-expr (print "1 * 2 + 3 + 4")))
    (print (parse-expr (print "(1 + 2)")))
    (print (parse-expr (print "3 - (1 + 2)")))
    (print (parse-expr (print "(1 + 2) - 3")))
    (print (parse-expr (print "(3 + 4) - (1 + 2)")))
    (print (parse-expr (print "(3 + 4) * (1 + 2)")))
    (print (parse-expr (print "(3 + 4) - 1 + 2")))
    (print (parse-expr (print "(3 + 4) * 1 + 2")))
    (print (parse-expr (print "(3 + 4) - 1 * 2")))
    (print (parse-expr (print "3 + (4 - 1) * 2")))
    (print (parse-expr (print "2 * (3 + 4) - 1")))
    (print (parse-expr (print "2 - (3 + 4)")))
    (print (parse-expr (print "(2 - (3 + 4)) * 1")))
    (print (parse-expr (print "(2 - (3 + 4)) * ?a")))
    t)
