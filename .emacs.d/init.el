(require 'cask "/usr/local/Cellar/cask/0.8.1/cask.el")
(cask-initialize)
(require 'pallet)

(mapc 'load (directory-files "~/.emacs.d/customizations" t "^[0-9]+.*\.el$"))
