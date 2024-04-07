#!/usr/bin/env bash

set -eu -o pipefail

RED_COLOR="\e[31m"
COLOR_OFF="\e[m"

zipfile=`find . -name "*.zip" | fzf --preview "cat {}"`
echo "unzip $zipfile!"
outputdir=`basename "$zipfile" | rev | cut -d. -f2- | rev`
printf "create ${RED_COLOR}$outputdir${COLOR_OFF} directory and unzip files to ${RED_COLOR}$outputdir${COLOR_OFF}? (y/N): "
read yn
case "$yn" in [yY]*) ;; *) echo "abort" ; exit ;; esac

unzip "$zipfile" -d "$outputdir"

printf '\e[34m Success! \e[m'

