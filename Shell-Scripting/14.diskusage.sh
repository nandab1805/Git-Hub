#!/bin/bash

data_usage=$(df -hT | grep -vE 'tmp|file')
disk_threshold=1
message=""

while IFS= read -r line
do
  usage=$(echo "$line" | awk '{print $6}' | cut -d % -f1)
  partition=$(echo "$line" | awk '{print $1}')
  if [ "$usage" -ge "$disk_threshold" ];
  then
    message+="High Disk usage on $partition: $usage%"
  fi
done <<< "$data_usage"

echo "Message: $message"