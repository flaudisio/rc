#!/usr/bin/env bash
#
# install.sh
#

BaseDir="$( cd "$( dirname "$0" )" ; pwd )"

LnOpts=""
EnvDirs=1
Pathogen=1

usage()
{
    cat << EOF
Uso: $0 [-f] [-B] [-P] [-h]

Opções:
    -f, --force         Sobrescreve os .arquivos existentes.
    -D, --no-env-dirs   Não cria os diretórios ~/.bashrc.d e ~/.profile.d
    -P, --no-pathogen   Não instala o pathogen.vim.
    -h, --help          Esta mensagem.
EOF
}

while [[ $# -gt 0 ]] ; do
    case $1 in
        -f|--force)
            LnOpts="-f"
        ;;
        -D|--no-env-dirs)
            EnvDirs=0
        ;;
        -P|--no-pathogen)
            Pathogen=0
        ;;
        -h|--help)
            usage ; exit 0
        ;;
        *)
            echo -e "Opção desconhecida: $1\n\n$( usage )" >&2
            exit 2
        ;;
    esac
    shift
done

echo "--> Instalando arquivos..."

for f in "$BaseDir/dotfiles"/* ; do
    ln -sv $LnOpts "$f" "$HOME/.$( basename "$f" )"
done

if [[ $EnvDirs -eq 1 ]] ; then
    echo "--> Criando diretórios adicionais..."
    mkdir -pv ~/.bashrc.d ~/.profile.d
fi

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
