;;; init.el -*- lexical-binding: t; -*-

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#282c34" "#ff6c6b" "#98be65" "#ECBE7B" "#51afef" "#c678dd" "#46D9FF" "#bbc2cf"])
 '(ccls-executable nil t)
 '(counsel-projectile-mode t nil (counsel-projectile))
 '(custom-safe-themes
   (quote
    ("0daf22a3438a9c0998c777a771f23435c12a1d8844969a28f75820dd71ff64e1" "6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" default)))
 '(fci-rule-color "#5B6268")
 '(flycheck-disabled-checkers (quote (c/c++-clang c/c++-cppcheck c/c++-gcc)))
 '(jdee-db-active-breakpoint-face-colors (cons "#1B2229" "#51afef"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1B2229" "#98be65"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1B2229" "#3f444a"))
 '(lsp-prefer-flymake nil)
 '(objed-cursor-color "#ff6c6b")
 '(package-selected-packages
   (quote
    (doom-themes pdf-tools hydra cmake-ide cmake-font-lock cmake-mode google-c-style smartparens evil-snipe use-package-ensure-system-package ox-clip htmllize vterm org-super-agenda calfw-org calfw ccls atomic-chrome org-noter github-modern-theme counsel-projectile yasnippet which-key web-mode use-package toc-org smooth-scrolling projectile ox-tufte ox-pandoc org-pomodoro org-plus-contrib org-gcal org-download org-bullets olivetti ob-ipython neotree lsp-ui load-theme-buffer-local ivy-rich habitica gulp-task-runner gnuplot general focus flycheck-grammalecte flx exec-path-from-shell evil-surround evil-org evil-magit doom-modeline deft counsel company-lsp auctex)))
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
 '(recentf-mode t)
 '(vc-annotate-background "#282c34")
 '(vc-annotate-color-map
   (list
    (cons 20 "#98be65")
    (cons 40 "#b4be6c")
    (cons 60 "#d0be73")
    (cons 80 "#ECBE7B")
    (cons 100 "#e6ab6a")
    (cons 120 "#e09859")
    (cons 140 "#da8548")
    (cons 160 "#d38079")
    (cons 180 "#cc7cab")
    (cons 200 "#c678dd")
    (cons 220 "#d974b7")
    (cons 240 "#ec7091")
    (cons 260 "#ff6c6b")
    (cons 280 "#cf6162")
    (cons 300 "#9f585a")
    (cons 320 "#6f4e52")
    (cons 340 "#5B6268")
    (cons 360 "#5B6268")))
 '(vc-annotate-very-old-color nil))
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
