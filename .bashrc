# This file is sourced by all bash shells on startup, whether interactive
# or not.  This file *should generate no output* or it will break the
# scp and rcp commands.

[[ -f /etc/bash_completion ]] && source /etc/bash_completion
[[ -f $HOME/.bash_completions/git-completion ]] && source $HOME/.bash_completions/git-completion

export INPUTRC="$HOME/.inputrc"
export EDITOR="/usr/bin/emacs"
export GLOBIGNORE='.:..'
export HISTTIMEFORMAT='%c  '
export LC_COLLATE="POSIX"
export ACKRC="$HOME/.ackrc"

# remove the ':' from wordbreaks so we don't have to escape it on teh command line
COMP_WORDBREAKS=${COMP_WORDBREAKS//:}

alias ls='ls --color=auto -F -b -T 0'
alias ll='ls -lh --color=auto -F -b -T 0'
alias lobster="lobster.telaranrhiod.com"
#alias su='su -'
alias la='ls -alh'
alias es='eix'
alias eS='eix -S'
#alias sS='screen -S'
#alias sx='screen -x'
alias sls='screen -ls'
alias sw='screen -wipe'
#alias cfup='((svn info &> /dev/null && svn up) || (echo; echo -n "svn repository not detected, use tbz2? [Y,n]: "; read y; [ "$y" == "" -o "$y" == "y" -o "$y" == "Y" ] && (wget -O - http://cf.telaranrhiod.com/files/common/common_files.tbz2 | tar -xjov --no-same-permissions ./))); exec bash'
alias bgup='(wget -O - http://cf.telaranrhiod.com/files/common/backgrounds.tbz2 | tar -xjov --no-same-permissions -C ~/.fluxbox/backgrounds/)'
alias pgrep='pgrep -iL'
which md5 &> /dev/null || alias md5='md5sum'
alias g='git'
alias g{='git stash'
alias g}='git stash apply'
alias glg='git lg'
complete -o default -o nospace -F _git_log glg
alias gcm='git commit -m'
alias gc="git commit"
alias gca='git commit -a'
alias gcam='git commit -a -m'
alias gs='git status'
alias gst='git status'
alias gco="git checkout"
alias gpp="git pull && git push"
complete -o default -o nospace -F _git_checkout gco
alias gpul="git pull"
complete -o default -o nospace -F _git_pull gpull
alias gpsh="git push"
complete -o default -o nospace -F _git_push gpush
alias gd="git diff"
complete -o default -o nospace -F _git_diff gd
alias gbr="git branch"
complete -o default -o nospace -F _git_branch gbr
alias ga="git add"
complete -o default -o nospace -F _git_add ga

alias cuwork="cucumber ./features -t @shouldwork"
alias cuwip="cucumber ./features -t @wip"
alias cufail="cucumber ./features -t @shouldfail"
alias cuke="cucumber ./features"

alias sc='script/console'
alias sct='RAILS_ENV="test" sc'
alias ss='script/server'

alias ackp='ack --pager="less -r"'
alias acki='ack -i'

alias hn='hcl note'
alias be='bundle exec'

export CF_TARBALL_BACKUP="true"
export CF_BACKUP_COUNT=5
cfup() {
    if [[ "$PWD" != "$HOME" ]]; then
	#you aren't in your home directory, prompt for continuing
	echo
	echo "You do not appear to be in your home directory"
	echo -n "Do you wish to continue? [Y,n]: "
	read
	if ! [[ "$REPLY" == "" || "$REPLY" == "y" || "$REPLY" == "Y" ]]; then
	    return 1
	fi
    fi
    if svn info &> /dev/null; then
	#is repos
	if [[ "`svn info | grep '/svn/home/common_files'`" == "" ]]; then
	#repos isn't common files
	    echo
	    echo "The repository in the current directory does not appear to be the common files."
	    echo -n "Do you wish to use the tarball? [Y,n]: "
	    read
	    if ! [[ "$REPLY" == "" || "$REPLY" == "y" || "$REPLY" == "Y" ]]; then
		return 3
	    fi
	else
	    svn up
	    if [[ "$?" != "0" || "`svn stat | grep '^C'`" != "" ]]; then
		echo
		echo "Error updating repository, check above for more info."
		return 4
	    fi
	    return 0
	fi
    else
    #curr dir isn't repos
	echo
	echo -n "svn repository not detected, use tbz2? [Y,n]: "
	read y
	if ! [[ "$y" == "" || "$y" == "y" || "$y" == "Y" ]]; then
	    return 5
	fi
    fi

    if [[ "$CF_TARBALL_BACKUP" == "true" ]]; then
	TEMPDIR=`mktemp -d -t cf_backup_tmp.XXXXXXXXXXXXXX` &&
	wget -O - http://cf.telaranrhiod.com/files/common/common_files.tbz2 | tar -xjov --no-same-permissions -C $TEMPDIR ./ &&
	date="`date '+%Y-%m-%d--%H-%M-%S'`" &&
  version=`echo $CF_RUNNING_VERSION | awk '{print $1}'` &&
	backup_path="$HOME/.common_files/backups/${date}--r${version}/" &&
	mkdir -p $backup_path &&
	echo "moving new files into place and backing up old files to $backup_path" &&
	rsync -av -b --backup-dir=$backup_path $TEMPDIR/ ./ &&
	rm -rv $TEMPDIR &&
#	cp --parents `find | grep '.*.cf.bkp$' | grep -v '\.common_files/backups/'` $backup_path &&
#	rm -rf `find | grep '.*.cf.bkp$' | grep -v '\.common_files/backups/'` &&

	if [[ "$CF_BACKUP_COUNT" != "" && "$CF_BACKUP_COUNT" -ge "0" ]] &> /dev/null; then
	    old_backups="`ls $HOME/.common_files/backups/ | sort | head -n -${CF_BACKUP_COUNT}`"
	    if [[ "$old_backups" != "" ]]; then
		echo "Removing old backups ($old_backups) due to a CF_BACKUP_COUNT of $CF_BACKUP_COUNT"
		(cd $HOME/.common_files/backups/ && rm -rf $old_backups)
	    fi
	fi

    else
	wget -O - http://cf.telaranrhiod.com/files/common/common_files.tbz2 | tar -xjov --no-same-permissions ./
    fi

    if [[ "$?" != "0" ]]; then
	echo
	echo "Error downloading or extracting tar, check above for more info."
	return 2
    fi

    echo
    echo "Performing 'exec bash' to pick up updates."
    exec bash
}

sS() {
    if [[ "$2" != "" ]]; then
	ssh -t $2 screen -S $1
    else
	screen -S $1
    fi
}

sx() {
    if [[ "$2" != "" ]]; then
	ssh -t $2 screen -x $1
    else
	screen -x $1
    fi
}

psg() {
    ps aux | grep "$*" | grep -v "grep .*$*"
}

known_hosts_temp_file=~/.ssh/temp_known_hosts_file
set_temp_known_host() {
    rm ${known_hosts_temp_file} &> /dev/null
    # we use xxx because we want this to fail to login, just set the known host
    ssh -o 'StrictHostKeyChecking=no' -o 'PreferredAuthentications="xxx"' -o "UserKnownHostsFile=${known_hosts_temp_file}" $* &> /dev/null
}
pssh() {
    set_temp_known_host $*
    cat ${known_hosts_temp_file} >> ~/.ssh/known_hosts
    ssh $*
}
tssh() {
    set_temp_known_host $*
    ssh -o "UserKnownHostsFile=${known_hosts_temp_file}" $*   
}

vncvia() {
    if [[ "$*" == "" ]]; then
	echo "usage:   vncvia [user@]remotehost [other vnc options...]"
    else
	echo "vncviewer -via $* localhost"
	vncviewer -via $* localhost
    fi
}

alias cd='pushd -n $PWD &> /dev/null; cd'
# cf_cd() {
#     pushd -n "$PWD" &> /dev/null
#     /usr/bin/cd "$@" || popd -n &> /dev/null
# }
# alias cd='cf_cd' # put this below cf_cd so when cf_cd is read 'cd' isn't expanded making it recursive

#min seconds between notifications of new common files.
export CF_TIME_BETWEEN_NOTIFICATIONS=86400
last_notified_date_path="$HOME/.common_files/.out_of_date_last_notified_date"
notification_message_path="$HOME/.common_files/.out_of_date_notification_message"

cf_date_check_notify() {
#if it isn't the same day as the last time we told you and
#we found that you were out of date last time you logged in we're going to tell you about it now.
    last_date=0
    [ -f $last_notified_date_path ] && last_date=`cat $last_notified_date_path`
    let "new_date = $last_date + $CF_TIME_BETWEEN_NOTIFICATIONS"
    if [[ "$new_date" -lt "`date '+%s'`" ]]; then
	[ -f $notification_message_path ] && cat $notification_message_path && echo "`date '+%s'`" > $last_notified_date_path
    fi
}

cf_get_latest_local_version() {
    #get your current revision number
    if which git &> /dev/null; then
	      my_rev=`(git --git-dir $HOME log -1 --pretty=format:"%H %ad") 2> /dev/null`
    fi	
	  if [[ "$my_rev" == "" ]]; then
	      #couldn't get version from svn so we'll try .common_files/latest_revision.txt
	      my_rev=`cat "$HOME/.common_files/.latest_revision" 2> /dev/null`
	  fi
	  if [[ "$my_rev" == "" ]]; then
	      return 1
	  fi
    
	  CF_LOCAL_LATEST_VERSION=$my_rev
    
	  return 0
}

cf_get_latest_local_version
CF_RUNNING_VERSION="$CF_LOCAL_LATEST_VERSION"
CF_LOCAL_LATEST_VERSION="$CF_RUNNING_VERSION";

cf_check_for_updates() {
#first paren executes rest in subshell so we don't see the output from the job finishing
#second peren and its & lump this block together and execute it in the background to it happens asynchronously and we don't hold up shell startup
((
#checking to see if you're up to date
#make sure you have curl and svn
        if which git curl &> /dev/null; then
            #get the latest revision number, this should just be an integer.
            latest=`curl -sL http://cf.telaranrhiod.com/files/common/latest_revision.txt`
            #make sure curl returned successfully
            if [[ "$?" == "0" ]]; then
                #	my_rev="`cf_get_latest_local_version`"
                cf_get_latest_local_version
	              my_rev=$CF_LOCAL_LATEST_VERSION
              	#check if you're up to date
                latest_hash=`echo $latest | awk '{print $1}'`
                my_hash=`echo $my_rev | awk '{print $1}'`
	              if [[ "$latest_hash" != "$my_hash" ]]; then 
              	    #if not, create the .out_of_date file with the appropriate message so next time you start a terminal we can alert you.
	                  echo "Not on latest revision of common_files.  Latest: $latest, yours: $my_rev" > $notification_message_path
	              else
              	    #if you're up to date we don't need this file
	                  [ -f $notification_message_path ] && rm $notification_message_path
	              fi
            fi
        fi
) &)
}

#min seconds between checking for new common files.
export CF_TIME_BETWEEN_UPDATES=86400

cf_date_check_for_updates() {
    last_checked_for_updates_date_path="$HOME/.common_files/.last_checked_date"
    last_date=0
    [ -f $last_checked_for_updates_date_path ] && last_date=`cat $last_checked_for_updates_date_path`
    let "new_date = $last_date + $CF_TIME_BETWEEN_UPDATES"
    if [[ "$new_date" -lt "`date '+%s'`" ]]; then
	cf_check_for_updates
	echo "`date '+%s'`" > $last_checked_for_updates_date_path
    fi
}

cf_prompt_command() {
#    old_hist_time_format=$HISTTIMEFORMAT
#    HISTTIMEFORMAT='%s  '
#    hist_cmd=`history 1`
#    HISTTIMEFORMAT=$old_hist_time_format
#    history 10
#    begin_hist=`begin_hist_grep $hist_cmd`
#    history -p '!!:1'
#    set | grep sleep
#    foo=">${hist_cmd/$begin_hist  $BASH_COMMAND/}--$begin_hist--$BASH_COMMAND<"
#    echo $foo
#    [[ "${hist_cmd/$begin_hist  $BASH_COMMAND/}" == "" ]] && echo "hooray"
#    history 10
    history -a
#    history 10
    ((cf_date_check_for_updates) &)
    cf_date_check_notify
    [[ "$CF_RUNNING_VERSION" != "$CF_LOCAL_LATEST_VERSION" ]] && exec bash
#    cf_long_running_task_check
    [[ "`declare -f cf_user_prompt_hook`" != "" ]] && cf_user_prompt_hook
}


#export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;
#35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;
#31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;
#31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jpg=01;
#35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;
#35:*.tif=01;35:*.png=01;35:*.mpg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;
#35:*.dl=01;35::'

#Keeps the terminal from doing funky wrapping stuff
shopt -s checkwinsize

#append to history file on exit instead of overwriting
shopt -s histappend

#don't try to tab complete an empty line
shopt -s no_empty_cmd_completion

#correct minor directory misspellings
shopt -s cdspell

#let * match files beginning with '.' but since GLOBIGNORE is set above it won't match '.' or '..'
shopt -s dotglob

FG_BLACK="\[\033[01;30m\]"
FG_WHITE="\[\033[01;37m\]"
FG_RED="\[\033[01;31m\]"
FG_GREEN="\[\033[01;32m\]"
FG_BLUE="\[\033[01;34m\]"
NO_COLOR="\[\e[0m\]"

WHOAMI="`/usr/bin/whoami`"

#make eterm into xterm for emacs/ssh purposes
if [[ "$TERM" = "eterm-color" ]]; then
    export CF_REAL_TERM=$TERM
    export TERM="xterm-color"
fi

#build PS1
#don't set PS1 for dumb terminals
if [[ "$TERM" != 'dumb' ]] && [[ -n "$BASH" ]]; then
    PS1=''
    #don't modify titlebar on console
    [[ "$TERM" != 'linux' && "$CF_REAL_TERM" != "eterm-color" ]] && PS1="${PS1}\[\e]2;\u@\H:\W\a"

    #use a red $ if you're root, white otherwise
    if [[ $WHOAMI = "root" ]]; then
    	  #red hostname
	      PS1="${PS1}${FG_RED}\u@"
    else
      	#green user@hostname
     	  PS1="${PS1}${FG_GREEN}\u@"
    fi
 
    GIT_PS1_SHOWDIRTYSTATE=1
    #working dir basename and prompt
    PS1="${PS1}\h ${FG_RED}\$(__git_ps1 "[%s]") ${FG_BLUE}\W ${FG_BLUE}\$ ${NO_COLOR}"
fi

#make eterm into xterm for emacs/ssh purposes
if [[ "$TERM" = "eterm-color" ]]; then
    export TERM="xterm-color"
fi

if [[ $WHOAMI = 'root' ]]; then
        export PATH="/bin:/sbin:/usr/bin:/usr/sbin:${ROOTPATH}"
else
        export PATH="/bin:/usr/bin:${PATH}"
fi

[[ "$HOME" == "" ]] && export HOME=`grep -e "^[^:]*\:[^:]*\:$UID\:" /etc/passwd | awk -F ':' '{print $6}'`

export BC_ENV_ARGS="$HOME/.bcrc"

#Extend command history
export HISTSIZE=5000000

#Repeated commands are only stored once
export HISTCONTROL=ignoreboth

#save history with each command
export PROMPT_COMMAND='[[ "`set | grep -E \"cf_prompt_command \(\)\"`" != "" ]] && cf_prompt_command'

if ! shopt -q login_shell; then
    if [ -f /usr/bin/keychain ]; then
	[ -f ~/.ssh/id_dsa ] && /usr/bin/keychain --noask ~/.ssh/id_dsa &> /dev/null
	[ -f ~/.ssh/id_rsa ] && /usr/bin/keychain --noask ~/.ssh/id_rsa &> /dev/null
    fi
    [ -f ~/.keychain/$HOSTNAME-sh ] && source ~/.keychain/$HOSTNAME-sh > /dev/null &> /dev/null
fi


# load any OS specific changes we've made
[ -f ~/.common_files/cf.`uname -s`.conf ] && . ~/.common_files/cf.`uname -s`.conf

#last, but not least, source a configuration file so there's an easy place for users to make configuration changes from the default
[ -f ~/.common_files/cf.conf ] && . ~/.common_files/cf.conf

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

[ -f ~/.bundler-exec.sh ] && source ~/.bundler-exec.sh
