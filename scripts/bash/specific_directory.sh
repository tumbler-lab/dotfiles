#!/usr/bin/env bash

set -eu -o pipefail

RED_COLOR="\e[31m"
COLOR_OFF="\e[m"

# srcdir=`echo "$1" | cut -d/ -f1`
# targetdir=`echo "$2" | cut -d/ -f1`

srcdir=`find ./ -type d | fzf --preview "cat {}"`
echo "convert wav file in $srcdir to m4a file!"
printf "create output directory: "
read targetdir
while read -r f; do
  # ファイル一つ毎の処理
  echo "file: $f"
  targetfile="${f#*/*/}"
  echo "src: $srcdir/$targetfile"
  echo "target: $targetdir/$targetfile"

done < <(find "$srcdir" -mindepth 1 -type f)





# outputdir=`basename "$zipfile" | rev | cut -d. -f2- | rev`
# printf "create ${RED_COLOR}$outputdir${COLOR_OFF} directory and unzip files to ${RED_COLOR}$outputdir${COLOR_OFF}? (y/N): "
# read yn
# case "$yn" in [yY]*) ;; *) echo "abort" ; exit ;; esac

# unzip "$zipfile" -d "$outputdir"

# printf '\e[34m Success! \e[m'
