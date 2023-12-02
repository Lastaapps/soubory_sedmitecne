#!/bin/bash

set -e

DATE=$(date "+%Y-%m-%d-%H-%M")
DIR="/mnt/d/Zaloha/"
FILENAME="${DIR}${DATE}.rar"
COMMAND="rar"
ARGS="a -m5 -hp -rr3p -r -y -md1g -ep1 -mt8 -ma5 -ol"


EXCLUDE_MINECRAFT="-x*/mcaselector/* -x*/Servers/*/bundler/* -x*/Servers/*/libraries/* -x*/Servers/*/versions/* -x*/server_backup/* -x*/BuildTools/*"
EXCLUDE_PROGRAMMING="-x*/target/* -x*/build/* -x*/.gradle/* -x*/PID/* -x*/pid_data/* -x*/generator/testdata/* -x*/.venv/* -x*/node_modules/* -x*/__pycache__/*"
EXCLUDE_GENERAL="-x*/.thumbnails/*"
EXCLUDE="$EXCLUDE_MINECRAFT $EXCLUDE_PROGRAMMING $EXCLUDE_GENERAL"

TOBACKUP=(\
"/mnt/d/Dokumenty/Dokumenty" \
"/mnt/d/Android files sync" \
"/mnt/space/projects" \
"/mnt/f/Arduino" \
"/mnt/f/AndroidStudioProjects" \
"/mnt/f/NetBeansProjects" \
# "/mnt/f/GitHub" \
# "/mnt/f/Node.js" \
"/mnt/f/Archive" \
"/mnt/f/eagle" \
"/mnt/space/jar_files" \
"/mnt/d/Dokumenty/Minecraft" \
"/mnt/space/minecraft/saves" \
"/mnt/space/BFME_I" \
"/mnt/space/BFME_II" \
"/mnt/space/BFME_ROTWK" \
"/home/petr/dotfiles" \
)

printf "Backing up these folders:\n"
ls -ald "${TOBACKUP[@]}"
echo

$COMMAND $ARGS $EXCLUDE $FILENAME "${TOBACKUP[@]}"

echo
echo Done! Result code: $?
read -p "Press the Enter key to exit"
exit

