
(defun range (from to)
  (if (eq from to)
      nil
      (cons from (range (+ from 1) to))
  ))

(defparameter hash (make-hash-table))
(defun add2hash (char pos hash)
  (let ((lst (gethash char hash)))
    (setf (gethash char hash)
          (cons pos lst))))

(defun genhash (str)
  (mapcar (lambda (pos)
            (add2hash (char str pos) pos hash))
          (range 0 (length str))))

(defun nils (range)
  (if (= range 0)
    nil (cons nil (nils (1- range)))))

(defun set-in-pos (elem pos lst)
  (if (= pos 0)
    (cons elem (cdr lst))
    (cons (car lst)
          (set-in-pos elem (1- pos)
                      (cdr lst)))))

(defun bar (hash)
  (maphash (lambda (k v)
                (length v))
              hash))
