#!/bin/bash

BUNDLED_COMMANDS="spec rspec cucumber cap css2sass sass-convert html2haml rails rackup rake resque resque-web"

## Functions

bundler-installed()
{
    which bundle > /dev/null 2>&1
}

within-bundled-project()
{
    local dir="$(pwd)"
    while [ "$(dirname $dir)" != "$HOME" ]; do
        [ -f "$dir/Gemfile" ] && return
        dir="$(dirname $dir)"
    done
    false
}

run-with-bundler()
{
    local command="$1"
    local dir="$(pwd)"
    shift
    if bundler-installed && within-bundled-project; then
        if [ -f "$dir/bin/$command" ]; then
            $dir/bin/$command "$@"
        else
            bundle exec $command "$@"
        fi
    else
        $command "$@"
    fi
}

## Main program

for CMD in $BUNDLED_COMMANDS; do
    alias $CMD="run-with-bundler $CMD"
done
