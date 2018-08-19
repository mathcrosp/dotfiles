[[ $- != *i* ]] && return

export EDITOR="/usr/bin/vim"
export VISUAL="/usr/bin/vim"
export GOPATH="$HOME/gopath"
export GOROOT="/usr/lib/go-1.9"
export HISTCONTROL=ignoredups

[ -n "$TMUX" ] && export TERM=screen-256color

alias s='ssh'
alias ls='ls --color=auto'
alias ll='ls -al --color=auto'

txtwht='\e[0;37m' # White
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldblu='\e[1;34m' # Blue

if [ "$(id -u)" == "0" ]; then
  PS1="\[$bldred\]\h\[$bldblu\] \w # \[$txtwht\]"
else
  PS1="\[$bldgrn\]\h\[$bldblu\] \w $ \[$txtwht\]"
fi
