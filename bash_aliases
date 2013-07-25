### Aliases

# Core
alias ..='cd ..'
alias sl='ls -lh'
alias lsl='ls -lh'
alias lsa='ls -lhA'
alias l='lsl'
alias la='lsa'
alias rm='rm -I'

# Misc
alias man='PAGER="most -s" man'

# Sudo
alias gitcmd='sudo -u git'
alias wwwcmd='sudo -u www-data'

# APT
alias update='sudo aptitude update'
alias safeupgrade='sudo aptitude safe-upgrade --full-resolver'
alias clean='sudo aptitude clean'
alias forget-new='sudo aptitude forget-new'
alias keep-all='sudo aptitude keep-all'

# VirtualBox
alias vbox-init-vm='vboxheadless --vrde off --startvm'
alias debian-init-berserker='vbox-init-vm Berserker &'
alias debian-init-blackheart='vbox-init-vm Blackheart &'
alias debian-init-deadpool='vbox-init-vm Deadpool &'
alias debian-init-mephisto='vbox-init-vm Mephisto &'
alias win-init-blaze='vbox-init-vm Blaze &'

### Comandos

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
    export PROJECT_HOME=$HOME/Devel

    [ $1 ] && {
        echo "Carregando virtualenv: $1"
        workon $1
    }
}
