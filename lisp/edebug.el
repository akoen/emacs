(defun +start-of-defun ()
  (save-excursion
    (beginning-of-defun)
    (point)))

(setq +edebug-display-commands '("step" "next" "trace"))

(setq +edebug-display-commands '("step" "next" "in"))

(defun +edebug-command-overlay (&rest ignore)
  (setq ov (make-overlay (max (+start-of-defun) (window-start))
                         (max (+start-of-defun) (window-start))
                         nil t))
  (overlay-put ov 'before-string (concat (string-join +edebug-display-commands " ") "\n")))

(defun +edebug-command-overlay-remove (&rest ignore)
  (delete-overlay ov))

(advice-add 'edebug--recursive-edit :before #'+edebug-command-overlay)
(advice-add 'edebug--recursive-edit :after #'+edebug-command-overlay)


(defun test ()
  (message "hello"))
