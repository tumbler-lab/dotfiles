#!/usr/bin/env bash

set -eu -o pipefail

RED_COLOR="\e[31m"
BLUE_COLOR="\e[34m"
COLOR_OFF="\e[m"

# eval '/mnt/c/Program\ Files/Microsoft\ Office/root/Office16/WINWORD.EXE "$1" /mFilePrintDefault /mFileExit /q /n'


# eval '/mnt/c/Program\ Files/Microsoft\ Office/root/Office16/WINWORD.EXE /mFilePrintDefault /mFileExit /q /n /t "$1"'

printf "\n"
printf "$BLUE_COLOR docx file to pdf file! $COLOR_OFF \n"
