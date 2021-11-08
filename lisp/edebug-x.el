(setq +edebug-display-commands '("[s]tep" "[c]ontinue" "[t]race"))
(defvar +edebug-command-overlay)

(defun +edebug-show-command-overlay (&rest ignore)
  (let* ((start-of-defun (save-excursion
                           (beginning-of-defun)
                           (point))))
    (setq +edebug-command-overlay (make-overlay start-of-defun start-of-defun nil t)))
  (overlay-put +edebug-command-overlay 'before-string (concat (string-join +edebug-display-commands " ") "\n")))

(defun +edebug-command-overlay-remove (&rest ignore)
  (when (zerop edebug-recursion-depth)
    (delete-overlay +edebug-command-overlay)))

(advice-add 'edebug--recursive-edit :before #'+edebug-show-command-overlay)
(advice-add 'edebug--recursive-edit :after #'+edebug-command-overlay-remove)

(defun test ()
  (interactive)
  (+ 1 2)
  (+ 3 4))

(general-nmap "<f1>" 'test)

(remove-overlays (point-min) (point-max))

;; Highlight instrumented functions
;; REVIEW: The use of font-lock-debug-fontify breaks hl-todo and is
;; *not-recommended* according to the doc.


(defface +instrumented-face
  '((((type graphic)) :box (:color "#c00" :line-width -1))
    (t :underline t :background "#800"))
  "Face used to mark code being debugged.")

(defun +edebug-propertize-instrumented-function (func)
  (font-lock-add-keywords 'emacs-lisp-mode
                          `((,(regexp-quote (symbol-name func)) . '+instrumented-face)))
  (font-lock-debug-fontify))

(defun +edebug-propertize-function-maybe (edebug-it)
  ""
  (when edebug-it
    (when-let* ((def (thing-at-point 'defun t))
                (func (intern (nth 1 (split-string def " ")))))
      (+edebug-propertize-instrumented-function func))))

(defun +edebug-propertize-instrumented-function-remove (func &rest ignore)
  ""
  (when (and (get func 'edebug)
             (or (functionp func)
                 (macrop func))
             (edebug--unwrap*-symbol-function func))
    (font-lock-remove-keywords 'emacs-lisp-mode
                               `((,(regexp-quote (symbol-name func)) . '+instrumented-face)))
    (font-lock-debug-fontify)))

(advice-add 'eval-defun :after '+edebug-propertize-function-maybe)
(advice-add 'edebug-instrument-function :after '+edebug-propertize-instrumented-function)
(advice-add 'edebug-remove-instrumentation :after '+edebug-propertize-instrumented-function-remove)
(advice-add 'defun :after '+edebug-propertize-instrumented-function-remove)


(provide 'edebug-x)
