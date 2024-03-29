# ~/.zshrc
# Read by all interactive shells

# References
# https://dotfiles.github.io/
# HTTps://github.com/zplug/zplug
# https://github.com/unixorn/zsh-quickstart-kit
# http://awesomeawesome.party/awesome-zsh-plugins
# http://reasoniamhere.com/2014/01/11/outrageously-useful-tips-to-master-your-z-shell/
# Ideas: https://github.com/mika/zsh-pony
# Testing YADR: http://www.akitaonrails.com/2017/01/10/arch-linux-best-distro-ever

# Dependencies
# - bat: cat/less replacement
# - gam: CLI for G Suite
# - git
# - hub: git on steroids
# - nvim: vim replacement
# - pydf: df replacement
# - taskwarrior: task management
# - fd: find replacement (installed by zplug)
# - jq: json formatting/queryring (installed by zplug)
# - fzf: fuzzyfinder (installed by zplug)

# Requirements
# Incremental search
# l, ls, hub, docker, df/pydf and other useful aliases
# tip on existing alias
# syntax highlighting
# Case insensitive directories completion
# Shrunk path in prompt
# completion (vboxmanage and all other)
# Fuzzy command line completion
# autosuggestions
# improved history
# vim mode
# push-line to use another command before current command
# colored directories
# colored man pages
# auto cd
# ls after cd
# ssh key management
# simple calc
# 256 color / true color
# git support
# python venv

stty -ixon -ixoff 2>/dev/null # really, no flow control.

[[ $(tmux list-panes 2> /dev/null | wc -l) == 1 ]] && \
    fortune -a    | tr '\n' ' ' | \
                    sed -e "s/ A:/\n\nA:/g"| \
                    sed -e "s/--/\n\n--/g" | \
                    cowsay | ~/bin/center | lolcat

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZPLUG_HOME=~/.zplug

if [ ! -d "$ZPLUG_HOME" ]; then
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

source "$ZPLUG_HOME/init.zsh"


# https://github.com/unixorn/awesome-zsh-plugins
# https://gitlab.yuribugelli.it/yuri/dotfiles/blob/master/zsh/zplug.zsh

# Load completion library for those sweet [tab] squares
# zplug "lib/completion", from:oh-my-zsh

# Load "emoji-cli" if "jq" is installed

zplug "b4b4r07/emoji-cli"

# Improved directory listing
# https://github.com/supercrabtree/k
#zplug "supercrabtree/k"
if (( $+commands[exa] )); then
  zplug "DarrinTisdale/zsh-aliases-exa", use:zsh-aliases-exa.plugin.zsh
fi

# Fortune
if (( $+commands[fortune] )); then
  zplug "plugins/chucknorris", from:oh-my-zsh
fi

# XXX required?
# zplug "chrissicool/zsh-256color"

# Fonts
# Hack Regular Nerd Font Complete
# https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack
# A font with ligatures
# https://github.com/tonsky/FiraCode

# Theme
# Powerlevel10k: https://github.com/romkatv/powerlevel10k
zplug romkatv/powerlevel10k, use:powerlevel10k.zsh-theme

# XXX dircolors comes from brew/coreutils on Mac OS X
# Nordic dircolors configuration
# https://github.com/arcticicestudio/nord-dircolors
zplug "arcticicestudio/nord-dircolors", ignore:"*", as:plugin
eval $(dircolors $ZPLUG_HOME/repos/arcticicestudio/nord-dircolors/src/dir_colors)

# Replacement for zsh-users/zsh-syntax-highlighting
# Theme management: fsh-alias -h
zplug "zdharma/fast-syntax-highlighting"
# Ctrl-R to search multi word with AND
zplug "zdharma/history-search-multi-word"

# Modules from prezto
# https://github.com/sorin-ionescu/prezto/tree/master/modules
# Aliases and color some command output
zplug "modules/utility", from:prezto
zplug "modules/editor", from:prezto
zplug "modules/history", from:prezto
if (( $+commands[tmux] )); then
  zplug "modules/tmux", from:prezto
fi

