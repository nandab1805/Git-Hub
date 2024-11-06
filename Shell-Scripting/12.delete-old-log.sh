#!/bin/bash
source_dir="/tmp/shellscript-logs"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ ! -d $source_dir ] #! Denotes oppoiste
then 
    echo -e "$r source directory: $source_dir does not exists. $n"
fi

files_to_delete=$(find $source_dir -type f -mtime +14 -name "*.log")

while ifs= read -r line #Internal filed seprater- ifs
do
    echo "Deleting file: $line"
    rm -rf $line
done <<< $files_to_delete #Less than always denotes input
