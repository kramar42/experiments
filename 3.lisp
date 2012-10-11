;
; В списке символов надо найти подсписок который содержит 2
; пересекающихся палиндрома максимальной длинны
;

; predicate. is element in list
(defun elem (e l)
  (cond
    ((null (car l)) nil)
    ((equalp e (car l)) t)
    (t (elem e (cdr l)))
  ))

; all list without last element
(defun init (lst)
  (if (null (cdr lst))
      nil
      (cons (car lst) (init (cdr lst)))
  ))

; returns combinations of sublists
; not permutations
(defun combinations (lst)
  (if (null (cdr lst))
    (list lst)
    (cons lst
          (append
           (combinations (init lst))
           (combinations (cdr lst))
          ))
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

; filter all elements-lists
; that are singletons or pairs
(defun filter (lst)
  (cond
    ((null lst) nil)
    ((< (length (car lst)) 3) (filter (cdr lst)))
    (t (cons (car lst) (filter (cdr lst))))))

(defun less (one two)
  (< (length one) (length two)))

; return sorted & stripped & fed combinations
(defun sublists (lst)
  (let ((subl (sort (strip (combinations lst))
                    #'less)))
    (filter (strip subl))))

; take n elements from lst
(defun take (lst n)
  (cond
    ((<= n 0) nil)
    ((null lst) nil)
    (t (cons (car lst) (take (cdr lst) (- n 1))))))

; predicate. is palindrom?
(defun is-palindrom (lst)
  (let ((len (/ (length lst) 2)))
  (equalp (take lst len) (take (reverse lst) len))))

; find subpalindrom from begining of list
(defun sub-palindrom (lst)
  (cond
    ((< (length lst) 3) nil)
    ((is-palindrom lst) lst)
    (t (sub-palindrom (init lst)))))

; return size of sub palindrom
(defun sub-palindrom-pos (lst)
  (length (sub-palindrom lst)))

; predicate. is there crossing
; palindroms from begining and end
; of list
(defun cross (lst)
  (> (+ (length (sub-palindrom lst))
        (length (sub-palindrom (reverse lst))))
     (length lst)))

; try cross on all sublists
(defun map-cross (lst)
  (mapcar (lambda (l) (if (cross l)
                        l
                        nil))
          (sublists lst)))

; take head while skipping
; all nils
(defun _head (lst)
  (cond
    ((null lst) nil)
    ((null (car lst)) (_head (cdr lst)))
    (t (car lst))))

; test case
(defun test ()
  (let* ((lst '(a b c c b a b c c a b))
         (cross (_head (map-cross lst))))
    (format t "In sequence:~%~S~%There is crossing palindroms:~%~S"
            lst cross)))
