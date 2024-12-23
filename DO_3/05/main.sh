#!/bin/bash

#set -x

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 dir path"
    exit 1
fi

DIR="$1"

if [ ! -d "$DIR" ]; then
    echo "Error: $DIR not directory"
    exit 1
fi

START_TIME=$(date +%s)

TOTAL_FOLDERS=$(find "$DIR" -type d | wc -l)

TOP5_FOLDERS=$(du -h --max-depth=1 "$DIR" | sort -hr | head -n 5)

TOTAL_FILES=$(find "$DIR" -type f | wc -l)

CONFIG_FILES=$(find "$DIR" -type f -name "*.conf" | wc -l)

TEXT_FILES=$(find "$DIR" -type f -name "*.txt" | wc -l)

EXE_FILES=$(find "$DIR" -type f -executable | wc -l)

LOG_FILES=$(find "$DIR" -type f -name "*.log" | wc -l)

ARCHIVE_FILES=$(find "$DIR" -type f \( -name "*.zip" -o -name "*.tar" -o -name "*.gz" -o -name "*.bz2" \) | wc -l)

SYMLINKS=$(find "$DIR" -type l | wc -l)


TOP10_FILES=$(find "$DIR" -type f -exec du -h {} + | sort -hr | head -n 10)

TOP10_EXEC=$(find "$DIR" -type f -executable -exec du -h {} + | sort -hr | head -n 10)



TOP10_EXEC_HASH=()
if [ -z "$TOP10_EXEC" ]; then
    TOP10_EXEC_HASH+="no executable files"
else
    while IFS= read -r line; do
        FILE_PATH=$(echo "$line" | awk '{print $2}')
        FILE_SIZE=$(echo "$line" | awk '{print $1}')
        FILE_HASH=$(md5sum "$FILE_PATH" | awk '{print $1}')
        TOP10_EXEC_HASH+=("$FILE_PATH, $FILE_SIZE, $FILE_HASH")
    done <<< "$TOP10_EXEC"
fi

END_TIME=$(date +%s)
EXEC_TIME=$((END_TIME - START_TIME))

echo "Total number of folders (including all nested ones) = $TOTAL_FOLDERS"
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
echo "$TOP5_FOLDERS"
echo "Total number of files = $TOTAL_FILES"
echo "Number of:"
echo "Configuration files (with the .conf extension) = $CONFIG_FILES"
echo "Text files = $TEXT_FILES"
echo "Executable files = $EXE_FILES"
echo "Log files (with the extension .log) = $LOG_FILES"
echo "Archive files = $ARCHIVE_FILES"
echo "Symbolic links = $SYMLINKS"
echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
echo "$TOP10_FILES"
echo "TOP 10 files executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
for i in "${TOP10_EXEC_HASH[@]}"; do
    echo "$i"
done
echo "Script execution time (in seconds) = $EXEC_TIME"

#nano 1.txt
