;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;; end Red Hat defaults ;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; these customizations were made from the options menu.  To change
;; them make use the options menu.  They should be self explanatory
;; (I hope)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(current-language-environment "Latin-9")
 '(default-input-method "latin-9-prefix")
 '(ecb-layout-name "left13")
 '(ecb-options-version "2.32")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(ecb-source-path (quote (("/" "/"))))
 '(global-font-lock-mode t nil (font-lock))
 '(show-paren-mode t nil (paren))
 '(transient-mark-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(load-file "~/.emacs.d/cf-general.el")

(put 'upcase-region 'disabled nil)

(medium)
(setq show-trailing-whitespace t)
(cua-mode)

(require 'color-theme)
(color-theme-initialize)
;; uncomment two lines below to start emacs with a different color theme.
;; I like the twilight theme. It has draculas. -joel
;; (load "~/.emacs.d/autoload/colors/themes/color-theme-vibrant-ink.el")
;; (color-theme-vibrant-ink)
;; (load "~/.emacs.d/autoload/colors/themes/color-theme-less.el")
;; (color-theme-less)
;; (load "~/.emacs.d/autoload/colors/themes/color-theme-subdued.el")
;; (color-theme-subdued)
;; (load "~/.emacs.d/autoload/colors/themes/color-theme-wombat.el")
;; (color-theme-wombat)
(load "~/.emacs.d/autoload/colors/themes/color-theme-twilight.el")
(color-theme-twilight)
;; (load "~/.emacs.d/autoload/colors/themes/color-theme-railscasts.el")
;; (color-theme-railscasts)
;;(load "~/.emacs.d/autoload/colors/themes/color-theme-chocolate-rain.el")
;; (color-theme-chocolate-rain)
