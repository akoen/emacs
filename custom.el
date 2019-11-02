;;; init.el -*- lexical-binding: t; -*-

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ccls-executable nil t)
 '(counsel-projectile-mode t nil (counsel-projectile))
 '(custom-safe-themes
   (quote
    ("0daf22a3438a9c0998c777a771f23435c12a1d8844969a28f75820dd71ff64e1" "6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" default)))
 '(flycheck-disabled-checkers (quote (c/c++-clang c/c++-cppcheck c/c++-gcc)))
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#51afef"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#98be65"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#3f444a"))
 '(lsp-prefer-flymake nil)
 '(objed-cursor-color "#ff6c6b")
 '(package-selected-packages
   (quote
    (pdf-tools hydra cmake-ide cmake-font-lock cmake-mode google-c-style smartparens evil-snipe use-package-ensure-system-package ox-clip htmllize vterm org-super-agenda calfw-org calfw ccls atomic-chrome org-noter github-modern-theme counsel-projectile yasnippet which-key web-mode use-package toc-org smooth-scrolling projectile ox-tufte ox-pandoc org-pomodoro org-plus-contrib org-gcal org-download org-bullets olivetti ob-ipython neotree lsp-ui load-theme-buffer-local ivy-rich habitica gulp-task-runner gnuplot general focus flycheck-grammalecte flx exec-path-from-shell evil-surround evil-org evil-magit doom-themes doom-modeline deft counsel company-lsp auctex)))
 '(projectile-cache-file "/home/alex/.emacs.d/.local/cache/projectile.cache")
 '(projectile-enable-caching t)
 '(projectile-files-cache-expire 604800)
 '(projectile-known-projects-file "/home/alex/.emacs.d/.local/cache/projectile.projects")
 '(projectile-project-root-files-top-down-recurring
   (quote
    ("compile_commands.json" ".ccls" "compile_commands.json" ".ccls" ".svn" "CVS" "Makefile")))
 '(projectile-require-project-root (quote prompt))
 '(projectile-sort-order (quote recentf))
 '(projectile-use-git-grep t)
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
