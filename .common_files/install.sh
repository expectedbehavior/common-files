#!/bin/bash

git clone git://github.com/expectedbehavior/common-files.git &&
  cp -fr common-files/* . &&
  cp -fr common-files/.??* . &&
  rm -fr common-files/ &&
  git checkout . # fixes issues with weird permissions changes after copy
