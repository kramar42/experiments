
(defmacro aif (test then &optional else)
  `(let ((it ,test))
     (if it
       ,then
       ,else)))

(defmacro awhen (test &body body)
  `(let ((it ,test))
     (when it ,@body)))

(defmacro cut (&rest rest)
  (let ((symbols nil)
        (expand nil))

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

(defmacro calc (rest)
  (let ((vars nil))
    (labels (
      (%expander (rest)
        (case (car rest)
          ('let (%expand-let (cadr rest)))
          (+ (%expand+
            (cadr rest)
            (caddr rest)))))

      (%expand+ (first second)
        (+
          (%expander first)
          (%expander second)))

      (%expand-let (rest)
        (print "LET")
        (print rest)
        (mapcar
          (lambda (var)
            (push var vars))
          rest)
        `(,vars)))

    (%expander rest))))