# Modules from oh-my-zsh
# XXX potentially interesting modules
# brew
# colored-man-pages
# colorize
# common-aliases
# docker
# fzf
# git
# gpg-agent
# history-substring-search
# osx
# pip
# python
# rvm
# terraform
# thefuck
# tmux
# vagrant
# vi-mode
zplug "plugins/shrink-path", from:oh-my-zsh
if (( $+commands[task] )); then
  zplug "plugins/taskwarrior", from:oh-my-zsh
fi
# Hub wrapper
if (( $+commands[hub] )); then
  zplug "plugins/github", from:oh-my-zsh
fi
# Git completion
zplug "plugins/gitfast", from:oh-my-zsh

zplug "webyneter/docker-aliases", use:docker-aliases.plugin.zsh

# Load after modute/editor to enable VI bindings
# zplug "sharat87/zsh-vim-mode", defer:3

# Modules from zsh-usesr
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search", defer:2
# To replace autosuggestions
# zplug "hchbaw/auto-fu.zsh", at:pu, defer:1

# XXX Find replacement allowing to disable check for some aliases
zplug "MichaelAquilina/zsh-you-should-use"

# Usage: = 2+2
zplug "arzzen/calc.plugin.zsh"

# Should be loaded after modules/utility to overwrite cd alias
# https://github.com/b4b4r07/enhancd
zplug "b4b4r07/enhancd", use:init.sh, defer:3
export ENHANCD_FILTER='fzf'
# When entering a git repo do a git status, othewise do an ls
export ENHANCD_HOOK_AFTER_CD='([ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1) && git st || ls -lhrt'
# export ENHANCD_COMMAND='c'
export ENHANCD_DISABLE_HOME=1
export ENHANCD_DISABLE_HYPHEN=1
export ENHANCD_DISABLE_DOT=1
export ENHANCD_HYPHEN_ARG=_
# Run k when entering a directory
# XXX k is too slow, fallback to ls
export ENHANCD_HOOK_AFTER_CD=ls

zplug "zpm-zsh/mysql-colorize"

# XXX Check if required
# XXX Check how to use forward-word with autosuggestions
# Load after modute/editor to enable VI bindings
zplug "sharat87/zsh-vim-mode", defer:3

# Fuzzy command line completion: Ctrl-T
# Grab binaries from GitHub Releases
# and rename with the "rename-to:" tag
# zplug "junegunn/fzf", \
#     from:gh-r, \
#     as:command, \
#     rename-to:fzf, \
#     use:"*${(L)$(uname -s)}*amd64*"

# https://github.com/hschne/fzf-git
# use git <command> **
zplug "hschne/fzf-git"

# Git + fzf
# https://github.com/wfxr/forgit
zplug 'wfxr/forgit'

zplug "so-fancy/diff-so-fancy", as:command

# Clashing with forgit, not sure if useful
# Git aliases
# zplug "plugins/git",   from:oh-my-zsh
# https://github.com/unixorn/git-extra-commands
zplug "unixorn/git-extra-commands"

# Replacement for autojump
zplug "rupa/z", use:"*.sh"

# Replacement for find
zplug "sharkdp/fd"

# Completion for OpenStack
# mirror of https://gist.github.com/philipsd6/aea968e80342973fd8d3aeeda343dae5
zplug "gwarf/a18dbeaa01d6cf14a95c31a1c7036f61", \
    from:gist, \
    as:plugin

# npm / nvm
zplug "lukechilds/zsh-nvm"
# [ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh

# Python virtualenv management


# https://github.com/MichaelAquilina/zsh-autoswitch-virtualenv
# virtualenvs are stored in ~/.virtualenvs
#
# Default autoswitchvirtualenv
# export AUTOSWITCH_DEFAULTENV="defaultenv"
#
# Checking installed python version
# pyenv versions
#
# Creating a venv manually
# python3 -m venv ~/.virtualenvs/impact-report
# source ~/.virtualenvs/impact-report/bin/activate
# echo 'impact-report' > .venv
#
# Deprecated?
# mkvenv --python /usr/bin/python2
# mkvenv --python /usr/bin/python3
# zplug "MichaelAquilina/zsh-autoswitch-virtualenv"

