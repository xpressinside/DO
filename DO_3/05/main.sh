#!/bin/bash

source ./gather_info.sh
source ./output_info.sh

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 dir path"
    exit 1
fi

DIR="$1"

if [ ! -d "$DIR" ]; then
    echo "Error: $DIR not directory"
    exit 1
fi

gather_info

output_info
