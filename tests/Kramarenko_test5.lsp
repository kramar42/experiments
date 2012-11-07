
(defmacro aif (test then &optional else)
  `(let ((it ,test))
     (if it
       ,then
       ,else)))

(defmacro awhen (test &body body)
  `(let ((it ,test))
     (when it ,@body)))

(defmacro cut (&rest rest)
  (let ((symbols nil))
    (labels ((%expander (rest)
             (if (equalp '_ (car rest))
               (let ((var (gensym)))
                 (push var symbols)
                 `(cons ,var ,(%expander (cdr rest))))
               `(list ,rest))))
    (%expander rest))))

(defmacro sum (&rest rest)
  `(+ ,@rest))

(defmacro calc (&rest rest)
  `(eval ,@rest))
