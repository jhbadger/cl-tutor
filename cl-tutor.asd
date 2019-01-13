#|
  This file is a part of cl-tutor project.
  Copyright (c) 2017 tcool (tcooooooool@gmail.com)
|#

#|
  Author: tcool (tcooooooool@gmail.com)
|#

(defsystem "cl-tutor"
  :version "0.1.0"
  :author "tcool"
  :license "LLGPL"
  :depends-on ("lem-ncurses")
  :components ((:module "src"
                :components
                ((:file "test")
                 (:file "cl-tutor"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "cl-tutor-test"))))
