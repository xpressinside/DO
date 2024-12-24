#!/bin/bash

gather_info() {
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
}
