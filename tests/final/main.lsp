
(load "parser.lsp")
(load "pm.lsp")

(defun term-from-file (file-path)
	(with-open-file (file file-path)
		(let ((result nil))
			(do ((input (read-delimited-list #\; file nil) (read-delimited-list #\; file nil)))
				((null input)
					result)				
				(setf input (cdr (lexer (format nil "~A" input))))
				(setf input (reverse (cdr (reverse input))))
				(push (parser input) result)))))

(defun term-to-file (file-path term)
	(with-open-file (file file-path :direction :output :if-exists :supersede)
		(mapcar (lambda (%stmt%)
			(format file "~A~%" %stmt%) :stream file)
		term))
	T)

(defun deparser (stmt)
	(forthis stmt (
			(expr ?el ?er)
			(num ?n))

		(#! expr "?n" (format nil "~A" (second ?n)))
		(#! expr "(?el + ?er)" (format nil "(~A + ~A)" (deparser ?el) (deparser ?er)))
		(#! expr "(?el - ?er)" (format nil "(~A - ~A)" (deparser ?el) (deparser ?er)))
		(#! expr "?el * ?er" (format nil "~A * ~A" (deparser ?el) (deparser ?er)))
		(#! expr "?el / ?er" (format nil "~A / ~A" (deparser ?el) (deparser ?er)))))
