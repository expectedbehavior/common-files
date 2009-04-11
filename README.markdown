# Installation

The common files are meant to be installed into your home directory, but Git is a little reluctant to put itself right
into an existing directory. Install by checking out to a directory and then copying into your home directory:

* git clone git@github.com:expectedbehavior/common-files.git
* cp -fr common-files/* .

# History Search

This works by default on most *nix systems, but on OS X you'll need to change the mapping of the page up and page down
keys. In terminal, change page down to '\033[6~' and page up to '\033[5~'.
