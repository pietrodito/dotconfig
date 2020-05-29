alias cd..='cd ..'
alias md='mkdir -p'
alias snow='systemctl poweroff -i'
alias rnow='systemctl reboot -i'
alias dodo='systemctl suspend -i'
alias config='/usr/bin/git --git-dir=$HOME/Comp/dotconfig/ --work-tree=$HOME'
gps () {ps -ax | grep $1}
