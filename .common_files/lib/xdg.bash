# https://specifications.freedesktop.org/basedir-spec/latest/#variables
# > User-specific executable files may be stored in $HOME/.local/bin.
# > Distributions should ensure this directory shows up in the UNIX
# > $PATH environment variable, at an appropriate place.

# Claude Code specifically expects this to be set up, at least for some
# installation methods.

export PATH="${HOME}/.local/bin:$PATH"
