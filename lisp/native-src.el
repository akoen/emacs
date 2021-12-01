(straight-use-package 'polymode)
(straight-use-package 'jupyter)
(require 'polymode)
(require 'jupyter)
(require 'ob-jupyter)

(defun poly-org-mode-matcher ()
  (let ((case-fold-search t))
    (when (re-search-forward "#\\+begin_\\(src\\|example\\|export\\) +\\([^ \t\n]+\\)" (point-at-eol) t)
      (let ((lang (match-string-no-properties 2)))
        (or (cdr (assoc lang org-src-lang-modes))
            lang)))))

(setq poly-org-mode-head-matcher "^[ \t]*#\\+begin_\\(src\\|example\\|export\\) .*\n"
      poly-org-mode-tail-matcher "^[ \t]*#\\+end_\\(src\\|example\\|export\\)")

(defun poly-org-jupyter-initialize ()
  "Associate poly-org major-mode jupyter buffer with src block session."
  (message "jupyter initialized")
  (jupyter-repl-interaction-mode 1)
  (jupyter-repl-associate-buffer
   (with-current-buffer (pm-base-buffer)
     (org-babel-initiate-session))))

(setq poly-org-header-params nil)
(defun poly-org-init-block (_ this-buf)
  ;; HACK: For some reason, font lock does not seem to be enabled in src blocks.
  (font-lock-mode 1)
  (org-indent-mode -1)

  ;; TODO This should probably not be done right when point first enters block
  "Move src block parameters to innermode specific locals.
Used in :switch-buffer-functions slot."
  (jupyter-org-when-in-src-block (poly-org-jupyter-initialize))
  (with-current-buffer (pm-base-buffer)
    (let* ((params (nth 2 (org-babel-get-src-block-info t)))
           (session (cdr (assq :session params))))
      (with-current-buffer this-buf
        (setq-local poly-org-header-params params)))))

(define-hostmode poly-org-hostmode
  :mode 'org-mode
  :protect-syntax t
  :protect-font-lock t)

(define-auto-innermode poly-org-innermode
  :fallback-mode 'host
  :head-mode 'host
  :tail-mode 'host
  :head-matcher poly-org-mode-head-matcher
  :tail-matcher poly-org-mode-tail-matcher
  :mode-matcher #'poly-org-mode-matcher
  ;; :head-adjust-face 'org-block-begin-line
  ;; :tail-adjust-face 'org-block-end-line
  :switch-buffer-functions '(poly-org-init-block)
  :body-indent-offset 'org-edit-src-content-indentation
  :indent-offset 'org-edit-src-content-indentation)

(define-polymode poly-org-mode
  :hostmode 'poly-org-hostmode
  :innermodes '(poly-org-innermode))
  ;; (setq-local org-src-fontify-natively nil)
  ;; (make-local-variable 'polymode-move-these-minor-modes-from-old-buffer)
  ;; (push 'org-indent-mode polymode-move-these-minor-modes-from-old-buffer))

(add-to-list 'auto-mode-alist '("\\.org\\'" . poly-org-mode))

;;; Compatibility
(defun poly-org-inhibit-function (orig-fn &rest args)
  "Prevent function from executing when in an org-mode src block.
e.g. to disable lsp or flycheck."
  (unless polymode-mode
    (funcall orig-fn args)))
(advice-add #'lsp :around #'poly-org-inhibit-function)
(advice-add #'flycheck-mode :around #'poly-org-inhibit-function)

(defun poly-org-in-src-block-p (orig-fn &optional inside)
  (let ((block (car (pm--span-at-point
                     poly-org-mode-head-matcher
                     poly-org-mode-tail-matcher))))
    (or
     (funcall orig-fn inside)
     (if inside
         (eq block 'body)
       block))))

(advice-add #'org-in-src-block-p :around #'poly-org-in-src-block-p)

;;; Keybindings
(defun poly-org-eval-src-block ()
  (interactive)
  ;; NOTE: polymode-with-current-base-buffer does *not* work
  (with-current-buffer (pm-base-buffer)
    (org-babel-execute-src-block)))

(general-nmap :keymaps '(python-mode-map julia-mode-map)
  :predicate 'poly-org-header-params
  "RET" 'poly-org-eval-src-block)

;;; Debug
(org-babel-do-load-languages
 'org-babel-load-languages
 '((jupyter . t)))

(provide 'native-src)