# Potentially lighter than pyenv
# https://github.com/cxreg/smartcd
# https://github.com/anyenv/anyenv
# https://varrette.gforge.uni.lu/blog/2019/09/10/using-pyenv-virtualenv-direnv/
#
# asdf
# git clone https://github.com/asdf-vm/asdf.git ~/.asdf
# asdf plugin-add python https://github.com/tuvistavie/asdf-python.git
# asdf plugin list-all python
# export LDFLAGS="-L/usr/lib/openssl-1.0"; export CFLAGS="-I/usr/include/openssl-1.0"
# asdf plugin install python 2.7
# zplug "plugins/asdf", from:oh-my-zsh
# asdf: https://github.com/asdf-vm/asdf
# https://github.com/kiurchv/asdf.plugin.zsh
# zplug "kiurchv/asdf.plugin.zsh", defer:2

# prezto configuration
# prezto/utility
# Use safe operations by default
zstyle ':prezto:module:utility' safe-ops 'yes'
# Color output (auto set to 'no' on dumb terminals).
zstyle ':prezto:*:*' color 'yes'
# prezto/editor
zstyle ':prezto:module:editor' key-bindings 'vi'
zstyle ':prezto:module:editor' dot-expansion 'yes'
zstyle ':prezto:module:tmux:auto-start' local 'yes'

zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

export PATH="$HOME/.emacs.d/bin:$PATH"

# Path management
typeset -U path
path+=/usr/local/sbin
if [ -d $HOME/bin ]; then
  PATH="$HOME/bin:$PATH"
fi
if [ -d $HOME/.local/bin ]; then
  PATH="$HOME/.local/bin:$PATH"
fi
if [ -d $HOME/.yarn/bin ]; then
  PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
fi

MAILDIR=~/Mail

PROJECT_HOME="$HOME/code"

export PATH MANPATH MAILDIR PROJECT_HOME

# Plugins-specific configuration required after loading them

# For MichaelAquilina/zsh-you-should-use
export YSU_HARDCORE=0

# For zsh-users/zsh-completions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=60,bold"
bindkey '^ ' clear-screen
bindkey '^l' autosuggest-accept

# # XXX Slowing doing the prompt
# if (( $+commands[pyenv] )); then
#   export PYENV_ROOT="${ZPLUG_HOME}/repos/pyenv/pyenv"
#   eval "$(pyenv init --no-rehash - zsh)"
# fi

# ZSH options

# XXX to be checked
# Disable duplicates in substring search
# https://github.com/zsh-users/zsh-history-substring-search/issues/19
# setopt HIST_IGNORE_ALL_DUPS
# setopt HIST_FIND_NO_DUPS

# Enable zmv
autoload -U zmv

# Make sure prompt is able to be generated properly.
# Required for themes like bullet-train
setopt prompt_subst

# Executing directories will open them
setopt auto_cd
# Automatically fill the directory stack
setopt auto_pushd pushd_silent pushd_ignore_dups

## Completion

# Hilight directories and use colors in ZSH completion
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")';

# Rehash when completing commands
zstyle ":completion:*:commands" rehash 1
# Completion menu's navigation with arrows
zstyle ':completion:*' menu select
zstyle ':completion:*:matches' group 'yes'
# let's use the tag name as group name
zstyle ':completion:*' group-name ""
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*:descriptions' format "%{${fg_bold[magenta]}%}= %d =%{$reset_color%}"
# Case insensitive completion
# https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/completion.zsh
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Always use substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey -M vicmd 'j' history-substring-search-down

# In Vi mode use q to allow to use another command before current one
bindkey -M vicmd "q" push-line

# Push a command onto a stack allowing you to run another command first
bindkey '^J' push-line

# Allows editing the command line with an external editor
autoload edit-command-line
zle -N edit-command-line
# Press Esc=v to edit command line
bindkey -M vicmd "v" edit-command-line

# Alt-S inserts sudo at the starts of the line
insert_sudo () { zle beginning-of-line; zle -U '_ ' }
zle -N insert-sudo insert_sudo
bindkey 's' insert-sudo

