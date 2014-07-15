# /etc/skel/.bash_profile:
# $Header: /home/cvsroot/gentoo-src/rc-scripts/etc/skel/.bash_profile,v 1.10 2002/11/18 19:39:22 azarah Exp $

#This file is sourced by bash when you log in interactively.
[ -f ~/.bashrc ] && . ~/.bashrc

for k in /usr/bin/keychain /opt/local/bin/keychain /usr/local/bin/keychain; do
    if [ -f $k ]; then
        for i in ~/.ssh/*; do
            [ -f $i ] && [ -f $i.pub ] && $k --nogui --inherit any $i
        done
#     [ -f ~/.ssh/id_dsa ] && /usr/bin/keychain --nogui ~/.ssh/id_dsa
#     [ -f ~/.ssh/id_rsa ] && /usr/bin/keychain --nogui ~/.ssh/id_rsa
    fi
done
[ -f ~/.keychain/$HOSTNAME-sh ] && source ~/.keychain/$HOSTNAME-sh > /dev/null

cf_date_check_notify

cf_check_for_updates

if [[ -s "$HOME/.rvm/scripts/rvm" ]]  ; then source "$HOME/.rvm/scripts/rvm" ; fi
if [[ -d "$HOME/.rbenv" ]] ; then eval "$($HOME/.rbenv/bin/rbenv init -)"; fi

# Automatic discovery of your code directory
for dir in ~/code ~/projects; do
  if [ -d $dir ]; then
    CODE_DIR=~/code
    break
  fi
done

if [[ -f "$CODE_DIR/eb/bin/eb"]]; then
  eval "$($CODE_DIR/eb/bin/eb init -)"
fi
