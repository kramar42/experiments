;
; Сортировка вставкой. Через рекурсию и циклы.
;

; recursive find minimal
(defun rec-min (lst)
  (cond
   ((null (cdr lst))
    (list (car lst) nil))

   ((>
     (car lst)
     (first (rec-min (cdr lst))))
    (list
     (first (rec-min (cdr lst)))
     (cons
      (car lst)
      (second (rec-min (cdr lst)))
      )))

   (t
    (list (car lst) (cdr lst)))))

; recurseve sort
(defun rec-sort (lst)
  (let ((mlst (rec-min lst)))

  (cond
   ((null (cdr lst)) lst)

   (t
    (cons
     (first mlst)
     (rec-sort (second mlst)))))))

; loop find minimal
(defun loop-min (lst)
  (let ((m (car lst)))

    (loop for x in (cdr lst)
          if (< x m)
	    do (setq m x))
    m))

; del first occurence element from list
(defun del (e lst)
  (cond
    ((null lst) nil)
    ((equalp e (car lst)) (cdr lst))
    ((null (cdr lst)) lst)
    (t (cons (car lst) (del e (cdr lst))))))

; loop sort
(defun loop-sort (lst)
  (let ((m (car lst))
	(result lst))

    (loop while (not (null result))
          do (setq m (loop-min result))
          collect m
          do (setq result (del m result)))))

; test case
(defun test ()
  (let* (
        (l '(7 5 4 9 8 1 6 0 2 3)))
    (format t "Simple number list: ~S~%" l)
    (format t "Recursion sort: ~S~%" (rec-sort l))
    (format t "Loop sort: ~S~%" (loop-sort l))
  ))
