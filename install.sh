#!/bin/sh

BaseDir="$( readlink -f "$( dirname "$0" )" )"

echo "Criando links..."

for f in \
    bash_aliases gitconfig screenrc terminalrc vimrc
do
    ln -sv "$BaseDir/$f" "$HOME/.$f"
done

echo "Pronto."
