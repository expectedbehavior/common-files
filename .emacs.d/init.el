(require 'cask "/opt/homebrew/Cellar/cask/0.8.7/cask.el")
(cask-initialize)
(require 'pallet)

(mapc 'load (directory-files "~/.emacs.d/customizations" t "^[0-9]+.*\.el$"))
