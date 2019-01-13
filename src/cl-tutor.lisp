(defpackage :cl-tutor
  (:use :cl :lem)
  (:export :cl-tutor :start))
(in-package :cl-tutor)

(defparameter *data-directory*
  (asdf:system-relative-pathname :cl-tutor #p"data/"))

(defparameter *progress-file*
  (merge-pathnames "progress.sexp" *data-directory*))

(defparameter *confirm-file*
  (asdf:system-relative-pathname :cl-tutor #p"src/confirm.lisp"))

(defparameter *menu-buffer-name* "*cl-tutor*")

(defvar *initialized* nil)
(defvar *courses* nil)
(defvar *current-chapter*)

(defmacro with-muffle-warning (&body body)
  `(let ((*standard-output* (make-broadcast-stream))
         (*error-output* (make-broadcast-stream)))
     ,@body))

(defstruct course name chapters)
(defstruct chapter
  name
  content
  ex-file
  test-file
  clear)

(defun read-chapter (chapter)
  (let* ((name (getf chapter :name))
         (content (getf chapter :content))
         (chapter-directory
           (merge-pathnames (format nil "Chapter~A/" name)
                            *data-directory*))
         (files (uiop:directory-files chapter-directory))
         (ex-file
           (find-if (lambda (pathname) (ppcre:scan "^ex" (pathname-name pathname))) files))
         (test-file
           (find-if (lambda (pathname) (ppcre:scan "^test" (pathname-name pathname))) files))
         (clear (getf chapter :clear)))
    (make-chapter :name name
                  :content content
                  :ex-file ex-file
                  :test-file test-file
                  :clear clear)))

(defun read-chapters (chapters)
  (mapcar #'read-chapter chapters))

(defun read-course (form)
  (optima:ematch form
    ((list* :course name chapters)
     (make-course :name name :chapters (read-chapters chapters)))))

(defun load-progress-file (&optional (filename *progress-file*))
  (with-open-file (in filename)
    (let ((eof '#:eof))
      (loop :for x := (read in nil eof)
            :until (eq x eof)
            :collect (read-course x)))))

(defun save-progress-file (courses &optional (filename *progress-file*))
  (with-open-file (out filename
                       :direction :output
                       :if-exists :supersede
                       :if-does-not-exist :create)
    (dolist (course courses)
      (pprint (list* :course (course-name course)
                     (mapcar (lambda (chapter)
                               (list :name (chapter-name chapter)
                                     :content (chapter-content chapter)
                                     :clear (chapter-clear chapter)))
                             (course-chapters course)))
              out))))

(defun initialize-window-layout (spec)
  (labels ((f (window spec)
             (cond ((bufferp spec)
                    (setf (current-window) window)
                    (switch-to-buffer spec))
                   (t
                    (destructuring-bind (split-type left-spec right-spec) spec
                      (ecase split-type
                        (:horizontal
                         (split-window-horizontally window))
                        (:vertical
                         (split-window-vertically window)))
                      (let ((left-window window)
                            (right-window (get-next-window window)))
                        (f left-window left-spec)
                        (f right-window right-spec)))))))
    (delete-other-windows)
    (let ((window (current-window)))
      (f window spec)
      (setf (current-window) window))))

(defun load-chapter (chapter)
  (setf *current-chapter* chapter)
  (initialize-window-layout
   (list :horizontal
         (find-file-buffer (chapter-ex-file chapter))
         (lem-lisp-mode:repl-buffer))))

(define-major-mode menu-mode nil
    (:name "Menu"
     :keymap *menu-mode-keymap*))

(define-key *menu-mode-keymap* "C-m" 'cl-tutor-select-chapter)
(define-key *menu-mode-keymap* "Tab" 'cl-tutor-next-chapter)
(define-key *menu-mode-keymap* "Shift-Tab" 'cl-tutor-previous-chapter)
(define-key *menu-mode-keymap* "n" 'cl-tutor-next-chapter)
(define-key *menu-mode-keymap* "p" 'cl-tutor-previous-chapter)
(define-key *menu-mode-keymap* "C-n" 'cl-tutor-next-chapter)
(define-key *menu-mode-keymap* "C-p" 'cl-tutor-previous-chapter)
(define-key *menu-mode-keymap* "j" 'cl-tutor-next-chapter)
(define-key *menu-mode-keymap* "k" 'cl-tutor-previous-chapter)
(define-key *menu-mode-keymap* "Down" 'cl-tutor-next-chapter)
(define-key *menu-mode-keymap* "Up" 'cl-tutor-previous-chapter)
(define-key *menu-mode-keymap* "Right" 'cl-tutor-next-chapter)
(define-key *menu-mode-keymap* "Left" 'cl-tutor-previous-chapter)

(define-command cl-tutor-select-chapter () ()
  (load-chapter (text-property-at (current-point) :chapter)))

(define-command cl-tutor-next-chapter () ()
  (move-to-next-chapter (current-point)))

(define-command cl-tutor-previous-chapter () ()
  (move-to-previous-chapter (current-point)))

(defun move-to-next-chapter (point)
  (next-single-property-change point :chapter)
  (unless (text-property-at point :chapter)
    (next-single-property-change point :chapter)))

(defun move-to-previous-chapter (point)
  (previous-single-property-change point :chapter)
  (unless (text-property-at point :chapter)
    (previous-single-property-change point :chapter)))

(defun search-chapter-from-name (name)
  (let ((p (buffer-start (current-point))))
    (loop
      (move-to-next-chapter p)
      (let ((chapter (text-property-at p :chapter)))
        (cond ((null chapter)
               (return nil))
              ((equal name (chapter-name chapter))
               (return chapter)))))))

(defun make-courses-menu-buffer (courses)
  (let* ((buffer (make-buffer *menu-buffer-name*))
         (p (buffer-point buffer)))
    (change-buffer-mode buffer 'menu-mode)
    (setf (buffer-read-only-p buffer) t)
    (with-buffer-read-only buffer nil
      (erase-buffer buffer)
      (dolist (course courses)
        (insert-string p (course-name course) :attribute (make-attribute :bold-p t))
        (insert-character p #\newline)
        (dolist (chapter (course-chapters course))
          (insert-string p (if (chapter-clear chapter) " ✓ " "   "))
          ;(insert-string p (chapter-name chapter))
          ;(insert-string p " ")
          (insert-string p
                         (chapter-content chapter)
                         :attribute (make-attribute :underline-p t)
                         :chapter chapter)
          (insert-character p #\newline))
        (insert-character p #\newline)))
    buffer))

(defun top-menu (courses)
  (let ((buffer (make-courses-menu-buffer courses)))
    (initialize-window-layout buffer)
    (buffer-start (current-point))
    (cl-tutor-next-chapter)))

(defun start-cl-tutor ()
  (unless *initialized*
    (setf *initialized* t)
    (lem-lisp-mode:start-lisp-repl)
    (lem-lisp-mode:lisp-set-package "CL-TUTOR-TEST")
    (lem-lisp-mode:clear-repl)
    (setf *courses* (load-progress-file)))
  (top-menu *courses*))

(defun success ()
  (setf (chapter-clear *current-chapter*) t)
  (top-menu *courses*)
  (search-chapter-from-name (chapter-name *current-chapter*))
  (cl-tutor-next-chapter)
  (save-progress-file *courses*))

(defun run-test (test-file)
  (cl-tutor-test::test-initialize)
  (with-muffle-warning (load test-file))
  (let* ((out (make-string-output-stream))
         (result (cl-tutor-test::test-finalize out)))
    (values result (get-output-stream-string out))))

(define-command cl-tutor-run-test () ()
  (macrolet ((safe-form (messagep form)
               `(handler-case
                    (with-muffle-warning ,form)
                  (error (err)
                    (when ,messagep (lem-lisp-mode::write-string-to-repl (format nil "~%~%ERROR: ~A" err)))
                    (return-from cl-tutor-run-test)))))
    (let ((ex-file (chapter-ex-file *current-chapter*))
          (test-file (chapter-test-file *current-chapter*)))
      (alexandria:when-let ((buffer
                             (find-if (lambda (buffer)
                                        (uiop:pathname-equal (buffer-filename buffer) ex-file))
                                      (buffer-list))))
        (write-to-file buffer ex-file))
      (safe-form nil (load ex-file))
      (multiple-value-bind (test-result output-text) (run-test test-file)
        (lem-lisp-mode::clear-repl)
        (lem-lisp-mode::write-string-to-repl (string #\newline))
        (lem-lisp-mode::write-string-to-repl output-text)
        (when test-result
          (lem-lisp-mode:listener-eval (uiop:read-file-string *confirm-file*)))))))

(define-command cl-tutor () ()
  (start-cl-tutor))

(define-key lem-lisp-mode:*lisp-mode-keymap* "F5" 'cl-tutor-run-test)

(defun start ()
  (lem:lem '(cl-tutor)))