# Misc

# Preferred terminal
if (( $+commands[kitty] )); then
  export TERMINAL='kitty'
fi

# Preferred editor for local and remote sessions
if (( $+commands[nvim] )); then
  export EDITOR='nvim'
  export MANPAGER='nvim +Man!'
  alias vim='nvim'
  alias vi='nvim'
else
  export EDITOR='vim'
fi

# https://github.com/sharkdp/bat
if (( $+commands[bat] )); then
  export SYSTEMD_PAGER='bat'
  # Fallback as man pager
  if [ -z "$MANPAGER" ]; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  fi
  export BAT_THEME='Dracula'
else
  export SYSTEMD_PAGER='cat'
fi

if (( $+commands[msfconsole] )); then
  alias msfconsole='msfconsole --quiet'
fi

# Manually set language environment
LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8
export LC_ALL LANG

export MAKEOPS='j6'


# --preserver-root is for GNU versions
# do not delete / or prompt if deleting more than 3 files at a time
alias rm='nocorrect rm -i --preserve-root'

# Preventing changing perms on /
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# list only directories
alias lsd='ls -d */'
# list only files
alias lsf="ls -rtF | grep -v '.*/'"
alias l='ls -l'

# Global aliases
alias -g A="| awk"
# Color output using ccze
# XXX ccze -A | less -R
if (( $+commands[ccze] )); then
  alias -g C="| ccze -A"
fi
alias -g G="| grep"
alias -g GV="| grep -v"
alias -g H="| head"
alias -g L='| $PAGER'
alias -g P=' --help | less'
alias -g S="| sed"
alias -g T="| tail"
alias -g V="| vim -R -"
alias -g U=' --help | head'
alias -g W="| wc"

# Suffix aliases
alias -s zip=zipinfo
alias -s tgz=gzcat
alias -s gz=gzcat
alias -s tbz=bzcat
alias -s bz2=bzcat
alias -s java=vim
alias -s c=vim
alias -s h=vim
alias -s C=vim
alias -s cpp=vim
alias -s txt=vim
alias -s xml=vim
alias -s html=chromium
alias -s xhtml=chromium
alias -s pdf=okular
alias -s gif=sxiv
alias -s jpg=sxiv
alias -s jpeg=sxiv
alias -s png=sxiv
alias -s bmp=sxiv
alias -s mp3=clementine
alias -s m4a=clementine
alias -s ogg=clementine

# noremoteglob breaks scp with filenames containing parenthesis
unalias scp
alias scp='noglob scp'

# Aliases for launching some vimwikis
alias vimnote='vim -c VimwikiMakeDiaryNote'
alias vimwiki='vim -c VimwikiUISelect'
alias vimdiary='vim -c VimwikiDiaryIndex'
alias vimwiki_w='vim -c VimwikiIndex 1'
alias vimwiki_h='vim -c VimwikiIndex 2'
alias dashboard="vim -p -c TW -c 'VimwikiTabIndex 1' -c 'VimwikiTabIndex 2'"

# Color iproute2 output
alias ip='ip -color=auto'

# Home-related tasks
alias th='task rc:~/.taskrc-home'

if [[ "$OSTYPE" == "darwin"* ]]; then
  # https://github.com/pyenv/pyenv/wiki/Common-build-problems
  # Required for building python with pyenv on Mac OS X
  CFLAGS="-I/usr/local/opt/openssl/include -I/usr/local/opt/zlib/include -I/usr/local/opt/sqlite/include"
  LDFLAGS="-L/usr/local/opt/openssl/lib -L/usr/local/opt/zlib/lib -L/usr/local/opt/sqlite/lib"
  # Speeding up build
  CFLAGS="-O2 $CFLAGS"
  export CFLAGS LDFLAGS
  # PYTHON_CONFIGURE_OPTS=--enable-unicode=ucs2

  # tail-like of postfix logs on MacOS X
  postfix_log() {
    log stream --predicate '(process == "smtpd") || (process == "smtp") || (process == "master")' --info
  }

  # https://apple.stackexchange.com/questions/3253/ctrl-o-behavior-in-terminal-app
  # To prevent ctrl-o in vim being discared by the terminal driver
  # XXX returning error with updated conf
  # stty: 'standard input': Operation not supported by device
  # stty discard undef

  # cd into whatever is the forefront Finder window.
  cdf() {  # short for cdfinder
    cd "`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`"
  }
