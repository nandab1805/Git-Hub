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

dnf install golang -y &>> $Logs
validate $? "Installing golanguage"

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

curl -L -o /tmp/dispatch.zip https://roboshop-builds.s3.amazonaws.com/dispatch.zip &>> $Logs
validate $? "Downloading Dispatch"

cd /app &>> $Logs

unzip /tmp/dispatch.zip &>> $Logs
validate $? "Unzip dispatch"

cd /app &>> $Logs
go mod init dispatch
go get 
go build

cp /home/centos/Git-Hub/Roboshop-Documentation/dispatch.service  /etc/systemd/system/dispatch.service &>> $Logs
validate $? "Copying Dispatch Services"

systemctl daemon-reload &>> $Logs
validate $? "Daemon Reloading"

systemctl enable dispatch &>> $Logs
validate $? "Enabling Dispatch"

systemctl start dispatch &>> $Logs
validate $? "starting Dispatch"