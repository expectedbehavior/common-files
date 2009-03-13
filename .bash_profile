# /etc/skel/.bash_profile:
# $Header: /home/cvsroot/gentoo-src/rc-scripts/etc/skel/.bash_profile,v 1.10 2002/11/18 19:39:22 azarah Exp $

#This file is sourced by bash when you log in interactively.
[ -f ~/.bashrc ] && . ~/.bashrc

if [ -f /usr/bin/keychain ]; then
    [ -f ~/.ssh/id_dsa ] && /usr/bin/keychain --nogui ~/.ssh/id_dsa
    [ -f ~/.ssh/id_rsa ] && /usr/bin/keychain --nogui ~/.ssh/id_rsa
fi
[ -f ~/.keychain/$HOSTNAME-sh ] && source ~/.keychain/$HOSTNAME-sh > /dev/null



cf_date_check_notify



cf_check_for_updates

#testing
