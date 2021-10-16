;;; init.el -*- lexical-binding: t; -*-

;; Define packages
(defconst emacs-dir (file-truename user-emacs-directory)
  "The currently loaded .emacs.d directory.")

(defconst emacs-local-dir (concat emacs-dir ".local/")
  "Root directory for local storage. Do not share across systems.")

(defconst emacs-cache-dir (concat emacs-local-dir "cache/")
  "Directory for volatile local storage.")

(defconst emacs-etc-dir (concat emacs-local-dir "etc/")
  "Directory for non-volatile local storage")

(defconst emacs-packages-dir (concat emacs-local-dir "packages/")
  "Where pacakges are stored.")

;; Package management
(setq straight-base-dir emacs-local-dir
      straight-vc-git-default-protocol 'ssh)
(defvaralias 'comp-deferred-compilation-deny-list 'comp-deferred-compilation-black-list)
;; The following speeds up init time by almost a second, but is likely a hack.
;;See https://www.gitmemory.com/issue/raxod502/straight.el/373/491018643
(setq straight-check-for-modifications '(check-on-save))
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" straight-base-dir))
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
(use-package use-package-ensure-system-package)

(if (file-exists-p (expand-file-name "config.el" user-emacs-directory))
    (load-file (expand-file-name "config.el" user-emacs-directory))
  (org-babel-load-file (expand-file-name "config.org" user-emacs-directory)))

(setq custom-file (concat emacs-dir "custom.el"))
(load custom-file)
