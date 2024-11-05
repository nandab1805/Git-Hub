#!/bin/bash
Id=$(id -u)
timestamp=$(date +%F-%H-%M-%S)
Logs="/tmp/$0-$timestamp.log"
exec &>$Logs
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
echo "Script started excuting $timestamp" &>> $Logs
validate(){
    if [ $1 -ne 0 ]
then
    echo -e "Error::$2 ... $R Failed $N"
    exit 1
else
    echo -e "$2 ..$G Success $N"
fi

}
if [ $Id -ne 0 ]
then 
    echo -e "$R Error :: please run this script in root access $N"
    exit 1
else
    echo -e "You are root user"
fi

dnf install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y 

dnf module enable redis:remi-6.2 -y
validate $? "Enabling Redis"

dnf install redis -y 
validate $? "Installing Redis"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis.conf

systemctl enable redis 
validate $? "Enabling Redis"
systemctl start redis 
validate $? "Starting Redis"