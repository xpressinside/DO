#!/bin/bash

if [ "$#" -ne 6 ]; then
	echo "Error Format"
	exit 1
fi


BASE_PATH="$1"
NUM_DIRS="$2"
DIR_LETTERS="$3"
NUM_FILES="$4"
FILE_LETTERS="$5"
FILE_SIZE="$6"



check_free_space() {
	local free_space=$(df "$BASE_PATH" | awk 'NR==2 {print $4}')
	if [ "$free_space" -lt 1048576 ]; then
		echo "Low Space On Disk"
		exit 1
	fi
}

generate_name() {
	local letters="$1"
	local length="$2"
	local name=""
	for ((i=0; i<length; i++)); do
		name+="${letters:RANDOM%${#letters}:1}"
	done
	echo "$name"
}

check_free_space

DATE=$(date +%d%m%y)

for ((i=0; i<NUM_DIRS; i++)); do
	DIR_NAME=$(generate_name "$DIR_LETTERS" 4)_"$DATE"
	DIR_PATH="$BASE_PATH/$DIR_NAME"
	mkdir -p "$DIR_PATH"
	echo "Create dir: $DIR_PATH" >> creation.log
	for ((j=0; j<NUM_FILES; j++)); do
		FILE_NAME=$(generate_name "$FILE_LETTERS" 4)
		FILE_PATH="$DIR_PATH/$FILE_NAME"
		if ! dd if=/dev/zero of="$FILE_PATH" bs=1K count="$FILE_SIZE" status=none; then
			echo "error: $FILE_PATH"
			echo "error2: $FILE_SIZE"
			exit 1
		fi
		echo "File created: $FILE_PATH, size: ${FILE_SIZE}K" >> creation.log
	done
done

echo "END."
