;;; init.el -*- lexical-binding: t; -*-

;; Package management
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(setq straight-use-package-by-default t)
(straight-use-package 'use-package)
(straight-use-package 'org-plus-contrib)

(require 'org)

(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
