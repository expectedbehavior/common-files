;; This tells emacs to save backup files to ~/.emacs.d/backup
;; (which is in the repo with a .gitignore), instead of saving
;; these backup files next to the original file.  This is handy
;; because having the backup file next to the original can be
;; annoying for tab completion and version control, depending on
;; the situation.
(setq backup-directory-alist
      `((".*" . ,(expand-file-name "~/.emacs.d/backup/"))))

;; This tells emacs to transform the name of the individual file
;; that's being backed up to include the path so multiple files
;; with the same name won't collide.  For example, instead of
;; the backup file baing named "Gemfile~" it would be named
;; "!path!to!project!Gemfile~".
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backup/") t)))
