#!/bin/bash

PLUGIN_BIN="$(dirname $BASH_SOURCE)/bin"
export PATH="${PATH}:${PLUGIN_BIN}"
complete -o default -A command lc
