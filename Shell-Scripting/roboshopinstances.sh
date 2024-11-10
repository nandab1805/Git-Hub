#!/bin/bash

AMI=ami-0b4f379183e5706b9
SG_ID=sg-03e57915a15c7d452
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "web")

for i in "${INSTANCES[@]}"
do
    echo "instance is: $i"
    if [ $i == "mongodb" ] || [ $i == "mysql" ] || [ $i == "shipping" ]
    then
        INSTANCES_type="t3.small"
    else
        INSTANCES_type="t2.micro"
    fi
    aws ec2 run-instances --image-id ami-0b4f379183e5706b9 --instance-type $INSTANCES_type  --security-group-ids sg-03e57915a15c7d452 --tag-specifications "ResourceType=instance,Tags=[{key=Name,Value=$i}]" 
    # --query 'Instances[0].PrivateIpAddress' --output text
done