[[ -f $HOME/.bash_completions/git-completion ]] && source $HOME/.bash_completions/git-completion

alias g='git'
alias g{='git stash'
alias g}='git stash apply'
alias glg='git log --graph --pretty=format:"%C(bold red)%h%Creset -%C(yellow)%d%Creset %s %C(yellow)-%Creset %C(bold blue)%an%Creset %C(bold green)(%cr)%Creset"'
complete -o default -o nospace -F _git_log glg
alias gdc='git diff --cached'
complete -o default -o nospace -F _git_diff gdc
alias gcm='git commit -m'
alias gc="git commit"
alias gca='git commit -a'
alias gcam='git commit -a -m'
alias gs='git status'
alias gst='git status'
alias gco="git checkout"
alias gu="git reset HEAD"
alias ghr="git log -n1 --pretty=format:'%C(bold red)%h%Creset'"
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
