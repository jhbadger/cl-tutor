(deftest "my-xor"
  (and
    (let ((a 1)) (xor 1 nil (setq a nil)) a)
    (= (xor nil 1) 1)
	(= (xor nil (= 1 2) 2) 2)
	(eql (xor nil (= 1 2)) nil)
	(eql (xor 1 1) nil)))

(deftest "my-aif"
  (and
   (null (my-aif (oddp 2) (1+ it)))
   (= 2 (my-aif (oddp 1) (1+ it) it))))

(deftest "my-alambda"
  (= ((my-alambda (n) (if (zerop x n) n (+ n (self (1- n))))) 10) 55))

(deftest "my-whichever"
    (or (= 1 (my-whichever 1 2 3))
	(= 2 (my-whichever 1 2 3))
	(= 3 (my-whichever 1 2 3))))

(deftest "my-prime-numbers"
    (and
     (flet ((primep (p) (loop :for i :from 2 :to (isqrt p) :never (zerop (mod p i)))))
       (every #'primep (my-prime-numbers 10)))
     (= 4 (length (my-prime-numbers 10)))))
