# Ulys aliases

alias c='batcat'
alias cat='batcat'
alias v='vim'
alias vi='vim'
alias cd..='cd ..'
alias md='mkdir -p'
alias snow='systemctl poweroff -i'
alias rnow='systemctl reboot -i'
alias dodo='systemctl suspend -i'
alias config='/usr/bin/git --git-dir=$HOME/Comp/dotconfig/ --work-tree=$HOME'
alias winconf='/usr/bin/git --git-dir=$HOME/Comp/winconfig/ --work-tree=/mnt/c/Users/pierr/'
alias l='exa -l'
gps () {ps -ax | grep $1}
