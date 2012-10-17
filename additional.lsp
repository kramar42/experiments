
(defun fmake-node (value childs)
  (cons value childs))

(defun fmake-arc (value from to)
  (fmake-node (fget-node (from))
              (append (value to)
                      (fget-children from))))

(defun fget-children (tree)
  (cdr tree))

