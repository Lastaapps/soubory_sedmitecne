#!/usr/bin/env bash

set -e

DATE=$(date "+%Y-%m-%d-%H-%M")
DIR="/mnt/data/Backup/tmp_"
FILENAME="${DIR}${DATE}.tar.xz"
PAR2_REDUNDANCY=5 # in percents
XZ_COMPRESSION_LEVEL=9 # 1 - worst, 6 - default, 9 - best

# If nice with high value is used,
# one of the cores is not used at all by the backup process
# Relative offset works fine
# NICE="nice -n 10 ionice -c 3"
NICE="nice -n+1"
IONICE="ionice -c 3"


TAR_EXCLUDE_OPTS=()
ALL_EXCLUDES=( \
  '**/.bloop/*' \
  '**/.build/*' \
  '**/_build/*' \
  '**/build/*' \
  '**/BuildTools/*' \
  '**/*.db*' \
  '**/generator/testdata/*' \
  '**/.git/*' \
  '**/.gradle/*' \
  '**/.kotlin/*' \
  '**/*log*' \
  '**/logs/*' \
  '**/mcaselector/*' \
  '**/node_modules/*' \
  '**/PID/*' \
  '**/pid_data/*' \
  '**/petalinux/*' \
  '**/__pycache__/*' \
  '**/server_backup/*' \
  '**/Servers/*/bundler/*' \
  '**/Servers/*/libraries/*' \
  '**/Servers/*/versions/*' \
  '**/.stack-work/*' \
  '**/.stfolder/*' \
  '**/.sync/*' \
  '**/target/*' \
  '**/.thumbnails/*' \
  '**/uni*' \
  '**/.venv*' \
  '**/venv*' \
)

# Combine all patterns and add the --exclude= prefix for tar
for pattern in "${ALL_EXCLUDES[@]}"; do
  TAR_EXCLUDE_OPTS+=( "--exclude=${pattern}" )
done
# --- End tar exclude options ---


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
  # "BFME_I" \
  # "BFME_II" \
  # "BFME_ROTWK" \
  # "jar_files" \
)

printf "Backing up these folders:\n"
stat -c "%A %h %U %G %s %y %N" "${TOBACKUP[@]}" || ls -ald "${TOBACKUP[@]}"
echo

read -rp "Press the Enter key to start"

echo "Starting backup process..."
set -x
time ${IONICE} tar -cv "${TAR_EXCLUDE_OPTS[@]}" -f - "${TOBACKUP[@]}" | ${NICE} xz -z -${XZ_COMPRESSION_LEVEL} -T0 > "$FILENAME"
BACKUP_EXIT_CODE=$?
set +x

echo
if [ $BACKUP_EXIT_CODE -eq 0 ]; then
    echo "Backup completed successfully!"
    ls -lh "$FILENAME"
else
    echo "Backup failed with exit code: $BACKUP_EXIT_CODE"
    exit
fi

echo
echo "Creating PAR2 recovery files with ${PAR2_REDUNDANCY}% redundancy..."
time ${NICE} ${IONICE} par2 create -q -r"${PAR2_REDUNDANCY}" -- "$FILENAME.par2" "$FILENAME"
PAR2_EXIT_CODE=$?

if [ $PAR2_EXIT_CODE -eq 0 ]; then
		echo "PAR2 recovery files created successfully."
else
		echo "Error: Failed creating PAR2 recovery files. Exit code: $PAR2_EXIT_CODE"
fi

echo
echo "Scheduled defragmentation"
btrfs filesystem defragment -r -v -czstd /mnt/data/

read -rp "Press the Enter key to exit"

exit $BACKUP_EXIT_CODE
