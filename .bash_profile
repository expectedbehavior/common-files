# /etc/skel/.bash_profile:
# $Header: /home/cvsroot/gentoo-src/rc-scripts/etc/skel/.bash_profile,v 1.10 2002/11/18 19:39:22 azarah Exp $

#This file is sourced by bash when you log in interactively.
[ -f ~/.bashrc ] && . ~/.bashrc

# Setup a process to automatically kill password prompts when an ssh key is
# loaded in a different terminal.
if my_lock /tmp/keychain_check.lock; then
  # lock succeeded
  echo "Starting keychain monitor process"

  ((
    sleep 10 # wait for keychain processes to start
    while ps aux | grep keychai[n] &> /dev/null; do
      sleep 1
      for loaded_key in `ssh-add -l | awk '{print $3}'`; do
        # If a key has already been loaded into the SSH agent then look for
        # other processes trying to load that key. They can be killed since the
        # key is already loaded.

        # pids=$(pstree $PPID | grep -oE '([0-9]+.*)' | grep ssh-add | grep "$loaded_key" | grep -v grep | awk '{print $1}')
        pids=$(ps aux | grep ssh-add | grep "$loaded_key" | grep -v grep | awk '{print $2}')
        for pid in $pids; do
          if [[ "$pid" != "" ]]; then

            # Let other terminals know that keychain is being aborted so they
            # can display a nice message.
            other_bash_pid=$(pstree -p $pid | grep -oE '([0-9]+.*)' | grep bash | grep -v grep | head -n 1 | awk '{print $1}')
            file="/tmp/keychain_check_killed.`basename $loaded_key`.$other_bash_pid"
            touch "$file"

            kill "$pid"
          fi
        done
      done
    done
  ) & ) # 2> /dev/null

fi

is_key_encrypted() {
  grep ENCRYPTED "$1" &> /dev/null
}

if [[ "$SKIP_KEYCHAIN" != "true" ]]; then
  # Only one process needs to load the unencrypted keys, the first to take the
  # lock is it.
  should_load_unencrypted_keys=$(my_lock /tmp/keychain_load_unencrypted_keys && echo true)
  for k in /usr/bin/keychain /opt/local/bin/keychain /usr/local/bin/keychain /opt/boxen/homebrew/bin/keychain; do
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
