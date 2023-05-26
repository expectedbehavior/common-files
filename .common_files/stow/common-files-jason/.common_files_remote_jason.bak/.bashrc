[ -f /etc/bash.bashrc ] && source /etc/bash.bashrc

export INPUTRC="$HOME/.common_files_remote_jason/.inputrc"
export SCREENRC="$HOME/.common_files_remote_jason/.screenrc"
export EDITOR="/usr/bin/emacsclient"
export ALTERNATE_EDITOR="emacs"
export GLOBIGNORE='.:..'
export HISTTIMEFORMAT='%c  '
export LC_COLLATE="POSIX"
export ACKRC="$HOME/.ackrc"

# remove the ':' from wordbreaks so we don't have to escape it on teh command line
COMP_WORDBREAKS=${COMP_WORDBREAKS//:}

alias ls='ls --color=auto -F -b -T 0'
alias ll='ls -lh --color=auto -F -b -T 0'
alias lobster="lobster.telaranrhiod.com"
alias la='ls -alh'
alias es='eix'
alias eS='eix -S'
alias sls='screen -ls'
alias sw='screen -wipe'
alias bgup='(wget -O - http://cf.telaranrhiod.com/files/common/backgrounds.tbz2 | tar -xjov --no-same-permissions -C ~/.fluxbox/backgrounds/)'
alias pgrep='pgrep -iL'
which md5 &> /dev/null || alias md5='md5sum'


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

    # GIT_PS1_SHOWDIRTYSTATE=1
    #working dir basename and prompt
    # PS1="${PS1}\h ${FG_RED}\$(__git_ps1 "[%s]") ${FG_BLUE}\W ${FG_BLUE}\$ ${NO_COLOR}"
    PS1="${PS1}\h ${FG_BLUE}\W ${FG_BLUE}\$ ${NO_COLOR}"
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

[ -f ~/.bashrc ] && source ~/.bashrc
[ -f ~/.profile ] && source ~/.profile
[ -f ~/.bash_profile ] && source ~/.bash_profile

[ -f /etc/motd ] && cat /etc/motd
