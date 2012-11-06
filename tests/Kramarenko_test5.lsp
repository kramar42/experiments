
(defmacro aif (test then &optional else)
  `(let ((it ,test))
     (if it
       ,then
       ,else)))

(defmacro awhen (test &body body)
  `(let ((it ,test))
     (when it ,@body)))

(defmacro cut (&rest rest)
  (labels ((%expander (rest)
             (if (equalp '_ (car rest))
               (let ((var (gensym)))
                 `(cons ,var ,(%expander (cdr rest))))
               `(,@rest))))
    (%expander rest)))
