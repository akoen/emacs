;; REVIEW: The use of +edebug-refontify breaks hl-todo and is
;; *not-recommended* according to the doc.
(defalias '+edebug-refontify #'font-lock-debug-fontify)

;;; CIDER-style debug command overlay

(defface +edebug-command-overlay-face
  '((t :underline t :inherit font-lock-builtin-face))
  "Face used to show keybindings during edebug session.")

(setq +edebug-display-commands '("[s]tep" "[c]ontinue" "[b]reakpoint" "[t]race"))
(defvar +edebug-command-overlay)

(defun +edebug-show-command-overlay ()
  (let* ((start-of-defun (save-excursion
                           (beginning-of-defun)
                           (point))))
    (setq +edebug-command-overlay (make-overlay start-of-defun start-of-defun nil t)))
  (overlay-put +edebug-command-overlay 'before-string
               (concat (propertize
                        (string-join +edebug-display-commands " ")
                        'face '+edebug-command-overlay-face)
                       "\n")))

(defun +edebug-remove-command-overlay ()
  (when (zerop edebug-recursion-depth)
    (delete-overlay +edebug-command-overlay)))

(defun +edebug-handle-command-overlay ()
  (if edebug-mode
      (+edebug-show-command-overlay)
    (+edebug-remove-command-overlay)))

(add-hook 'edebug-mode-hook #'+edebug-handle-command-overlay)

(defun test ()
  (interactive)
  (+ 1 2)
  (+ 3 4))

(defface +edebug-stop-point-face
  '((t :underline t :background "#090"))
  "Face to show point during edebug.")

(defface +edebug-point-face
  '((t :underline t :inherit 'highlight))
  "Face to show next stop points during edebug.")

;;; Stop point overlay
(defvar +edebug-stop-point-overlay)
(defvar +edebug-point-overlay)
(defun +edebug-show-next-stop-point (&rest ignore)
  (show-paren-mode -1)
  (if edebug-mode
    (let* ((data (edebug-get-edebug-or-ghost edebug-function))
           (start (marker-position (car data)))
           (stop-points (nth 2 data))
           (point-offset (- (point) start)))
      (when-let* ((next-stop-point
                 (cl-some (lambda (e) (when (> e point-offset) e)) stop-points))
                (stop-point (+ start next-stop-point)))
          (setq +edebug-point-overlay
                (make-overlay (point) (1+ (point)) nil t))
          (setq +edebug-stop-point-overlay
                (make-overlay stop-point (1+ stop-point) nil t))
          (overlay-put +edebug-point-overlay 'face '+edebug-point-face)
          (overlay-put +edebug-stop-point-overlay 'face '+edebug-stop-point-face)))
    (show-paren-mode 1)
    (delete-overlay +edebug-stop-point-overlay)
    (delete-overlay +edebug-point-overlay)))

(add-hook 'edebug-mode-hook #'+edebug-show-next-stop-point 1)
(add-hook 'edebug-mode-hook #'show-paren-mode)

;;; Instrumented function highlighting

(defface +instrumented-face
  '((((type graphic)) :box (:color "#c00" :line-width -1))
    (t :underline t :background "#800"))
  "Face used to mark code being debugged.")

(defun +edebug-propertize-instrumented-function (func)
  (font-lock-add-keywords 'emacs-lisp-mode
                          `((,(regexp-quote (symbol-name func)) . '+instrumented-face)))
  (+edebug-refontify))

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
    (+edebug-refontify)))

(advice-add 'eval-defun :after '+edebug-propertize-function-maybe)
(advice-add 'edebug-instrument-function :after '+edebug-propertize-instrumented-function)
(advice-add 'edebug-remove-instrumentation :after '+edebug-propertize-instrumented-function-remove)
(advice-add 'defun :after '+edebug-propertize-instrumented-function-remove)

;;; Trace overlay
(defface +trace-face
  '((((type graphic)) :box (:color "#00c" :line-width -1))
    (t :underline t :background "#008"))
  "Face used to mark code being debugged.")

(defun +trace-fontify (func &rest ignore)
  (font-lock-add-keywords 'emacs-lisp-mode
                          `((,(regexp-quote (symbol-name func)) . '+trace-face)))
  (+edebug-refontify))

(defun +trace-unfontify (func)
  (font-lock-remove-keywords 'emacs-lisp-mode
                             `((,(regexp-quote (symbol-name func)) . '+trace-face)))
  (+edebug-refontify))

(advice-add #'trace-function-internal :after #'+trace-fontify)
(advice-add #'untrace-function :after #'+trace-unfontify)

(provide 'edebug-x)
