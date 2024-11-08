#!/bin/bash

AMI=ami-0b4f379183e5706b9
SG_ID=sg-03e57915a15c7d452
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "web")

for i "${INSTANCES[@]}"
do
    if [ $i =="mongodb" ] || [ $i == "mysql" ] || [ $i == "shipping" ]
    then
        INSTANCES_type="t3.small"
    else
        INSTANCES_type="t2.micro"
    fi
    aws ec2 run-instances --image-id ami-0b4f379183e5706b9 --instance-type $INSTANCES_type  --security-group-ids sg-03e57915a15c7d452
done