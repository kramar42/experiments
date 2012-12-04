(defun signp (sym)
    (or (eq sym #\+) (eq sym #\*) (eq sym #\-) (eq sym #\/) (eq sym #\() (eq sym #\))))
    
(defun signer (sym)
    (or
        (and (eq sym #\+) 'add)
        (and (eq sym #\-) 'sub)
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
        (read-var
            (if (alpha-char-p (car str))
                (expres (cdr str) :read-var t :var (cons (car str) var))
                (cons (list 'var (intern (coerce (reverse (mapcar #'char-upcase
                                                                   var))
                                          'string)))
                 (expres str))))
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
          (expres (cdr str) :read-var t :var '(#\?)))))
                   
(defun lexer(str)
    (expres (normalize-list str)))

    
;_____________Syntax analyser_____________

(defun parser(str)
    (defun scan() (pop str))
    (defun unscan (el) (push el str))
    (expr))

(defun swapper (lst)
"Swaps first and second elements of the list, 
 used to transform ((num 1) add (num 2)) into (add (num 1) (num 2))"
    (if (cddr lst)
        (cons (cadr lst) (cons (car lst) (cddr lst)))
        lst))

(defun expr()
    (make-node (term) (expr-list (scan))))
    
(defun expr-list(ts)
    (cond
        ((eq ts 'add) (list 'add (make-node (term) (expr-list (scan)))))
        ((eq ts 'sub) (list 'sub (make-node (term) (expr-list (scan)))))
        (t (unscan ts) nil)))
        
(defun term()
    (make-node (factor (scan)) (term-list (scan))))
    
(defun term-list(ts)
    (cond
        ((eq ts 'mul) (list 'mul (make-node (term) (term-list (scan)))))
        ((eq ts 'div) (list 'div (make-node (term) (term-list (scan)))))
        (t (unscan ts) nil)))
    
(defun factor(ts)
    (cond
        ((and (listp ts) (eq (car ts) 'num)) (list 'expr 'num ts))
        ((and (listp ts) (eq (car ts) 'var)) ts)
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

(set-macro-character #\! (get-macro-character #\)))
(set-dispatch-macro-character #\# #\!
    (lambda (stream sub-char arg)
        (let ((cmd (read stream t nil t))
            (string (lexer (read stream t nil t))))

        (defun scan() (pop string))
        (defun unscan (el) (push el string))
        `(,cmd))))
