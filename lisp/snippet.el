(setq +snippet-defaults
      (list))

(require 'aas)
(add-hook 'emacs-lisp-mode-hook #'aas-activate-for-major-mode)

(defun +snippet-def (mode key template &rest plist)
  (let* ((plist (append plist +snippet-defaults))
         (auto (plist-get plist :auto)))
    (if auto
        (aas-set-snippets mode key
                          `(lambda () (interactive)
                             (yas-expand-snippet ,template)))
      (yas-define-snippets mode `((,key ,template))))))

(+snippet-def 'emacs-lisp-mode "#3" "hello4" :auto)

(+snippet-def 'emacs-lisp-mode "#4" "hello4" :auto)

(defun +snippet-def-multi (snippets)
  (dolist (snippet snippets)
          (apply #'+snippet-def snippet)))

(+snippet-def-multi
 '((emacs-lisp-mode "#5" "bye2")
   (emacs-lisp-mode "#6" "thrye" :auto)))
