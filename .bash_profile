# /etc/skel/.bash_profile:
# $Header: /home/cvsroot/gentoo-src/rc-scripts/etc/skel/.bash_profile,v 1.10 2002/11/18 19:39:22 azarah Exp $

#This file is sourced by bash when you log in interactively.
[ -f ~/.bashrc ] && . ~/.bashrc

for k in /usr/bin/keychain /opt/local/bin/keychain; do
    if [ -f $k ]; then
        for i in ~/.ssh/*; do
            [ -f $i ] && [ -f $i.pub ] && $k --nogui $i
        done
#     [ -f ~/.ssh/id_dsa ] && /usr/bin/keychain --nogui ~/.ssh/id_dsa
#     [ -f ~/.ssh/id_rsa ] && /usr/bin/keychain --nogui ~/.ssh/id_rsa
    fi
done
[ -f ~/.keychain/$HOSTNAME-sh ] && source ~/.keychain/$HOSTNAME-sh > /dev/null

cf_date_check_notify

cf_check_for_updates

if [[ -s "$HOME/.rvm/scripts/rvm" ]]  ; then source "$HOME/.rvm/scripts/rvm" ; fi


##
# Your previous /Users/jason/.bash_profile file was backed up as /Users/jason/.bash_profile.macports-saved_2011-05-18_at_10:15:20
##

# MacPorts Installer addition on 2011-05-18_at_10:15:20: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

