
(defun fmake-node (symbol func)
  (list symbol func))

(defun fget-node-symbol (node)
  (car node))

(defun fget-node-func (node)
  (cdr node))


(defun fmake-arc (weight from to)
  (list weight from to))

(defun fmake-tree (node-list arc-list)
  (list node-list arc-list))

(defun fget-node-list (tree)
  (car tree))

(defun fget-arc-list (tree)
  (second tree))


(defun fadd-node (tree node)
  (fmake-tree (cons node (fget-node-list tree))
              (fget-arc-list tree)))

(defun fadd-arc (tree arc)
  (fmake-tree (fget-node-list tree)
              (cons arc (fget-arc-list tree))))

(defun tree ()
  (fmake-tree (list (fmake-node 'a nil)
                    (fmake-node 'b nil)
                    (fmake-node 'c nil)
                    (fmake-node 'd nil))
              (list (fmake-arc 10 'a 'b)
                    (fmake-arc 5 'b 'c)
                    (fmake-arc 5 'b 'a)
                    (fmake-arc 7 'c 'd)
                    (fmake-arc 11 'e 'd))))

(defun in (elem list)
  (cond
    ((null list)
     nil)
    ((equalp elem (car list))
     T)
    (t (in elem (cdr list)))))

(defun connection-p2p (tree sym1 sym2)
  (remove-if-not (lambda (arc)
                    (and (in sym1 arc)
                         (in sym2 arc)))
                 (fget-arc-list tree)))

(defun connections (tree sym)
  (remove-if-not (lambda (arc)
                   (in sym arc))
                 (fget-arc-list tree)))

(defun sums (tree sym)
  (+ (mapcar #'car (connections tree sym))))
