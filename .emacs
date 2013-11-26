
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

(set-frame-parameter (selected-frame) 'alpha '(94 50))
(add-to-list 'default-frame-alist '(alpha 94 50))

(load "server")
(unless (server-running-p) (server-start))
(medium)
(maximize-frame)

(defun toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

(toggle-fullscreen)

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
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))




(if (string-equal "jason" (user-login-name))
    (progn
      (my-set-mac-font "Monaco" 14)
    )
)
