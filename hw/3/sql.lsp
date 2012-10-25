
(defvar user nil)
(defstruct user-row
  id
  name
  surname
  age)

(defvar car nil)
(defstruct car-row
  id
  auto
  color
  year)

(defvar relations nil)
(defstruct relations-row
  id3
  id1
  id2)

(defvar result nil)
(defstruct result-row
  id
  id1
  name
  surname
  age
  id2
  auto
  color
  year)


(defun read-lines (file)
  "Reads and returns list of all lines from file."
  (with-open-file (stream file)
    (loop
          for line = (read-line stream nil 'eof)
          until (eq line 'eof)
          collect line)))


(defun split (str delim)
  "Returns list of splitted substrings."
  ; position of first occurrence delim in str
  (let ((position (search delim str)))
    ; if there is no occurrences
    (if (null position)
      ; return str
      (list str)
      ; return that substring and recursively call split
      (cons (subseq str 0 position)
          (split (string-trim " " (subseq str (1+ position)))
                 delim)))))


(defun make-request (file fields)
  (mapcar (lambda (line)
            (mapcar #'list fields
                    (split line ",")))
          (read-lines file)))


(defun make-table (request table)
  (mapcar (lambda (row)
            (mapcar (lambda (column)
                      (concatenate 'string table (car column)))
                    row))
          request))

(defun test ()
  (make-table (make-request "user.txt"
                            '("id" "name" "surname" "age"))
              "user-row-"))

(defun make-select (file1 file2 file3)
  (read-words "user.txt"))


;(lambda (res-file &key name surname age auto color year))
