
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
    (labels ((%expander (rest)
      (let ((head (car rest))
            (next nil))
       (cond
        ((null head)
          nil)

        ((not (atom head))
          (progn
            (print "HEAD")
            (setf next (%expander head))))

        ((eq '_ head)
         (let ((var (gensym)))
          (print "GENSYM")
          (push var symbols)
          (setf next var)))

        (t
          (setf next head)))

        (if (not (null head))
          `(cons ,next ,(%expander (cdr rest)))))))

    (setf symbols nil)
    (setf expand (%expander rest))
    (setf symbols (reverse symbols))
    `(lambda (,@symbols) ,expand))))

(defmacro calc (&rest rest)
  `(eval ,@rest))
