#!/usr/bin/env bash
#
# install.sh
#

BaseDir="$( cd "$( dirname "$0" )" ; pwd )"

LnOpts=""
Pathogen=1

usage()
{
    cat << EOF
Uso: $0 [-f] [-P] [-h]

Opções:
    -f, --force         Sobrescreve os .arquivos existentes.
    -P, --no-pathogen   Não instala o pathogen.vim.
    -h, --help          Esta mensagem.
EOF
}

while [[ $# -gt 0 ]] ; do
    case $1 in
        -f|--force)
            LnOpts="-f"
        ;;
        -P|--no-pathogen)
            Pathogen=0
        ;;
        -h|--help)
            usage ; exit 0
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
    else
        echo "--> wget não encontrado, pathogen.vim não instalado." >&2
    fi
else
    echo "--> Pulando instalação do pathogen.vim."
fi


echo "--> Pronto."
