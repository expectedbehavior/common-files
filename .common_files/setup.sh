#!/bin/bash
set -e
cd "$(dirname "$0")/.."

brew list cask > /dev/null 2>&1 || brew install cask

echo "Installing emacs packages"
(cd ~/.emacs.d && cask install)
