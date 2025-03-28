#!/usr/bin/env bash

set -e

DATE=$(date "+%Y-%m-%d-%H-%M")
DIR="/mnt/data/Backup/"
FILENAME="${DIR}${DATE}.rar"
COMMAND="rar"
ARGS="a -m5 -hp -rr3p -r -y -md1g -ep1 -mt8 -ma5 -ol"


EXCLUDE_MINECRAFT="-x*/mcaselector/* -x*/Servers/*/bundler/* -x*/Servers/*/libraries/* -x*/Servers/*/versions/* -x*/server_backup/* -x*/BuildTools/*"
EXCLUDE_PROGRAMMING="-x*/target/* -x*/build/* -x*/.gradle/* -x*/PID/* -x*/pid_data/* -x*/generator/testdata/* -x*/.venv* -x*/venv* -x*/node_modules/* -x*/__pycache__/*"
EXCLUDE_GENERAL="-x*/.thumbnails/*"
EXCLUDE="$EXCLUDE_MINECRAFT $EXCLUDE_PROGRAMMING $EXCLUDE_GENERAL"

TOBACKUP=(\
"/mnt/data/Documents" \
"/mnt/data/Phone" \
"/mnt/data/Pictures" \
"/mnt/data/Minecraft" \
"/mnt/data/Videos" \
"/mnt/data/Projects/AndroidStudioProjects" \
"/mnt/data/Projects/NetBeansProjects" \
"/mnt/data/Projects/Archive" \
"/mnt/data/Projects/eagle" \
"/home/petr/dotfiles" \
"/home/petr/Projects" \
# "/mnt/space/minecraft/saves" \
# "/mnt/space/BFME_I" \
# "/mnt/space/BFME_II" \
# "/mnt/space/BFME_ROTWK" \
# "/mnt/space/jar_files" \
)

printf "Backing up these folders:\n"
ls -ald "${TOBACKUP[@]}"
echo

$COMMAND $ARGS $EXCLUDE $FILENAME "${TOBACKUP[@]}"

echo
echo Done! Result code: $?

echo Scheduled defragmentation
btrfs filesystem defragment -r -v -czstd /mnt/data/

read -p "Press the Enter key to exit"
exit

