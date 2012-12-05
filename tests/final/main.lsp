
(load "parser.lsp")
(load "pm.lsp")

(defun term-from-file (file-path)
	(with-open-file (file file-path)
		(do ((input (read-delimited-list #\; file nil) (read-delimited-list #\; file nil)))
			((eq 'eof input)
				T)
			(print input))))