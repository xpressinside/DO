#!/bin/bash
chmod +x *.sh
dirName=$(dirname $0)
. ${dirName}/test.sh
. ${dirName}/monitoring.sh