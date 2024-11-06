#!/bin/bash/

data_usage=$(df -hT | grep -vE 'tmp|file')
disk_threshold=1
message=""

while ifs= read line
do
    usage=$(echo $line | awk '{print $6F}' | cut -d % -f1)
    parition=$(echo $line | awk '{print $6F}')
    if [ $usage -ge $disk_threshold ]
    then
        message+="High Disk usage on $parition: $usage"
    fi
done <<<$disk_usage

echo "Message: $message"