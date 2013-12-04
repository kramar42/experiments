
(defun add2hash (key value hash)
  "Adds to hash key->value pair and returns new hash."
  (let ((lst (gethash key hash)))
    (setf (gethash key hash)
          (cons value lst)))
  hash)


(defun genhash* (str hash &optional (pos 0))
  "Generates hash from list of chars."
  (if (null str)
    hash
    (genhash* (cdr str)
             (add2hash (car str)
                       pos
                       hash)
             (1+ pos))))


(defun genhash (str &optional (hash (make-hash-table)))
  "Generates hash from string."
  (genhash* (coerce str 'list) hash))


(defun listhash (hash)
  "Prints hash in readable format."
  (maphash (lambda (key value)
             (print (format nil "[~A] = ~A"
                     key value)))
           hash)
  hash)


(defun clearhash (hash)
  "Clears hash and returns it."
  (maphash (lambda (k v)
             (remhash k hash))
           hash)
  hash)


(defun in (elem list)
  "Predicate. Is element in list."
  (if (remove-if-not (lambda (e)
                       (equal e elem))
                     list)
    t nil))


(defun swap (from to hash)
  "Swaps 2 chars from hash by their positions."
  (maphash (lambda (key value)
             (cond
               ; if letters are the same - pass
               ((and (in from value)
                     (in to value))
                nil)
               ; else - remove from list and append new value
               ((in from value)
                 (setf (gethash key hash)
                     (cons to
                           (remove from value))))
               ((in to value)
                (setf (gethash key hash)
                     (cons from
                           (remove to value))))))
           hash))


(defun strsize (hash)
  "Returns size of string, that stores in hash."
  (let ((size 0))
    (maphash (lambda (key value)
               (setf size
                     (+ size
                        (length value))))
             hash)
    size))


(defun getchar (hash pos)
  "Returns char by position from hash."
  (let ((result nil))
    (maphash (lambda (key value)
                (if (in pos value)
                  (setf result key)))
              hash)
    result))


(defun range (count &optional (start 0) (step 1))
  (loop repeat count for i from start by step collect i))


(defun genstr (hash)
  "Returns string, that stores in hash."
  (coerce (mapcar (lambda (pos)
                    (getchar hash pos))
                  (range (strsize hash)))
          'string))
