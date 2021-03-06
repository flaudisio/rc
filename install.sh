#!/usr/bin/env bash
#
# install.sh
#

BaseDir="$( cd "$( dirname "$0" )" ; pwd )"

LnOpts=""
GitConfig=0
EnvDirs=0
Pathogen=0

usage()
{
    cat << EOF
Uso: $0 [opções]

Opções:
    -f, --force      Sobrescreve os arquivos existentes.
    -g, --gitconfig  Instala o .gitconfig.
    -d, --env-dirs   Cria os diretórios ~/.bashrc.d e ~/.profile.d.
    -p, --pathogen   Instala o pathogen.vim.
    -h, --help       Mostra esta mensagem.
EOF
}

while [[ $# -gt 0 ]] ; do
    case $1 in
        -f|--force)
            LnOpts="-f"
        ;;
        -g|--gitconfig)
            GitConfig=1
        ;;
        -d|--env-dirs)
            EnvDirs=1
        ;;
        -p|--pathogen)
            Pathogen=1
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
    file="$( basename "$f" )"

    if [[ $GitConfig -eq 0 && "$file" == "gitconfig" ]] ; then
        continue
    fi

    ln -sv $LnOpts "$f" "$HOME/.$file"
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
