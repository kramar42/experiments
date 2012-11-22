
(defun init (lst)
  (if (null (cdr lst))
      nil
      (cons (car lst) (init (cdr lst)))
  ))

(defun _last (lst)
  (if (null (cdr lst))
      (car lst)
      (_last (cdr lst))
  ))
  
(defun rev (lst)
  (if (null (cdr lst))
      (list (car lst))
      (cons (_last lst) (rev (init lst)))
  ))

(defun range (from to)
  (if (eq from to)
      nil
      (cons from (range (+ from 1) to))
  ))

(defun zip (f_lst s_lst)
  (if (or (null f_lst) (null s_lst))
      nil
      (cons
       (list (car f_lst) (car s_lst))
       (zip (cdr f_lst) (cdr s_lst))
      )
  ))

(defun tails (lst)
  (if (null (cdr lst))
      (list lst)
      (cons lst (tails (cdr lst)))
  ))

(defun inits (lst)
  (if (null (cdr lst))
      (list lst)
      (cons lst (inits (init lst)))
  ))

(defun combinations (lst)
  (if (null (cdr lst))
    (list lst)
    (cons lst
          (append
           (combinations (init lst))
           (combinations (cdr lst))
          ))
  ))

(defun appnd (f_lst s_lst)
  (if (null f_lst)
    s_lst
    (appnd (init f_lst) (cons (_last f_lst) s_lst))
  ))

(defun less (one two)
  (< (length one) (length two)))

(defun len (lst)
  (if (null lst)
      0
    (+ 1 (len (cdr lst)))
  ))

(defun elem (e l)
  (cond
    ((null (car l)) nil)
    ((equalp e (car l)) t)
    (t (elem e (cdr l)))
  ))

(defun repitings (out in)
  (cond
    ((null in) out)
    ((elem (car in) out) (repitings out (cdr in)))
    (t (repitings (cons (car in) out) (cdr in)))
  ))

(defun strip (lst)
  (repitings nil lst))

(defun sublists (lst)
  (reverse (sort
            (strip (combinations lst))
            #'less)
  ))

(defun inc-list (lst)
  (cond
    ((null lst) nil)
    (t (cons (funcall (lambda (x) (1+ x)) (car lst)) (inc-list (cdr lst))))
  ))

(defun inc-list2 (lst)
  (cond
    ((null lst) nil)
    (t (cons (1+ (car lst)) (inc-list (cdr lst))))
  ))

(defun del (e lst)
  (cond
    ((null lst) nil)
    ((equal e (car lst)) (del e (cdr lst)))
    (t (cons (car lst) (del e (cdr lst))))
  ))

(defun fldl (lst func)
  (if (null (cdr lst)) (car lst)
    (funcall func (car lst) (fldl (cdr lst) func))
  ))

(defun fldr (lst func)
  (if (null (cdr lst)) (car lst)
    (fldr (cons
           (funcall
            func
            (car lst)
            (second lst))
           (cddr lst))
          func)))

(defun filter (p lst)
  (cond
    ((null lst) nil)
    ((funcall p (car lst))
     (cons (car lst) (filter p (cdr lst))))
    (t (filter p (cdr lst)))
   ))

(defun make-adder (n)
  (lambda (x) (+ n x)))

(defun compose (elem flst)
  (if (null flst)
    elem
    (compose (funcall (car flst) elem) (cdr flst))
  ))

(defun triangle (n)
  (/ (* n (1+ n))
     2))

(defun mods (n)
  (mapcar (lambda (x)
             (mod n x))
          (range 1 n)))

(defun factors (n)
  (length (remove-if-not (lambda (x)
                   (eq 0 x))
          (mods n))))

(defun from (n)
  (cons n (from (1+ n))))


(defun foo2 (&key a b c)
  (list a b c))

(defparameter hash (make-hash-table :test #'equal))
(setf (gethash "Apple" hash) 3)
(setf (gethash "Bulb" hash) 5)

(defun my-format (id x)
  (format t "[~A]_> ~A~%" id x)
  x)

(defmacro nif (expr pos zero neg)
  `(case (truncate (signum ,expr))
    (1 ,pos)
    (0 ,zero)
    (-1 ,neg)))

(defmacro while (test &body body)
  `(do ()
       ((not ,test))
     ,@body))

(defmacro for ((var start stop) &body body)
  `(do ((,var ,start (1+ ,var))
        (limit ,stop))
       ((> ,var limit))
     ,@body))

(defun foo ()
  (let ((limit 0))
    (for (x 1 5) (princ x))
    limit))

(defmacro our-let (binds &rest rest)
  (let ((vars nil)
        (vals nil))
    (mapcar (lambda (binding)
              (push (car binding) vars)
              (push (second binding) vals))
            binds)
    (setf vars (reverse vars))
    (setf vals (reverse vals))
    `((lambda (,@vars) ,@rest) ,@vals)))

(defmacro a+ (&rest rest)
  (labels ((%expander (rest &optional args)
               (if (null rest)
                 `(+ ,@args)
                 (let ((temp (gensym)))
                   `(let* ((,temp ,(car rest)) (it ,temp))
                      ,(%expander (cdr rest) (cons temp args)))))))
    (%expander rest)))

(defmacro abbrev (short long)
  `(defmacro ,short (&rest rest)
     `(,',long ,@rest)))

(set-macro-character #\] (get-macro-character #\)))

(set-dispatch-macro-character #\# #\[
                              #'(lambda (stream char1 char2)
                                  (let ((accum nil)
                                        (pair (read-delimited-list #\]
                                                                   stream t)))
                                    (do ((i (ceiling (car pair)) (1+ i)))
                                        ((> i (floor (cadr pair)))
                                         (list 'quote (nreverse accum)))
                                      (push i accum)))))

(defun test ()
  (factors 10000))

(test)
