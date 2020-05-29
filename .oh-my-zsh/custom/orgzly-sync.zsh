orgzly-sync () {
    if [[ $# -eq 0 ]] ; then
        ls ~/Dropbox/Org/Links/
    fi

    if [[ $# -eq 1 ]] ; then
    ln -sf `pwd`/$1 ~/Dropbox/Org/Links/
    fi
}
