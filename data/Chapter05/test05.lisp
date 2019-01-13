(deftest "add1"
  (= (add1 10) 11))

(deftest "add2"
  (= (add2 1 9) 10))

(defun princ-check-test()
  (let ((t-cool
	 (with-output-to-string(*standard-output*)
			       (princ "Hello"))))
    t-cool))

(deftest "princ-check"
    (equal (princ-check) (princ-check-test)))

(deftest "power"
  (= (power 3 4) (expt 3 4)))

(deftest "use-funcall"
    (equal (use-funcall) '(1 2 3 4 5 6)))

(deftest "use-apply"
    (equal (use-apply) '(1 2 3 4 5 6)))

(deftest "use-reduce"
    (equal (use-reduce) '(1 2 3 4 5 6)))

(deftest "each1+" (equal (each1+ '(1 2 3)) '(2 3 4)))

(deftest "opt-args"
  (equal (opt-args 0) '(0 1 2))
  (equal (opt-args 0 100) '(0 100 2))
  (equal (opt-args 0 100 200) '(0 100 200))
  (equal (opt-args 0 nil 1000) '(0 nil 1000)))

(deftest "my-length" (= (my-length '(1 2 3)) 3))

(deftest "use-format"
    (format nil "hello, world"))

(deftest "format-nil" (equal (format-nil 10) "He is 10 years old."))

(deftest "eval-string" (= (eval-string "(+ 99 1)") 100))

(deftest "backqt"
 (equal (backqt 1 2 3 4 5) '(1 2 3 4 5)))

(deftest "tax" (equal (tax 1000) "税抜価格は1,000円、税込価格は1,080円です。"))

(deftest "balance" (equal (balance 100000 8900) "預金100,000円で、8,900円の出費がありました。残高は91,100円です。"))

(deftest "staffs"
 (and
  (equal (staffs) "Hiroki、Mayumi、Masashiが出勤予定です。")
  (equal (staffs "Ichiro") "Ichiro、Mayumi、Masashiが出勤予定です。")
  (equal (staffs "Ichiro" "Goro") "Ichiro、Goro、Masashiが出勤予定です。")
  (equal (staffs "Ichiro" "Goro" "Saburo") "Ichiro、Goro、Saburoが出勤予定です。")))

(deftest "belongings"
  (equal (belongings "PC" "実践CL") "研修で必要なものは、PC 実践CL です。"))

(deftest "login"
 (and (equal (login :name "tcool" :password 0101) "login成功")
      (equal (login :name "tcool" :password 0102) "login失敗")))

(deftest "fizzbuzz"
 (equal (fizzbuzz 30) "FizzBuzz") )

	
(deftest "print-fizzbuzz"
 (equal  (print-fizzbuzz 15) "1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13 14 FizzBuzz ") )
