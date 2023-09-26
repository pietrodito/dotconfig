# Ulys aliases

alias et='enable-touchpad'
alias dt='disable-touchpad'
alias g='emacsclient -nw ~/Comp/balaye-net/content/guitar-repertoire.org'
alias m='emacsclient -nw -e "(magit-status \"$(git rev-parse --show-toplevel)\")"'
alias t='time'
alias c='bat'
alias kbd='~/bin/kbd-setup'
alias v='vim'
alias vi='vim'
alias e='emacsclient -nw'
alias cd..='cd ..'
alias md='mkdir -p'
alias snow='systemctl poweroff -i'
alias rnow='systemctl reboot -i'
alias dodo='systemctl suspend -i'
alias config='/usr/bin/git --git-dir=$HOME/Comp/dotconfig/ --work-tree=$HOME'
alias winconf='/usr/bin/git --git-dir=$HOME/Comp/winconfig/ --work-tree=/mnt/c/Users/pierr/'
alias l='exa -l'
alias la='exa -la'
alias pm='podman'

alias gst='git status . -s'

alias vs='code .'

lh () {sh -c "firefox-developer-edition http://localhost:$1 &> /dev/null &"}
gps () {ps -ax | grep $1}

alias rs='lh 8787'
alias rsudo='docker exec -it rstudio-server bash'
