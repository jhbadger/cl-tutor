(when (y-or-n-p "ミッションクリア。一覧に戻りますか？")
  (swank:eval-in-emacs `(funcall
                         (intern "SUCCESS"
                                 (find-package '#:cl-tutor)))
                       t))
