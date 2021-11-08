(require 'aas)
(require 'yasnippet)

(setq +snippet-defaults
      (list))

(require 'aas)
(add-hook 'emacs-lisp-mode-hook #'aas-activate-for-major-mode)

(defun +snippet-cond (condition)
  "Transform CONDITION nil or t to a function that always returns t."
  (if (functionp condition)
      condition
    (lambda ()
      t)))

(defun +snippet-def (mode &rest args)
  (let ((auto nil)
        (cond (+snippet-cond nil)))
    (while args
      (setq item (pop args))
      (if (keywordp item)
          (pcase item
            (:auto (setq auto (pop args)))
            (:cond (setq cond (+snippet-cond (pop args))))
            (_ (error "Unknown keyword: %s" item)))
        (let ((key item)
              (template (pop args)))
          (if auto
              (aas-set-snippets mode
                :cond cond
                key (if (functionp template)
                          template
                        `(lambda () (interactive) (yas-expand-snippet ,template))))
            (yas-define-snippets mode `((,key ,template nil (,cond))))))))))

(provide 'sfp)
