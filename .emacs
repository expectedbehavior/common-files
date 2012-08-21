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
 '(css-indent-offset 2)
 '(current-language-environment "Latin-9")
 '(default-input-method "latin-9-prefix")
 '(ecb-layout-name "left13")
 '(ecb-options-version "2.32")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(ecb-source-path (quote (("/" "/"))))
 '(global-font-lock-mode t nil (font-lock))
 '(php-add-fclose-with-fopen nil)
 '(php-add-mysql-close-when-connect nil)
 '(php-basic-offset 2)
 '(php-electric-mode nil)
 '(php-enable-phpdocumentor-tags nil)
 '(php-include-in-parenthesis nil)
 '(php-stutter-mode nil)
 '(php-word-completion-in-minibuffer nil)
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

(setq show-trailing-whitespace t)
(cua-mode)

(require 'yaml-mode)
(require 'markdown-mode)
(require 'coffee-mode)

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


(defun small (&optional nosplit)
  "Create a two-pane window suitable for coding on a macbook."
  (interactive "P")
  (my-set-mac-font "PragmataPro" 12)
  (arrange-frame 170 45 nosplit))

(defun medium (&optional nosplit)
  "Create a two-pane window suitable for coding on a macbook."
  (interactive "P")
  (my-set-mac-font "PragmataPro" 16)
  (arrange-frame 170 45 nosplit))

(defun large (&optional nosplit)
  "Create a two-pane window suitable for coding on a macbook."
  (interactive "P")
  (my-set-mac-font "PragmataPro" 20)
  (arrange-frame 170 45 nosplit))

(defun projector (&optional nosplit)
  "Create a large window suitable for coding on a macbook."
  (interactive "P")
  (my-set-mac-font "PragmataPro" 20)
  (arrange-frame 170 45 nosplit))

(defun presentation ()
  "Create a giant font window suitable for doing live demos."
  (interactive)
  (arrange-frame 85 26 t)
  (my-set-mac-font "PragmataPro" 26))

(set-frame-parameter (selected-frame) 'alpha '(94 50))
(add-to-list 'default-frame-alist '(alpha 94 50))

(server-start)
(medium)
(maximize-frame)

;; Use a hbar cursor when mark is active and a region exists.
(defun th-activate-mark-init ()
  (setq cursor-type 'hbar))
(add-hook 'activate-mark-hook 'th-activate-mark-init)

(defun th-deactivate-mark-init ()
  (setq cursor-type 'box))
(add-hook 'deactivate-mark-hook 'th-deactivate-mark-init)


;;;;;;;;;;;;;;;;;;;;
;; set up unicode
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; This from a japanese individual.  I hope it works.
(setq default-buffer-file-coding-system 'utf-8)
;; From Emacs wiki
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
;; MS Windows clipboard is UTF-16LE 
(set-clipboard-coding-system 'utf-16le-dos)


;;;;;;;;;;;;;;;;;;;;;
;; setup package archives
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

;;;;;;;;;;;;;;;;;;;;;
;; add marmelade to package sets
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

;; create a backup file directory
(defun make-backup-file-name (file)
(concat "~/.emacs.backups/" (file-name-nondirectory file) "~"))
