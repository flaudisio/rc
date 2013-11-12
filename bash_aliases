### Aliases

# Core
alias sl='ls -lh'
alias lsl='ls -lh'
alias lsa='ls -lhA'
alias l='lsl'
alias la='lsa'
alias rm='rm -I'

# Misc
alias diff='colordiff'
alias man='PAGER="most -s" man'
alias tree-no-git='tree -aI .git'
alias nano='vim'

# Sudo
alias rsalt='sudo -H salt'
alias gitcmd='sudo -u git -H'
alias wwwcmd='sudo -u www-data -H'

# APT
alias update='sudo aptitude update'
alias safeupgrade='sudo aptitude safe-upgrade'
alias clean='sudo aptitude clean'
alias forget-new='sudo aptitude forget-new'
alias keep-all='sudo aptitude keep-all'

# VirtualBox
alias vminit='vboxheadless --vrde off --startvm'

### Comandos

..() {
    local hops=$1
    local dest=""

    [ -z "$hops" ] && { cd .. ; return ; }

    [[ $hops =~ ^[0-9]+$ ]] || {
        echo "uso: .. [N]" >&2
        return 2
    }

    while [ $hops -gt 0 ] ; do
        dest="${dest}../"
        let 'hops--'
    done

    cd $dest
}

mkcd() {
    if [ -z "$1" ] ; then
        echo "mkcd: missing operand" >&2
        return 1
    fi

    mkdir -pv "$*" || return 1
    cd "$*"
}

fixperms() {
    local v

    [ "$1" = "-v" ] && { v="-v" ; shift ; }

    [ -z "$*" ] && {
        echo "fixperms: missing operand" >&2
        return 1
    }

    echo "Updating directory permissions of '${*}' to 755 (rwxr-xr-x) ..."
    find "${*}" -type d -exec chmod $v 755 {} \;

    [ -n "$v" ] && echo

    echo "Updating file permissions of '${*}' to 644 (rw-r--r--) ..."
    find "${*}" -type f -exec chmod $v 644 {} \;
}

# virtualenvwrapper
load_virtualenv() {
    source /usr/local/bin/virtualenvwrapper.sh || return 1

    export WORKON_HOME=$HOME/.virtualenvs

    [ "$1" ] && {
        workon $1 && echo "Carregando virtualenv: $1"
    }
}
