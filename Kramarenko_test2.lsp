
(defun make-mapcar-if (clanse func1 func2)
  (lambda (elem) (if (funcall clanse elem)
                   (funcall func1 elem)
                   (funcall func2 elem))))

;(setf test (make-mapcar-if #'oddp #'+ #'-))
;(mapcar test '(1 2 3 4))

(defun flatten (lst)
  (cond
    ((null lst) nil)
    ((atom lst) (list lst))
    (t (append (flatten (car lst)) (flatten (cdr lst))))
  ))
