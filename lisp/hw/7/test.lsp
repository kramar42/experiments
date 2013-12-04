(load "parser.lsp")
(load "pm.lsp")


(defun rewrite-term (term)
	(forthis term ((expr ?e) (num ?n))
		(#! expr "?n * ?e" 
			(format t "~%first rule:~%")
			#! expr "?e * ?n")
		(#! expr "?n + ?e"
			(format t "~%second rule:~%")
			(letvar ((expr ?nexpr #! expr "?n * ?n"))
				#! expr "?n + ?nexpr + 100"))))

#|
(print (rewrite-term #! expr "10 + 15 * (1 + 2 + 3)"))

(print (rewrite-term #! expr "10"))

(print (rewrite-term #! expr "15 * (1 + 2 + 3)"))
|#			
