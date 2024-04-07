#!/usr/bin/env bash

set -eu -o pipefail

RED_COLOR="\e[31m"
COLOR_OFF="\e[m"

FFMPEG='ffmpeg -nostdin -hide_banner -loglevel error -y'

unset tmpfile
unset tmpmetafile
# 一時ファイルの作成
tmpfile=$(mktemp "/tmp/${0##*/}.tmp.XXXXXX.m4a")
tmpmetafile=$(mktemp "/tmp/${0##*/}_meta.tmp.XXXXXX")

function rm_tmpfiles {
  [[ -f "$tmpfile" ]] && rm -f "$tmpfile"
  [[ -f "$tmpmetafile" ]] && rm -f "$tmpmetafile"
  echo "remove all tmp files!"
}
## 正常終了時の処理
trap rm_tmpfiles EXIT
## 異常終了時の処理
trap 'rc=$?; trap - EXIT; rm_tmpfiles; exit $?' INT PIPE TERM

# metadataをtmpmetafileにutf-8で保存
$FFMPEG -i "$1" -f ffmetadata "$tmpmetafile"
nkf -w --overwrite "$tmpmetafile"

# tmpfileにm4aを保存．このままだとmetadataが文字化けしているのでtmpmetafileを使ってmetadataを上書きする．
# ffmpeg -y -i "$1" -vn -acodec aac -aac_coder twoloop -ar 48000 -ab 320k "$tmpfile"のときにcodecを指定できないため
# dstfile="${1%.*}.m4a"
$FFMPEG -i "$1" -vn -acodec aac -aac_coder twoloop -ar 48000 -ab 320k "$tmpfile";
# ffmpeg -y -i "$tmpfile" -i "$tmpmetafile" -map_metadata 1 -codec copy "$dstfile"
$FFMPEG -i "$tmpfile" -i "$tmpmetafile" -map_metadata 1 -codec copy "$2"

printf '\e[34m Success! \e[m'