fi

# TODO check that vboxmanage completion is available
# /usr/share/zsh/site-functions/_virtualbox
if (( $+commands[VBoxManage] )); then
  compdef vboxmanage=VBoxManage vboxheadless=VBoxHeadless
  compdef VBoxManage=vboxmanage VBoxHeadless=vboxheadless
fi

# Use pydf if available
if (( $+commands[pydf] )); then
  alias df=pydf
fi

if (( $+commands[rlwrap] )); then
  alias listener="sudo rlwrap nc -lvnp 443"
fi

xev() {
  command xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

drun() {
  command docker run --rm -v $(pwd):/source -it "$1"
}

alias stack='docker run -it --rm -v ~/.stack:~/.stack gbraad/openstack-client:centos stack'

# Colorize output using ccze
if (( $+commands[ccze] )); then
  journalctl() {
    command journalctl $@ | ccze -A
  }

  last() {
    command last $@ | ccze -A
  }

  free() {
    command free $@ | ccze -A
  }
fi

# scan the local network and list the connected devices
lscan() {
  local ipRange=$(ip addr | grep -oE "192.168.*.*/[1-9]{2}" | awk -F '.' '{print $3}')
  local scanReport=$(nmap -sn "192.168.$ipRange.1-254/24" | egrep "scan report")
  # echo "$scanReport\n" | sed -r 's#Nmap scan report for (.*) \((.*)\)#\1 \2#'
  printf "$scanReport\n"
}

if [ -x "$HOME/bin/gam/gam" ]; then
  # CLI for Google admin
  # https://github.com/jay0lee/GAM
  gam() { "$HOME/bin/gam/gam" "$@" ; }
fi

if [ -x "$HOME/bin/gamadv-xtd3/gam" ]; then
  # CLI for Google admin, updated GAM
  # https://github.com/taers232c/GAMADV-XTD3
  # gam3() { "$HOME/bin/gam/gam" "$@" ; }
  alias gam3="$HOME/bin/gamadv-xtd3/gam"
fi

# Ensure that appropriate env var are set for gnome-keyring SSH agent
if [ -n "$DESKTOP_SESSION" ]; then
  if [ "$DESKTOP_SESSION" = "i3" -o "$DESKTOP_SESSION" = 'xinitrc' ]; then
    export $(gnome-keyring-daemon -s)
  fi
fi

# Archlinux command not found (needs pkgfile)
if [ -f /usr/share/doc/pkgfile/command-not-found.zsh ]; then
  . /usr/share/doc/pkgfile/command-not-found.zsh
fi

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

# Source secrets if existing
[ -f ~/.secrets.zsh ] && source ~/.secrets.zsh
[ -f ~/.secrets ] && source ~/.secrets
[ -f ~/.appdb-env.sh ] && source ~/.appdb-env.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# User scripts
#
for f in ~/.zsh_user/*.zsh; do
        source "$f";
    done

if [[ "$OSTYPE" == "darwin"* ]]; then
  # Add go to the path
  if [ -d "$HOME/go" ]; then
    export GOPATH="$HOME/go"
    export GOBIN="$GOPATH/bin"
    export GOROOT=/usr/local/opt/go/libexec
    # For github.com/raviqqe/liche
    export GO111MODULE=on
    export PATH="$PATH:$GOBIN"
    export PATH="$PATH:$GOROOT/bin"
  fi
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
[ -d $HOME/.rvm/bin ]; export PATH="$PATH:$HOME/.rvm/bin"
# Load RVM into a shell session *as a function*
[ -s "$HOME/.rvm/scripts/rvm" ] && . "$HOME/.rvm/scripts/rvm"


# fasd
eval "$(fasd --init auto)"

# (cat ~/.cache/wal/sequences &)


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
