# /etc/skel/.bash_profile:
# $Header: /home/cvsroot/gentoo-src/rc-scripts/etc/skel/.bash_profile,v 1.10 2002/11/18 19:39:22 azarah Exp $

#This file is sourced by bash when you log in interactively.
[ -f ~/.bashrc ] && . ~/.bashrc

if [[ "$SKIP_KEYCHAIN" != "true" ]]; then
  for k in /usr/bin/keychain /opt/local/bin/keychain /usr/local/bin/keychain /opt/boxen/homebrew/bin/keychain; do
      if [ -f $k ]; then
          for i in ~/.ssh/*; do
  #             [ -f $i ] && [ -f $i.pub ] && bash -x $k --agents ssh --nogui --inherit any $i  >> /tmp/ssh-agent_test.log 2>&1
              [ -f $i ] && [ -f $i.pub ] && $k --agents ssh --nogui --inherit any # $i >> /tmp/ssh-agent_test.log 2>&1
#               [ -f $i ] && [ -f $i.pub ] && $k --nogui --inherit any # $i >> /tmp/ssh-agent_test.log 2>&1
#               [ -f $i ] && [ -f $i.pub ] && eval `$k --eval --inherit any $i`
          done
  #     [ -f ~/.ssh/id_dsa ] && /usr/bin/keychain --nogui ~/.ssh/id_dsa
  #     [ -f ~/.ssh/id_rsa ] && /usr/bin/keychain --nogui ~/.ssh/id_rsa
      fi
  done
fi
[ -f ~/.keychain/$HOSTNAME-sh ] && source ~/.keychain/$HOSTNAME-sh > /dev/null

cf_date_check_notify

cf_check_for_updates

# MacPorts Installer addition on 2011-05-18_at_10:15:20: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

if [[ -s "$HOME/.rvm/scripts/rvm" ]]  ; then source "$HOME/.rvm/scripts/rvm" ; fi
if [[ -d "$HOME/.rbenv" ]] ; then eval "$(rbenv init -)"; fi


# Load eb automatically by adding
# the following to ~/.bash_profile:

eval "$(/Users/jason/projects/eb/bin/eb init -)"
