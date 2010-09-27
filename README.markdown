# Installation

## The easy way

Make sure you're in your home directory, then copy and paste this into your terminal:

    curl http://github.com/expectedbehavior/common-files/raw/master/.common_files/install.sh | bash

Check out [the install script](http://github.com/expectedbehavior/common-files/blob/master/.common_files/install.sh) if you like.  It's pretty close to the lines below.

## The hard way

The common files are meant to be installed into your home directory, but Git is a little reluctant to put itself right
into an existing directory. Install by checking out to a directory and then copying into your home directory:

    git clone git://github.com/expectedbehavior/common-files.git
    cp -fr common-files/* .
    cp -fr common-files/.??* .
    rm -fr common-files/

# History Search

This works by default on most *nix systems, but on OS X you'll need to change the mapping of the page up and page down
keys. In terminal, change page down to '\033[6~' and page up to '\033[5~'.
