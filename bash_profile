[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.mongodb/bin:$PATH"
export PATH="$PATH:$HOME/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export EDITOR=nvim
# export TERM=screen-256color

# Git branch in prompt.
# Nicer bash prefix with git branch
GIT_PS1_SHOWDIRTYSTATE=1
source ~/.git-prompt.sh
# Custom bash prompt via kirsle.net/wizards/ps1.html
export PS1="\[$(tput bold)\]\[$(tput setaf 2)\]\[$(tput setaf 3)\]\w\$(__git_ps1 '\[\033[1;35;1m\] (%s)\[\033[0m\]')\[$(tput setaf 2)\]\\$ \[$(tput sgr0)\]"

alias reboot-shell='source ~/.bash_profile'
alias tmux='tmux -2'
alias cdg='cd ~/Work/Shore/git'
alias cdw='cd ~/Work'
alias ll='ls -al'
alias wmuc='curl -4 http://wttr.in/Munich'
alias wsof='curl -4 http://wttr.in/Sofia'
alias wcph='curl -4 http://wttr.in/Fredensborg'
alias wobnova='curl -4 http://wttr.in/Obnova'
alias weather='curl -4 http://wttr.in/'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
