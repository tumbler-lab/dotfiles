#!/usr/bin/env bash

set -eu -o pipefail

RED_COLOR="\e[31m"
BLUE_COLOR="\e[34m"
COLOR_OFF="\e[m"

PRINT_PROGRESSBAR="print_progressbar.sh"
CONVERT_TO_WAV="convert_to_wav.sh"

unset srcfile
unset dstfile
srcfile="xxx.m"
dstfile="xxx.wav"

function echo_m4a {
  echo $srcfile
  echo $dstfile
}

srcdir=`find ./ -mindepth 1 -maxdepth 1 -type d | fzf --preview "cat {}"`
count_files=`find $srcdir -mindepth 1 -type f | wc -l`
echo "convert m4a|wma file in $srcdir to wav file! (total: $count_files)"
printf "create output directory: "
read outputdir
if [[ "$outputdir" == "" ]] ;then
  printf "$RED_COLOR output directory is empty...$COLOR_OFF \n"
  exit 1
fi

percent=0
i=0
# めっちゃおそい
while read -r f; do
  # ファイル一つ毎の処理
  targetfile="${f#*/*/}"
  srcfile="$srcdir/$targetfile"
  if [[ "$targetfile" =~ .*\.(m4a|wma|flac) ]] ;then
    dstfile="$outputdir/${targetfile%.*}.wav"
    dstdir="`echo "$dstfile" | rev | cut -d/ -f2- | rev`"
    if [[ ! -e "$dstfile"  ]] ;then
      printf "\nconvert $srcfile to $dstfile\n"
      # errorが出る？ので`set -e`やめる
      set +e
      mkdir -p "$dstdir" && eval '"$CONVERT_TO_WAV" "$srcfile" "$dstfile"'
      set -e
    fi
  else
    dstfile="$outputdir/$targetfile"
    dstdir="`echo "$dstfile" | rev | cut -d/ -f2- | rev`"
    # echo "$dstdir"
    # echo "$srcfile"
    # echo "$dstfile"
    if [[ ! -e "$dstfile"  ]] ;then
      printf "\n copy $srcfile to $dstfile\n"
      mkdir -p "$dstdir" && cp "$srcfile" "$dstfile"
    fi
  fi
  # errorが出る？ので`set -e`やめる
  set +e
  i="`expr "$i" + 1`"
  percent="`expr "$i" \* 100 / "$count_files"`"
  eval '"$PRINT_PROGRESSBAR" "$percent"'
  set -e
done < <(find "$srcdir" -mindepth 1 -type f)
printf "\n"
printf "$BLUE_COLOR All audio file to m4a file! $COLOR_OFF \n"
