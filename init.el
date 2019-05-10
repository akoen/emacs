(require 'org)

(org-babel-load-file (expand-file-name "~/.emacs.d/config.org"))

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)
