 ;; Name: Mary Kait Heeren
 ;; HW: HW 3
 ;; Language: LISP
 ;; Date: November 7th, 2024ter
 ;; Section: CSCI 4342 - 001
 ;; Sources: Stack Overflow, Common Lisp Docs, A Quick Introduction to Lisp and Geeks for Geeks
 
 ;; global variable
 (defparameter storeArray nil)
 
 ;; splits a string based on a delimiter, stores in result then reverse result for ordering
 (defun split-string (string delimiter)
  (let ((start 0)
  (result '()))
  (loop for end = (position (aref delimiter 0) string :start start)
  while end
  do (push (subseq string start end) result)
  (setf start (1+ end)))
  (push (subseq string start) result)
  (nreverse result)))
 
 ;; read in input and store into a list
 (defun read-csv (file-path)
  (with-open-file (stream file-path)
  (let ((line (read-line stream nil)))
  ;;split by commas
  (mapcar #'parse-integer (split-string line ",")))))

 
  ;; assign the list to storeArray
  (setf storeArray (read-csv "poly_numbers.txt"))
 
  ;; variable for polynomial
  (defparameter x 'x)
 
 
  ;; construct polynomial (prints polynomial by writing given coefficient, expt then specifying the power of the exponent as i is iterated)
  (defparameter polynomial
  (loop for coefficient in storeArray
  for i from 0
  collect `(* ,coefficient (expt ,x ,i))))
 
  ;; print
  (format t "Your polynomial is: ")
  (write polynomial)
  (format t "Enter a value for X: ")
 
  (terpri)
 
  ;; solve polynomial
  (defun solve-poly ()
  (let ((user-x (read)))
  (setf x user-x)
  (let ((result (apply #' + (mapcar #'eval polynomial))))
  (format t "Result: ~a~%" result))))
 
  ;; call program
  (solve-poly)