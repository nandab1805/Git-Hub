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

dnf module disable mysql -y &>> $Logs
validate $? "Disabling current mysql version"

cp /home/centos/Git-Hub/Roboshop-Documentation/mysql.repo /etc/yum.repos.d/mysql.repo &>> $Logs
validate $? "copied Mysql repo"

dnf install mysql-community-server -y &>> $Logs
validate $? "Installing MYSQL server"

systemctl enable mysqld &>> $Logs
validate $? "Enabling mysql server"

systemctl start mysqld &>> $Logs
validate $? "Starting mysql server"

mysql_secure_installation --set-root-pass RoboShop@1 &>> $Logs
validate $? "Setting mysql root password"

