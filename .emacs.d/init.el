(require 'cask "~/.emacs.d/.cask/24.5.1/elpa/cask-20151123.528/cask.el")
(cask-initialize)
(require 'pallet)

(mapc 'load (directory-files "~/.emacs.d/customizations" t "^[0-9]+.*\.el$"))
