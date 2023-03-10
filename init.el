;;; init.el -*- lexical-binding: t; -*-
(add-to-list 'load-path (concat user-emacs-directory "lisp"))

(setq config-file (expand-file-name "config.el" user-emacs-directory)
      custom-file (expand-file-name "custom.el" user-emacs-directory))

(if (file-exists-p config-file)
    (load config-file)
  (org-babel-load-file (expand-file-name "config.org" user-emacs-directory)))

(load custom-file t t)
