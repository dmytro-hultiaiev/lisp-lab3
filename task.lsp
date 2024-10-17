(defun swap (lst flag)
  (cond
    ((or (null lst) (null (rest lst)))
     (values lst flag))

    ((> (first lst) (second lst))
     (multiple-value-bind (rest-of-list new-flag) (swap (cons (first lst) (rest (rest lst))) t)
       (values (cons (second lst) rest-of-list) new-flag)))

    (t (multiple-value-bind (rest-of-list new-flag) (swap (rest lst) flag)
         (values (cons (first lst) rest-of-list) new-flag)))))

(defun sort-func (lst)
    (multiple-value-bind (new-list flag) (swap lst nil)
      (if flag
          (sort-func new-list)
          new-list)))

(defun check-first-function (name input expected)
    "Execute `my-reverse' on `input', compare result with `expected' and print
    comparison status"
    (format t "~:[FAILED~;passed~] ~a~%"
        (equal (sort-func input) expected)
        name))

(defun test-first-function ()
    (check-first-function "test 1" '(5 3 4 1 2) '(1 2 3 4 5))  
    (check-first-function "test 2" '(1 2 3 4 5) '(1 2 3 4 5)) 
    (check-first-function "test 3" '(1 1 1 1 1) '(1 1 1 1 1))
    (check-first-function "test 4" '(2 2 3 3 1) '(1 2 2 3 3))
    (check-first-function "test 5" nil nil))

(defun sort-imper(lst)
    (let ((copy (copy-list lst)) (r (- (length lst) 1)) (flag t))
    
    (do () ((not flag))
      (setf flag nil)
      (dotimes (i r)
        (when (> (nth i copy) (nth (1+ i) copy))
          (let ((b (nth i copy)))
            (setf (nth i copy) (nth (1+ i) copy))
            (setf (nth (1+ i) copy) b)
            (setf flag t)))))
    
    copy    
))  

(defun check-second-function (name input expected)
    "Execute `my-reverse' on `input', compare result with `expected' and print
    comparison status"
    (format t "~:[FAILED~;passed~] ~a~%"
        (equal (sort-imper input) expected)
        name))

(defun test-second-function ()
    (check-second-function "test 1" '(5 3 4 1 2) '(1 2 3 4 5))  
    (check-second-function "test 2" '(1 2 3 4 5) '(1 2 3 4 5)) 
    (check-second-function "test 3" '(1 1 1 1 1) '(1 1 1 1 1))
    (check-second-function "test 4" '(2 2 3 3 1) '(1 2 2 3 3))
    (check-second-function "test 5" nil nil))