(deftest "use-let"
    (equal (use-let) "x is 10") )

(deftest "use-let*"
    (equal (use-let* 9999) "999 + 1000 = 1999") )

(deftest "*single-clozure*"
  (progn
    (let ((result1 (funcall *single-clozure*))
	  (result2 (funcall *single-clozure*)))
      (= (1+ result1) result2))))

(deftest "*multiple-clozure*" 
  (let ((result1 (funcall (first *multiple-clozure*)))
	(result2 (funcall (second *multiple-clozure*))))	 
    (= result2 (1- result1))))
