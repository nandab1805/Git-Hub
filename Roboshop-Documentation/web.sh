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
dnf install nginx -y  &>> $Logs
validate $? "Installing nginx"

systemctl enable nginx  &>> $Logs
validate $? "Enabling Nginx"

systemctl start nginx  &>> $Logs
validate $? "Starting Nginx"

rm -rf /usr/share/nginx/html/*  &>> $Logs
validate $? "Removed default Website"

curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip  &>> $Logs
validate $? "Downloaded the web application"

cd /usr/share/nginx/html  &>> $Logs
validate $? "moving nginx html web directory"

unzip -o /tmp/web.zip  &>> $Logs
validate $? "Unzipping Web"

cp /home/centos/Git-Hub/Roboshop-Documentation/roboshop.conf /etc/nginx/default.d/roboshop.conf   &>> $Logs
validate $? "Copied roboshop reverse proxy config"

systemctl restart nginx  &>> $Logs
validate $? "restarted nginx"