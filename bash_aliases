### Aliases

alias lsl='ls -lh'
alias lsa='ls -lhA'
alias sl='lsl'

alias update='sudo aptitude update'
alias safeupgrade='sudo aptitude safe-upgrade --full-resolver'
alias clean='sudo aptitude clean'
alias forget-new='sudo aptitude forget-new'
alias keep-all='sudo aptitude keep-all'

alias debian-init-berserker='vboxheadless --vrde off --startvm Berserker &'
alias debian-init-blackheart='vboxheadless --vrde off --startvm Blackheart &'
alias debian-init-deadpool='vboxheadless --vrde off --startvm Deadpool &'
alias win-init-blaze='vboxheadless --vrde off --startvm Win2k3-blaze &'

### Comandos

mkcd() {
    if [ -z "$1" ] ; then
        echo mkcd: missing operand
        return 1
    fi

    mkdir -pv "$*" || return 1
    cd "$*"
}

fixperms() {
    local arg

    [ -z "$*" ] && {
        echo fixperms: missing operand
        return 1
    }

    [ "$1" = "-v" ] && { arg="-v" ; shift ; }

    echo "Changing directory permissions in '${*}' to 775 (rwxrwxr-x) ..."
    find "${*}" -type d -exec chmod $arg 775 {} \;

    [ -n "$arg" ] && echo

    echo "Changing file permissions in '${*}' to 664 (rw-rw-r--) ..."
    find "${*}" -type f -exec chmod $arg 664 {} \;
}

# virtualenvwrapper
load_virtualenvwrapper() {
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/Devel
    source /usr/local/bin/virtualenvwrapper.sh

    [ "$1" = "-f" ] && workon flaudisio
}
