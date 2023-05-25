#!/bin/bash

PLUGIN_BIN="$(dirname $BASH_SOURCE)/bin"
export PATH="${PLUGIN_BIN}:${PATH}"
complete -o default -A command lc
