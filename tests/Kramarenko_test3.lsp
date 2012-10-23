
(defparameter hash (make-hash-table))

(defun add2hash (key value hash)
  "Adds to hash key->value pair and returns new hash."

  (let ((lst (gethash key hash)))
    (setf (gethash key hash)
          (cons value lst)))
  hash)


(defun genhash (str &optional (hash hash)
                              (pos 0))
  "Generates hash from list of chars."

  (if (null str)
    hash
    (genhash (cdr str)
             (add2hash (car str)
                       pos
                       hash)
             (1+ pos))))


(defun genhash* (str &optional (hash hash))
  "Generates hash from string."
  (genhash (coerce str 'list) hash))


(defun listhash (&optional (hash hash))
  "Prints hash in readable format."
  (maphash (lambda (key value)
             (print (format nil "[~A] = ~A"
                     key value)))
           hash)
  hash)


(defun set-in-pos (elem pos lst)
  "Sets element in lst position."
  (cond
    ; this is right positin
    ((= pos 0)
     (cons elem (cdr lst)))
    ; list is smaller than pos value
    ((null (cdr lst)) lst)
    (t (cons (car lst)
          (set-in-pos elem (1- pos)
                      (cdr lst))))))


(defun set-in-pos* (elem pos lst l r)
  "Sets element in lst position.
l, r - left and right positions of current list borders.
If we need - increasing size of list by adding nils to left
or right size of lst."

  (cond
    ((< pos l)
     (list (set-in-pos elem 0
                 (append (nils (- l pos)) lst))
           pos r))
    ((> pos r)
     (list (set-in-pos elem (- pos l)
                 (append lst (nils (- pos r))))
           l pos))
    (t
     (list (set-in-pos elem (- pos l) lst)
           l r))))


(defun nils (range)
  "Returns list of nils range size."
  (if (= range 0)
    nil (cons nil (nils (1- range)))))


(defun strsize (hash)
  "Returns size of string, that stores in hash."
  (let ((size 0))
    (maphash (lambda (key value)
               (setf size
                     (+ size
                        (length value))))
             hash)
    size))


(defun genstr (&optional (hash hash))
  "Generates string from hash.
Creates list of nils needed size and manipulates with it."

  (setf str (nils (strsize hash)))
  (maphash (lambda (key values)
             (mapcar (lambda (value)
                       (setq str (set-in-pos key value str)))
                     values))
           hash)
  (coerce str 'string))


(defun genstr* (&optional (hash hash))
  "Generates string from hash.
Creates empty list and then (by demand) increases it's size."

  (let* (
        (half (floor (/ (strsize hash) 2)))
        (l half)
        (r half)
        (str '(nil)))
    (maphash (lambda (key values)
               (mapcar (lambda (value)
                         (let ((result
                                 (set-in-pos* key value str l r)))
                           (setf str (first result))
                           (setf l (second result))
                           (setf r (third result))))
                       values))
             hash)
    (coerce str 'string)))


(defun clearhash (&optional (hash hash))
  "Cleares hash's containing."
  (maphash (lambda (key value)
             (remhash key hash))
           hash))


(defun test (&optional (strlist
                        (list "hello"
                              "test"
                              "lllll"
                              "qwerty"
                              "jamsdlfzqwerqans"
                              "extra long string   sdflkqjwelfkjalskdfqnvcvqwjeklfjqwvkm,zcxvmqlwekjflqkwlefkmz.v/,wjflqkwjelfkwamevf.,svmlwkejlqfwkjeflqkwneflnasdgf;jjqlkwjfoqwiejfskdjflqjweofijslkdfajqwioejfsjdlfkjqweoifjweklfjasldkfjqlwejfflfklwjeofijqweofkjaslkdfjqiowejgoiqwjgklasjflkjqweopifjwqopeifjlkesdjflaksejoff")))
  (mapcar (lambda (str)
            (format t "Testing string ~A..." str)
            (if (equal str
                       ; genstr, genstr*
                       ; both are working functions
                       (genstr* (genhash* str)))
              (format t "passed~%")
              (format t "failed~%"))
            (clearhash hash))
          strlist)
  nil)
