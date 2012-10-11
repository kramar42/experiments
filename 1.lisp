;
; Убрать повторение елементов из списка
;

; predicate. is element in list
(defun elem (e l)
  (cond
    ((null (car l)) nil)
    ((eq e (car l)) t)
    (t (elem e (cdr l)))
  ))

; remove repitings
(defun repitings (out in)
  (cond
    ((null in) out)
    ((elem (car in) out) (repitings out (cdr in)))
    (t (repitings (cons (car in) out) (cdr in)))
  ))

; simpler interface for repitings
(defun strip (lst)
  (repitings nil lst))

; test case
(defun test ()
  (let ((e 'c)
        (l '(a b c d))
        (in '(a b c d e a f e f c b)))
    (format t "Element ~S in list ~S: ~S~%~%" e l (elem e l))
    (format t "Before stripping~S~%After stripping ~S~%"
            in (strip in))
  ))
