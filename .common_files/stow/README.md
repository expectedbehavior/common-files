# Testing stow for dotfiles.

## Install

1. `brew install stow`
1. `rsync -arzcPE <old_laptop>:~/.dotfiles ~/`
1. `cd .dotfiles`
1. `stow common-files common-files-jason`


## After adding/removing files

1. `stow --restow common-files common-files-jason`
