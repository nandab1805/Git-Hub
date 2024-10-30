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
cp mongo.repo /etc/yum.repos.d/mongo.repo &>> $Logs
validate $? "Copied MongoDB Repo"

dnf install mongodb-org -y &>> $Logs
validate $? "Installing MongoDB"

systemctl enable mongod &>> $Logs
validate $? "Enable MongoDB"

systemctl start mongod &>> $Logs
validate $? "Starting MongoDB"  #/c/Users/Admin/aws-devops/Git-Hub/Roboshop-Documentation

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongodb.conf &>> $Logs
validate $? "Validate remote access to  MongoDB"

systemctl restart mongod &>> $Logs
validate $? "Restarting MongoDB"
