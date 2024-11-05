#!/bin/bash
Id=$(id -u)
timestamp=$(date +%F-%H-%M-%S)
Logs="/tmp/$0-$timestamp.log"
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

dnf install python36 gcc python3-devel -y &>> $Logs
validate $? "Installing Python"

id roboshop
if [ $? -ne 0 ]
then
    useradd roboshop 
    validate $? "Creating roboshop User" 
else
    echo -e "Roboshop already exists $Y SKIPPING $N"
fi

mkdir -p /app &>> $Logs
validate $? "Creating app directory"

curl -L -o /tmp/payment.zip https://roboshop-builds.s3.amazonaws.com/payment.zip &>> $Logs
validate $? "Downloading Payment"

cd /app &>> $Logs

unzip -o /tmp/payment.zip &>> $Logs
validate $? "Unzip Payment"

cd /app &>> $Logs

pip3.6 install -r requirements.txt &>> $Logs
validate $? "Installing Dependencies"

cp /home/centos/Git-Hub/Roboshop-Documentation/payment.service  /etc/systemd/system/payment.service &>> $Logs
validate $? "Copying payment services"

systemctl daemon-reload &>> $Logs
validate $? "Daemon Reload"

systemctl enable payment &>> $Logs
validate $?  "Enabling Payment"

systemctl start payment &>> $Logs
validate $?  "Starting Payment"