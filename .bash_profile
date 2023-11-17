# /etc/skel/.bash_profile:
# $Header: /home/cvsroot/gentoo-src/rc-scripts/etc/skel/.bash_profile,v 1.10 2002/11/18 19:39:22 azarah Exp $

#This file is sourced by bash when you log in interactively.
[ -f ~/.bashrc ] && . ~/.bashrc

is_key_encrypted() {
  grep ENCRYPTED "$1" &> /dev/null
}

# Silence zsh warning
export BASH_SILENCE_DEPRECATION_WARNING=1

if [[ "$SKIP_KEYCHAIN" != "true" ]]; then
  # Only one process needs to load the unencrypted keys, the first to take the
  # lock is it.
  should_load_unencrypted_keys=$(my_lock /tmp/keychain_load_unencrypted_keys && echo true)
  for k in /opt/homebrew/bin/keychain /usr/bin/keychain /opt/local/bin/keychain /usr/local/bin/keychain /opt/boxen/homebrew/bin/keychain; do
      if [ -f $k ]; then
          for i in ~/.ssh/*; do
              if [ -f $i ] && [ -f $i.pub ]; then
                # If the key is encrypted we try to add it, which will causes
                # keychain to prompt for a password in each terminal. This
                # allows us to enter the password in any terminal so we don't
                # have to hunt down which terminal has the password prompt.
                # Also load unencrypted keys if we took the lock earlier.
                if is_key_encrypted "$i" || [[ "$should_load_unencrypted_keys" == "true" ]]; then
                  eval `$k --eval --agents ssh --inherit any $i`

                  # Check to see if the key addition was aborted because the
                  # password was entered elsewhere. If it was we want to display
                  # a message to explain the error that keychain shows.
                  if [ -f "/tmp/keychain_check_killed.`basename $i`.$$" ]; then
                    echo "Key has already been added, aborting keychain (ignore keychain error)."
                    echo
                  fi
                fi
              fi
          done
      fi
  done
fi

cf_date_check_notify
cf_check_for_updates

# homebrew binaries. After this, brew is in PATH, so use brew --prefix
if [[ -d "/opt/homebrew/bin/" ]] ; then
    PATH=/opt/homebrew/bin/:$PATH
else
    PATH=/usr/local/bin/:$PATH
fi

if [[ -s "$HOME/.rvm/scripts/rvm" ]]  ; then source "$HOME/.rvm/scripts/rvm" ; fi
if [[ -d "$HOME/.rbenv" ]] && which rbenv &> /dev/null; then eval "$(rbenv init -)"; fi

# mkdir .git/safe in the root of repositories you trust
PATH=".git/safe/../../bin:$PATH"

# Automatic discovery of your code directory
for dir in ~/code ~/projects; do
  if [ -d $dir ]; then
    CODE_DIR=$dir
    break
  fi
done

if [[ -f "$CODE_DIR/eb/bin/eb" ]]; then
  eval "$($CODE_DIR/eb/bin/eb init -)"
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

if [[ -f "$(brew --prefix)/opt/asdf/libexec/asdf.sh" ]]; then
  source $(brew --prefix)/opt/asdf/libexec/asdf.sh
  if asdf where java &> /dev/null; then
    export JAVA_HOME=`asdf where java`
    export PATH="$JAVA_HOME/bin:$PATH"
  fi
fi

# this is busted: https://github.com/skotchpine/asdf-java/issues/46
# That is why the JAVA_HOME export is above.
# if [[ -f "/usr/local/opt/asdf/asdf.sh" ]]; then
#   source ~/.asdf/plugins/java/bin/asdf-java-wrapper
# fi

if which nodenv &>/dev/null; then
  eval "$(nodenv init -)"
fi

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$(brew --prefix)/Cellar/sbt@0.13/0.13.18_1/bin:$PATH"

if [[ -f "$(brew --prefix)/bin/terraform" ]]; then
    complete -C $(brew --prefix)/bin/terraform terraform
fi

complete -C /opt/homebrew/Cellar/tfenv/3.0.0/versions/1.4.2/terraform terraform
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
