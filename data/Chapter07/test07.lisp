(deftest "my-if"
  (and
    (= (my-if 1 2) 2)
	(= (my-if nil 2) nil)
	(= (my-if 1 2 3) 2)
	(= (my-if nil 2 3) 3)))

(deftest "my-cond"
  (and
	(= (my-cond (1 2 3)) 3)
	(= (my-cond ((oddp 2) 1) (t 2)) 2)))

(deftest "my-let"
  (and
    (my-let (a) nil nil (not a))
	(my-let ((a 1) (b 1)) (= a b))))

(deftest "my-let*"
  (and
    (my-let* (a) nil nil (not a))
	(my-let* ((a 1) (b a)) (= a b))))

(deftest "my-dotimes"
  (and
    (let (i 0)
	  (my-dotimes (j 5)
	    (incf i))
	  (= i 5))
    (let (i 0)
	  (my-dotimes (j 10 (= i 10))
	    (incf i)))))

(deftest "my-do*"
  (and
    (do* ((j 5 (1+ j))
	      (i (+ 10 j)))
	     ((= i j) t)
	  nil)))

(deftest "my-when"
 (equal (my-when (oddp (1+ (* 2 (random 10)))) "2n+1は奇数") "2n+1は奇数"))

(deftest "my-or"
  (and (eq (my-or t t t) t)
       (eq (my-or nil t) t)
       (eq (my-or nil) nil)))
