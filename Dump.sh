#!/bin/sh
set -e

#USAGE:
## $1 represents the optimization level + whether or not to specialize

if ! test -d "dump"; then
    mkdir "dump"
fi

case "$1" in
    "O0") opt="-O0"; spec="-fno-specialize";;
    "O2N") opt="-O2"; spec="-fno-specialize";;
    "O2Y") opt="-O2"; spec="-fspecialize";;
    *) exit 1
esac

for src in Sort Main
do  ghc -fforce-recomp "$opt" "$spec" "$src" -ddump-simpl -dno-typeable-binds -dsuppress-all -ddump-to-file -ddump-file-prefix="dump/${1}-${src}" >/dev/null
done

exit 0
