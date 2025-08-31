#!/bin/sh
set -e

#USAGE:
## $1 represents the size of the List to sort
## $2 represents the optimization level + whether or not to specialize

if ! test -d "prof"; then
    mkdir "prof"
fi

size=$1

case "$2" in
    "O0") opt="-O0"; spec="-fno-specialize";;
    "O2N") opt="-O2"; spec="-fno-specialize";;
    "O2Y") opt="-O2"; spec="-fspecialize";;
    *) exit 1
esac

for src in Sort Main
do  ghc -fforce-recomp "$opt" "$spec" -rtsopts -prof $src >/dev/null
done

for c in 0 1 2 3
do  printf "ON %s WITH %s VIA \'sort%s\':\n" "$1" "$2" "$c"
    ./Main "$c" "$size" >/dev/null +RTS -s -hy -p -po"prof/${2}-sort${c}" -l -ol"prof/${2}-sort${c}.eventlog"
    eventlog2html "prof/${2}-sort${c}.eventlog" -o "prof/${2}-sort${c}.eventlog.html"
done

exit 0
