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

useradd roboshop
validate $? "Creating roboshop User" &>> $Logs

mkdir /app
validate $? "Creating App Directory" &>> $Logs

curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip
validate $? "Downloading the application" &>> $Logs

cd /app 

unzip /tmp/catalogue.zip
validate $? "Un zipping the file" &>> $Logs

npm install 
validate $? "Insatlling the dependencies" &>> $Logs
#use absolute because catlogue.service exists there 
cp /home/centos/Roboshop-Documentation/catalogue.service /etc/systemd/system/catalogue.service
validate $? "Copy service file" &>> $Logs

systemctl daemon-reload
validate $? "Catalogue Deamon reload" &>> $Logs
systemctl enable catalogue
validate $? "Enabling catalogue" &>> $Logs
systemctl start catalogue
validate $? "Starting catalogue" &>> $Logs

cp /home/centos/Roboshop-Documentation/mongo.repo /etc/yum.repos.d/mongo.repo
validate $? "Copying Mongorepo" &>> $Logs

dnf install mongodb-org-shell -y
validate $? "Install Mongodb Client" &>> $Logs

mongo --host mongodb.nanda.cfd </app/schema/catalogue.js
validate $? "Loading Catalogue data into Mongodb" &>> $Logs
