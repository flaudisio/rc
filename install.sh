#!/usr/bin/env bash
#
# install.sh
#

BaseDir="$( cd "$( dirname "$0" )" ; pwd )"

LnOpts=""
Pathogen=1

while [[ $# -gt 0 ]] ; do
    case $1 in
        -f|--force)
            LnOpts="-f"
        ;;
        -P|--no-pathogen)
            Pathogen=0
        ;;
    esac
    shift
done

echo "--> Instalando arquivos..."

for f in "$BaseDir/dotfiles"/* ; do
    ln -sv $LnOpts "$f" "$HOME/.$( basename "$f" )"
done


if [[ $Pathogen -eq 1 ]] ; then
    if command -v wget &> /dev/null ; then
        echo "--> Instalando pathogen.vim..."

        mkdir -pv ~/.vim/{autoload,bundle}
        wget -q https://tpo.pe/pathogen.vim -O ~/.vim/autoload/pathogen.vim

        sed -i 's/^" execute pathogen/execute pathogen/' "$HOME/.vimrc"
    else
        echo "--> wget não encontrado, pathogen.vim não instalado." >&2
    fi
fi


echo "--> Pronto."
