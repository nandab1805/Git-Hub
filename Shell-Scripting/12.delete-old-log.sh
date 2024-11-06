#!/bin/bash
source_dir=/tmp/shell.script-logs

if [! -d $source_dir] #! Denotes oppoiste
then 
    echo -e "$r source directory: $source_dir does not exists. $n"
fi

files_to_delete=$(find . -type f -mtime +14 -name "*.log")

while ifs= read -r line
do
    echo "Deleting file: $line"
done <<< $files_to_delete
