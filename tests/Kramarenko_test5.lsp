
(defmacro aif (test then &optional else)
  `(let ((it ,test))
     (if it
       ,then
       ,else)))

(defmacro awhen (test &body body)
  `(let ((it ,test))
     (when it ,@body)))

(defmacro cut (&rest rest)
  (let ((symbols (gensym))
        (expand nil))
    (setf symbols nil)

    (labels ((%expander (rest)
      (let ((head (car rest)))
       (cond
        ((null head)
          nil)

        ((not (atom head))
          (cons (%expander head) (%expander (cdr rest))))

        ((eq '_ head)
         (let ((var (gensym)))
          (push var symbols)
          (cons var (%expander (cdr rest)))))

        (t
          (cons head (%expander (cdr rest))))))))

    (setf expand (%expander rest))
    (setf symbols (reverse symbols))
    `(lambda (,@symbols) ,expand))))

(defmacro calc (&rest rest)
  `(eval ,@rest))
