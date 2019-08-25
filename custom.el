;;; init.el -*- lexical-binding: t; -*-

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(counsel-projectile-mode t nil (counsel-projectile))
 '(custom-safe-themes
   (quote
    ("0daf22a3438a9c0998c777a771f23435c12a1d8844969a28f75820dd71ff64e1" "6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" default)))
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#51afef"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#98be65"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#3f444a"))
 '(objed-cursor-color "#ff6c6b")
 '(package-selected-packages
   (quote
    (atomic-chrome pdf-tools org-noter github-modern-theme counsel-projectile yasnippet which-key web-mode use-package toc-org smooth-scrolling projectile ox-tufte ox-pandoc org-pomodoro org-plus-contrib org-gcal org-download org-bullets olivetti ob-ipython neotree lsp-ui load-theme-buffer-local ivy-rich habitica gulp-task-runner gnuplot general focus flycheck-grammalecte flx exec-path-from-shell evil-surround evil-org evil-magit doom-themes doom-modeline deft counsel company-lsp auctex)))
 '(recentf-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fixed-pitch ((t (:family "Fira Mono"))))
 '(org-document-title ((t (:weight bold :height 1.5))))
 '(org-done ((t (:strike-through t :weight bold))))
 '(org-headline-done ((t (:strike-through t))))
 '(org-image-actual-width (/ (display-pixel-width) 2))
 '(org-level-1 ((t (:height 1.1))))
 '(org-level-2 ((t (:height 1.1))))
 '(org-level-3 ((t (:height 1.1))))
 '(org-link ((t (:underline t))))
 '(variable-pitch ((t (:family "Input Sans" :height 1.0)))))
