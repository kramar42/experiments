
(set-macro-character #\] (get-macro-character #\)))

(set-dispatch-macro-character #\# #\[
                              #'(lambda (stream sub-char arg)
                                  (let ((accum nil)
                                        (result nil)
                                        (input (read-delimited-list #\] stream)))
                                    (do ((token (car input) (car input)))
                                        ((null input)
                                         (progn
                                           (print accum)
                                           (push (process-accum accum) result)
                                           (list 'quote (nreverse result))))
                                      (if (eq token 'or)
                                        (progn
                                          (push (process-accum accum) result)
                                          (setf accum nil)
                                          (setf result (make-or
                                                        (car result)
                                                        (cadr result)))) 
                                        (push token accum))
                                      (setf input (cdr input))))))

(defun process-accum (accum)
  (cond
    ((eq (length accum) 2)
     (range (cadr accum) (car accum)))
    ((eq (length accum) 1)
     (range (car accum) 255))))


(defun make-or (list1 list2)
  (let ((result nil))
    (mapcar (lambda (elem) (if (not (member elem result))
                             (push elem result)))
            (append list1 list2))
    result))


(defun range (a b)
  (loop repeat (- b a -1) for i from a by 1 collect i))

