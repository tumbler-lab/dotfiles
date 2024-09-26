#!/usr/bin/env bash

set -u -o pipefail

ECHO='echo -e'
case `$ECHO` in
    -e)
        ECHO=echo;;
esac

percent=$1
width=71
column="`expr "$width" \* "$percent" / 100`"
nspace="`expr "$width" - "$column"`"

bar='\r|'
set dummy
while [ $# -le $column ]
do
    bar=$bar'█'
    set - "$@" dummy
done
bar=$bar'█'

set dummy
while [ $# -le $nspace ]
do
    bar=$bar' '
    set - "$@" dummy
done
bar=$bar'| '$percent'%\c'
$ECHO "$bar"
