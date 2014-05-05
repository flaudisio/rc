#!/bin/sh

BaseDir="$( readlink -f "$( dirname "$0" )" )"

LnOpts="$@"

echo "Criando links..."

for f in "$BaseDir/files"/* ; do
    ln -sv $LnOpts "$f" "$HOME/.$( basename "$f" )"
done

echo "Pronto."