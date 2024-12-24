#!/bin/bash

output_info() {
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
}