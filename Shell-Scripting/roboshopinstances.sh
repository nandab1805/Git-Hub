#!/bin/bash

AMI=ami-0b4f379183e5706b9
SG_ID=sg-03e57915a15c7d452
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "web")

for i in "${INSTANCES[@]}"
do
    
    if [ $i == "mongodb" ] || [ $i == "mysql" ] || [ $i == "shipping" ]
    then
        INSTANCES_type="t3.small"
    else
        INSTANCES_type="t2.micro"
    fi
    
    IP_ADDRESS=$(aws ec2 run-instances --image-id $AMI --instance-type $INSTANCE_TYPE --security-group-ids sg-087e7afb3a936fce7 --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" --query 'Instances[0].PrivateIpAddress' --output text)
    echo "$i: $IP_ADDRESS"
    
    # echo "$i: $IP_ADDRESS"
done