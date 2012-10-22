
(defparameter hash (make-hash-table))

(defun add2hash (char pos hash)
  (let ((lst (gethash char hash)))
    (setf (gethash char hash)
          (cons pos lst)))
  hash)

(defun nils (range)
  (if (= range 0)
    nil (cons nil (nils (1- range)))))

(defun set-in-pos (elem pos lst)
  (if (= pos 0)
    (cons elem (cdr lst))
    (cons (car lst)
          (set-in-pos elem (1- pos)
                      (cdr lst)))))


(defun genhash (str hash &optional (pos 0))
  (if (null str)
    hash
    (genhash (cdr str)
             (add2hash (char (coerce str 'string)
                             pos)
                       pos
                       hash)
             pos)))

