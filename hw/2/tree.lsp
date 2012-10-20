
(defun fmake-node (val childs)
  (cons val childs))

(defun fget-node (node)
  (car node))

(defun fget-children (node)
  (cdr node))

#|


        1
       /|\
      2 7 11
     /| |\  \
    3 6 8 9  12
   /|     |    \
  4 5     10    13


|#

(defun tree ()
  (let ((tree
          (fmake-node 1
                      (list
                       (fmake-node 2 (list
                                      (fmake-node 3 (list
                                                     (fmake-node 4 nil)
                                                     (fmake-node 5 nil)))
                                      (fmake-node 6 nil)))
                       (fmake-node 7 (list
                                      (fmake-node 8 nil)
                                      (fmake-node 9 (list
                                                     (fmake-node 10 nil)))))
                       (fmake-node 11 (list
                                       (fmake-node 12 (list
                                                       (fmake-node 13 nil)))))
                      ))))
    tree
  ))

(defun traverse-post (func tree)
  (if (null (fget-children tree))
    (fmake-node
     (funcall func (fget-node tree))
     nil)
    (fmake-node
     (funcall func (fget-node tree))
     (mapcar (lambda (tree) (traverse-post func tree)) (fget-children tree)))
  ))

(defun traverse-pre (func tree fstop)
  (cond
    ((funcall fstop (fget-node tree)) nil)
    ((null (fget-children tree))
     (fmake-node
      (funcall func (fget-node tree))
      nil))
    (t
     (fmake-node
      (funcall func (fget-node tree))
      (remove nil
              (mapcar
               (lambda (tree) (traverse-pre func tree fstop))
               (fget-children tree))
      )))
  ))

; Обрезаем ветку с 7-ой вершиной
; (traverse-pre (lambda (x) x) (tree) (lambda (x) (eq 7 x)))
#|


        1
       / \
      2   11
     /|     \
    3 6   9  12
   /|     |    \
  4 5     10    13


|#

; Мне Володя успел дать еще одно дополнительное задание
; Композиция функций. В flst - список функций
; Пример использования
; (compose "string" '(length 1+))
(defun compose (elem flst)
  (if (null flst)
    elem
    (compose (funcall (car flst) elem) (cdr flst))
  ))

