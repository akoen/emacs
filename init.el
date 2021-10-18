;;; init.el -*- lexical-binding: t; -*-

(if (file-exists-p (expand-file-name "config.el" user-emacs-directory))
    (load-file (expand-file-name "config.el" user-emacs-directory))
  (org-babel-load-file (expand-file-name "config.org" user-emacs-directory)))

(setq custom-file (concat emacs-dir "custom.el"))
(load custom-file)
