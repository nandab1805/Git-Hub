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
dnf module disable nodejs -y &>> $Logs
validate $? "Disabling Current nodejs"

dnf module enable nodejs:18 -y &>> $Logs
validate $? "Enabling NodeJS"

dnf install nodejs -y &>> $Logs
validate $? "Installing NodeJS"

id roboshop
if [ $1 -ne 0 ]
then
    useradd roboshop 
    validate $? "Creating roboshop User" 
else
    echo -e "Roboshop already exists $Y SKIPPING $N"
fi

mkdir -p /app &>> $Logs
validate $? "Creating App Directory" 

curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip  &>> $Logs
validate $? "Downloading the application"
cd /app &>> $Logs

unzip -o /tmp/catalogue.zip &>> $Logs
validate $? "Un zipping the file" 

npm install &>> $Logs
validate $? "Insatlling the dependencies" 
#use absolute because catlogue.service exists there 
cp /home/centos/Git-Hub/Roboshop-Documentation/catalogue.service /etc/systemd/system/catalogue.service  &>> $Logs
validate $? "Copy service file"

systemctl daemon-reload &>> $Logs
validate $? "Catalogue Deamon reload" 
systemctl enable catalogue &>> $Logs
validate $? "Enabling catalogue" 
systemctl start catalogue &>> $Logs
validate $? "Starting catalogue"

cp /home/centos/Git-Hub/Roboshop-Documentation/mongo.repo /etc/yum.repos.d/mongo.repo &>> $Logs
validate $? "Copying Mongorepo"

dnf install mongodb-org-shell -y &>> $Logs
validate $? "Install Mongodb Client" 

mongo --host mongodb.nanda.cfd </app/schema/catalogue.js &>> $Logs
validate $? "Loading Catalogue data into Mongodb"
