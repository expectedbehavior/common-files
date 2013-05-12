#!/bin/bash

set -x

tempfoo=`basename $0`
TMPFILE=`mktemp -t ${tempfoo}` || exit 1

git add -- ${1-.} "$@" &&
  git diff --cached -- "$@" > $TMPFILE &&
  git reset HEAD -- ${1-.} "$@" ;
cat $TMPFILE | git apply --cached --whitespace=fix &&
  git checkout -- ${1-.} "$@"
