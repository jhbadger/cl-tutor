(defpackage :cl-tutor-test
  (:use :cl))
(in-package :cl-tutor-test)

(defvar *results* '())

(defmacro deftest (name &body forms)
  `(handler-case (push (list ',name (progn ,@forms) nil)
                       *results*)
     (error (err)
       (push (list ',name nil err)
             *results*))))

(defun test-initialize ()
  (setq *results* '()))

(defun test-finalize (stream)
  (let ((success t))
    (loop :for (name result err) :in (reverse *results*)
          :do (cond (result
                     (format stream "〇 ~A" name))
                    (t
                     (format stream "× ~A" name)))
              (terpri stream)
              (unless result
                (setf success nil)))
    success))
