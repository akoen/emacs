;;; early-init.el -*- lexical-binding: t; -*-

(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.5)

(setq package-enable-at-startup nil)
(setq frame-inhibit-implied-resize t)
(setq load-prefer-newer t)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(internal-border-width . 16) default-frame-alist)

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
(setq straight-base-dir emacs-local-dir)
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

(use-package modus-themes
  :config
  (load-theme 'modus-operandi t))

;; Hide default mode-line
(use-package hide-mode-line
  :init
  (hide-mode-line-mode 1))

(setq inhibit-message t
      warning-minimum-level :error
      debug-on-error t)
(add-hook 'emacs-startup-hook (lambda ()
                                (interactive)
                                (setq inhibit-message nil
                                      warning-minimum-level :warning
                                      debug-on-error nil)))
