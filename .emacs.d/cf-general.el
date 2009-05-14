;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;This file is organized into sections. The first section is globals, followed
;;by sections that are only invoked for specific modes or actions. Hypothetically
;;this section will one day contain a table of contents so it will be handy for
;;people who are not me.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;; GLOBALS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; i.    Mode/File relations
;; ii.   Load Paths
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq default-major-mode 'fundamental-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Mode/File relations
;;
;;If you want files with a particular ending to always start in a particular
;;mode, this is the place to put them.
;;
(setq auto-mode-alist (append '(("\\.ss$" . scheme-mode)
				("\\.t$" . text-mode)
				("\\.doc$" . text-mode)
				("\\.tex$" . latex-mode)
				("\\.C$" . c++-mode)
				("\\.h$" . c++-mode)
				("\\.hh$" . c++-mode)
				("\\.cc$" . c++-mode)
				("\\.cpp$" . c++-mode)
				("\\.src$" . c++-mode)
				("\\.java$" . java-mode)
				("\\.html$" . html-mode)
				("\\.php$" . php-mode)
				("\\.js$" . js2-mode)
				("\\.js.erb$" . js2-mode)
			        ("\\.cl$" . lisp-mode)
			        ("\\.tpl$" . html-mode)
				("\\.rb$" . ruby-mode)
				("\\.gemspec$" . ruby-mode))
			      auto-mode-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Load Paths
;;
;;All extraneous files that you want loaded when emacs starts. In this case,
;;gentoo puts all of its crap in one file under /usr/share and it has to be
;;sourced if emerging major modes is going to do you any good.
;;

(if (file-readable-p "/usr/share/emacs/site-lisp/site-gentoo.el")
     (setq load-path (append "/usr/share/emacs/site-lisp/site-gentoo.el" load-path)))
(if (file-readable-p "/usr/share/emacs/site-lisp/site-gentoo.el")
     (load "/usr/share/emacs/site-lisp/site-gentoo"))


;; Load paths
(add-to-list 'load-path (expand-file-name "~/.emacs.d"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp-personal"))

(require 'linum)
(load-file "~/.emacs.d/lisp/pastie.el")


;; make buffers that would have the same name be better named than default <n>
(require 'uniquify)
(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")


;; some stuff that seems like it should work to turn off linum in term-mode, but doesn't
;; (global-linum-mode 1)

;; (defun local-linum-mode-off ()
;;   (interactive)
;; ;;   (linum-mode nil)
;; ;;   (make-local-variable 'global-linum-mode)
;; ;;   (setq global-linum-mode nil)
;;   (make-local-variable 'linum-mode)
;;   (setq linum-mode nil)
;;   )
 
;; (add-hook 'term-mode-hook 'local-linum-mode-off)

;; make so you can do C-x k instead of C-x # when done editing with emacsclient
(add-hook 'server-switch-hook 
          (lambda ()
            (when (current-local-map)
              (use-local-map (copy-keymap (current-local-map))))
            (local-set-key (kbd "C-x k") 'server-edit)))


;; turn line numbers on in all modes except term-mode
(add-hook 'after-change-major-mode-hook 
          '(lambda ()
             (if (not (equal major-mode 'term-mode))
                 (linum-mode 1))))


(defconst console-p (eq (symbol-value 'window-system) nil)
  "Are we running in a console (non-X) environment?")

;; highlight the current line unless we're running on the console
(if (not console-p)
    (progn (global-hl-line-mode 1)   ;; To customize the background color
           (set-face-background 'hl-line "#222")))



(defun local-hl-line-mode-off ()
  (interactive)
  (make-local-variable 'global-hl-line-mode)
  (setq global-hl-line-mode nil))
 

;; don't highlight the current line in eterm
(add-hook 'term-mode-hook 'local-hl-line-mode-off)
  

;; change term-mode prefix key from C-c to C-x
;; also unmap M-x from going right to the shell so it behaves like emacs
;; note (kdb "M-x") is the preferred way to speficy key stuff these days, apparently
(defun cf-set-term-char-mode-bindings ()
  (interactive)
  (term-set-escape-char ?\C-x)
  (define-key term-raw-map (kbd "M-x") nil)
  (define-key term-raw-map (kbd "C-c") 'term-send-raw)
  (define-key term-raw-map (kbd "C-y") 'term-paste)
  (define-key term-raw-map (kbd "M-w") 'kill-ring-save)
  )
(add-hook 'term-mode-hook 'cf-set-term-char-mode-bindings)


;; our bash wrapper specifies the -il so bash will load all the appropriate files
;; might want to change the CFs' bash files to explicitly load all the necessary file (once) but that's more work
(if (not (getenv "ESHELL"))
    (setenv "ESHELL" (concat (getenv "HOME") "/.emacs.d/bash_wrapper")))


(add-hook 'ruby-mode-hook 
	  (function (lambda ()
		      (local-set-key (kbd "<tab>") 'indent-according-to-mode)
		      )))


(add-to-list 'load-path "~/.emacs.d/speedbar-0.14beta4")
(add-to-list 'load-path "~/.emacs.d/eieio-0.17")
(add-to-list 'load-path "~/.emacs.d/semantic-1.4.4")
(setq semantic-load-turn-everything-on t)
(require 'semantic-load)

(add-to-list 'load-path "~/.emacs.d/ecb-2.32")
(load-file "~/.emacs.d/ecb-2.32/ecb.el")

(setq load-path (cons "~/.emacs.d/rails" load-path))
(require 'rails)

(load-file "~/.emacs.d/lisp/php-mode.el")
(require 'php-mode)


(set-face-background 'flymake-errline "red4")
(set-face-background 'flymake-warnline "dark slate blue")


;; I hate tabs!
(setq-default indent-tabs-mode nil)
;; Type C-q C-i to insert a horizontal tab character


(autoload 'js2-mode "js2-20080616a" nil t)
;; (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
 
(setq js2-basic-offset 2)


(setq default-tab-width 2)
(setq default-fill-column 120)



(ido-mode t)



;;(if (file-readable-p "/home/gladisjd/tempo.el")
;;     (setq load-path (append "/home/gladisjd/tempo.el" load-path)))
;;(if (file-readable-p "/home/gladisjd/javascript-mode.el")
;;     (setq load-path (append "/home/gladisjd/javascript-mode.el" load-path)))
;;(load "/usr/share/emacs/site-lisp/site-gentoo.el") //I'm pretty sure this is analogous to the above

;;(if (file-readable-p "/home/gladisjd/javascript-mode.el")
;;     (setq load-path (append "/home/gladisjd/javascript-mode.el" load-path)))
;;(if (file-readable-p "/home/gladisjd/javascript-mode.el")
;;     (load "/home/gladisjd/javascript-mode"))

;;(if (file-readable-p "/home/gladisjd/tempo.el")
;;     (setq load-path (append "/home/gladisjd/tempo.el" load-path)))

;;(if (file-readable-p "/home/gladisjd/tempo.el")
;;     (load "/home/gladisjd/tempo"))
;;(if (file-readable-p "/home/gladisjd/javascript-mode.el")
;;     (load "/home/gladisjd/javascript-mode"))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Global Key Bindings
;;
;;Keys that should be mapped to a particular function regardless of mode
;;should be set here.
;;
(global-set-key "%" 'match-paren)
(global-set-key "%" 'run-scheme)
(global-set-key "!" 'shell)
(global-set-key "x" 'send-to-scheme) ;;copies from top buffer to bottom
(global-unset-key "\M-g") ;;remove current ridiculous binding on alt-g
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-;" 'comment-or-uncomment-region)
(global-set-key [delete] 'delete-char) ;;delete key work on regular kb
(global-set-key [kp-delete] 'delete-char) ;;delete key work on keypad


;; arg >= 1 enable the menu bar. Menu bar is the File, Edit, Options,
;; Buffers, Tools, Emacs-Lisp, Help
(menu-bar-mode 0)

;; With numeric ARG, display the tool bar if and only if ARG is
;; positive.  Tool bar has icons document (read file), folder (read
;; directory), X (discard buffer), disk (save), disk+pen (save-as),
;; back arrow (undo), scissors (cut), etc.
(if (boundp 'tool-bar-mode) (tool-bar-mode 0))

;; hide the scroll bar no matter what
(if (boundp 'scroll-bar-mode) (scroll-bar-mode -1))




;;does parenthesis matching, global key "%" set below
(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))



;; Are we running XEmacs or Emacs?
(defvar running-xemacs (string-match "XEmacs\\|Lucid" emacs-version))

;; Turn on font-lock mode for Emacs
(cond ((not running-xemacs)
       (global-font-lock-mode t)
       ))


;; Visual feedback on selections
(setq-default transient-mark-mode t)

;; hitting delete will delete the highlighted region
(pending-delete-mode 1)

;; Always end a file with a newline
(setq require-final-newline t)

;; Stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

;; Enable wheelmouse support by default
(cond (window-system
       (mwheel-install)
       ))

;; force visible bell, 'cause every hates the system bell
(setq visible-bell t)

;;;;;;;; Don't truncate, wrap, or fold lines of split windows ;;;
(setq truncate-partial-width-windows nil)
(setq truncate-lines nil)

;;;; The MODE Line ;;;;
(load "time") (display-time)
(column-number-mode 1)

;; title bar shows name of current buffer ;;
(setq frame-title-format '("emacs: %*%+ %b"))

;; don't show the startup message every time, I know I'm using emacs
(setq inhibit-startup-message t)

;;;; use y or n instead of yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Some custom key bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;; M-g does goto-line ;;;;

(global-set-key [f2] 'eval-buffer)	; F2
(global-set-key [f4] 'revert-buffer)    ; F4

;;;;;; quick move cursor to top or bottom of screen ;;;;;
(defun point-to-top ()
  "Put point on top line of window."
  (interactive)
  (move-to-window-line 0))

(global-set-key [?\C-,] 'point-to-top)

(defun point-to-bottom ()
  "Put point at beginning of last visible line."
  (interactive)
  (move-to-window-line -1))

(global-set-key [?\C-.] 'point-to-bottom)

;;;;;;;;;;;;;;;;; Use cperl-mode instead of perl-mode ;;;;;;;;;;;;;;
;; though I'm not convinced I like it better than perl-mode...
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))

;;;;;;;;;; Some functions for fancy indenting and completing ;;;;;;;;;;
;; These were coded by Brett Williams

;; This is a nice idea but it ends up frustrating me more than helping me...
;;(defun indent-newline-indent()
;;  "Indent a line, newline, and indent for the next line."
;;  (interactive)
;;  (indent-for-tab-command)
;;  (newline-and-indent)
;;  )

(defun indent-or-complete ()
  "Complete if point is at end of a word, otherwise indent line."
  (interactive)
  (if (looking-at "\\>")
      ;;     (and
      ;;      (eq (char-syntax (preceding-char)) ?w)
      ;;      (not (eq (char-syntax (following-char)) ?w))
      ;;      )
      (dabbrev-expand nil)
    (indent-for-tab-command)
    ))

;; indent-or-complete seems to do the job well enough,
;; but a simple global binding to tab is not what we want
;; (if I remember correctly, it messes up the mini-buffer 
;;  where tab is generally bound to minibuffer-complete)
;;(global-set-key [tab] 'indent-or-complete)

;; Another option is to bind tab to indent-or-complete
;; within the mode-map of relevant modes. Something like:
;; (define-key java-mode-map [tab] 'indent-or-complete)
;; or even within the mode's hook such as:
(define-key text-mode-map [tab] 'indent-or-complete)
;;(define-key verilog-mode-map [tab] 'indent-or-complete)
(add-hook 'verilog-mode-hook
	  (function (lambda ()
		      (local-set-key (kbd "") 'indent-or-complete)
		      )))
			     
(add-hook 'java-mode-hook 
	  (function (lambda ()
		      (local-set-key (kbd "") 'indent-or-complete)
		      )))

(add-hook 'c-mode-common-hook 
	  (function (lambda ()
		      (setq c-basic-offset 4)
		      (local-set-key (kbd "") 'indent-or-complete)
		      ;;With tab doing completion, M-tab is free for indent-region
		      (local-set-key [?\C-c tab] 'indent-region)
		      )))

;;;;;;;;;;;;;;; color settings ;;;;;;;;;;;;;;;;;;;;;;
(set-foreground-color "grey100" )
;;(set-background-color "#000044" )
(set-background-color "black")

(set-cursor-color "yellow")
(set-border-color "DarkSlateGray" )

(setq default-frame-alist
      (append default-frame-alist
	      '((foreground-color . "grey100")
		(background-color . "black")
		(cursor-color . "yellow")
	        ;(mouse-color . "DarkSlateGray")
		)))
(set-face-foreground 'font-lock-comment-face       "gray")
(set-face-foreground 'font-lock-string-face        "OrangeRed")
;(set-face-foreground 'font-lock-doc-string-face    "gray")
(set-face-foreground 'font-lock-function-name-face "green")
(set-face-foreground 'font-lock-variable-name-face "cyan")
(set-face-foreground 'font-lock-type-face          "SandyBrown")
(set-face-foreground 'font-lock-keyword-face       "Magenta")
(set-face-foreground 'font-lock-builtin-face       "Wheat")
(set-face-foreground 'font-lock-constant-face      "yellow") ; "Wheat")

(set-face-foreground 'modeline "black")
(set-face-background 'modeline "grey100")
(set-face-background 'region "blue")
(set-face-foreground 'bold "red")
(set-face-foreground 'italic "yellow")
(set-face-background 'highlight "blue") 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;CLAUDE'S SHIT BELOW, EDIT THIS AND INTEGRATE WITH OTHER STUFF
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(global-set-key "%" 'run-scheme)
(global-set-key "!" 'shell)

(add-hook 'text-mode-hook 
  (function
   (lambda ()
     (auto-fill-mode 1)
     (local-set-key "" 'newline-and-indent))))

(add-hook 'java-mode-hook 
  (function
   (lambda ()
     (auto-fill-mode 0)
     (local-set-key "" 'newline-and-indent))))

(add-hook 'fundamental-mode-hook
  (function
   (lambda ()
     (local-set-key "" 'newline-and-indent))))

(add-hook 'cc-mode-hook
  (function
   (lambda ()
     (local-set-key "" 'newline-and-indent))))

(add-hook 'inferior-scheme-mode-hook
  (function
   (lambda ()
     (local-set-key "p" 'comint-previous-matching-input-from-input)
     (local-set-key "n" 'comint-next-matching-input-from-input))))
(add-hook 'shell-mode-hook
  (function
   (lambda ()
     (local-set-key "p" 'comint-previous-matching-input-from-input)
     (local-set-key "n" 'comint-next-matching-input-from-input))))
(add-hook 'scheme-mode-hook 
  (function
   (lambda ()
     (local-set-key "" 'newline-and-indent))))

(setq inhibit-startup-message 't)
;(setq require-final-newline 't)
(put 'eval-expression 'disabled nil)
(put 'downcase-region 'disabled nil)


(autoload 'c++-mode  "cc-mode" "C++ Editing Mode" t)
(autoload 'c-mode    "cc-mode" "C Editing Mode" t)
(autoload 'objc-mode "cc-mode" "Objective-C Editing Mode" t)
;;(autoload 'java-mode "cc-mode" "Java Editing Mode" t)

;;; Scheme stuff:
(autoload 'run-scheme "cmuscheme" "Run an inferior scheme process." t)

(put 'eval-when     'scheme-indent-function 1)
(put 'set!          'scheme-indent-function 1)
(put 'when          'scheme-indent-function 1)
(put 'unless        'scheme-indent-function 1)
(put 'record-case   'scheme-indent-function 1)
(put 'c-record-case 'scheme-indent-function 1)
(put 'variant-case  'scheme-indent-function 1)
(put 'parameterize  'scheme-indent-function 1)
(put 'call-with-values 'scheme-indent-function 1)
(put 'extend-syntax 'scheme-indent-function 1)
(put 'with          'scheme-indent-function 1)
(put 'let/cc        'scheme-indent-function 1)
(put 'let-syntax    'scheme-indent-function 1)
(put 'letrec-syntax 'scheme-indent-function 1)
(put 'with-syntax   'scheme-indent-function 1)
(put 'syntax-case   'scheme-indent-function 2)
(put 'syntax  'scheme-indent-function 1)
(put 'syntax-rules  'scheme-indent-function 1)
(put 'foreign-procedure 'scheme-indent-function 1)
(put 'set-top-level-value! 'scheme-indent-function 1)
(put 'make-parameter 'scheme-indent-function 1)
(put 'decompose     'scheme-indent-function 2)
(put 'mvlet         'scheme-indent-function 1)
(put 'mvlet*        'scheme-indent-function 1)
(put 'state-case    'scheme-indent-function 1)
(put 'foreach       'scheme-indent-function 1)
(put 'vector-foreach 'scheme-indent-function 1)
(put 'assert        'scheme-indent-function 1)
(put 'fold-list     'scheme-indent-function 2)
(put 'fold-vector   'scheme-indent-function 2)
(put 'fold-count    'scheme-indent-function 2)
(put 'on-error      'scheme-indent-function 1)

;;; C stuff:
(setq c-indent-level 3)
(setq c-argdecl-indent 0)
(setq c-continued-statement-offset 3)
(setq c-brace-offset -3)
(setq c-label-offset -2)



;; Indentation stuff
;(defvar standard-indent 3) ; for most things
;(defvar c-basic-offset 3)  ; for c++

;(setq c-block-comments-indent-p nil)
;(setq c-hungry-delete-key t)
;(setq c-indent-level 3)
;(setq c-argdecl-indent 0)
;(setq c-continued-statement-offset 3)
;(setq c-brace-offset -3)
;(setq c-label-offset -2)



;; Highlight mark (selection)
;(transient-mark-mode t)

;; Show matching paren or bracket when cursor is on or after it
(show-paren-mode 1)
(setq blink-matching-paren-distance nil)

(fset 'send-to-scheme
   "\C-@\C-[\C-f\C-e\C-[w\C-xo\C-y\C-m\C-xo\C-e\C-[OC")

(defun mac-toggle-max-window ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
                                           nil
                                           'fullboth))) 



(defun medium (&optional nosplit)
  "Create a large window suitable for coding on a macbook."
  (interactive "P")
  (my-set-mac-font "bitstream vera sans mono" 14)
  (arrange-frame 170 45 nosplit))

(defun presentation ()
  "Create a giant font window suitable for doing live demos."
  (interactive)
  (arrange-frame 85 25 t)
  (my-set-mac-font "bitstream vera sans mono" 24))
