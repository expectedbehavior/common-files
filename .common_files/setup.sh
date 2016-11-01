#!/bin/bash
set -e
cd "$(dirname "$0")/.."

echo "Installing emacs packages"
(cd .emacs.d && cask install)
