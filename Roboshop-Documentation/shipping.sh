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

dnf install maven -y &>> $Logs
validate $? "Installing maven java packaging software"

id roboshop
if [ $? -ne 0 ]
then
    useradd roboshop 
    validate $? "Creating roboshop User" 
else
    echo -e "Roboshop already exists $Y SKIPPING $N"
fi

mkdir -p /app &>> $Logs
validate $? "Creating App Directory" 

curl -L -o /tmp/shipping.zip https://roboshop-builds.s3.amazonaws.com/shipping.zip &>> $Logs
validate $? "Downloading the shipping application"

cd /app &>> $Logs
validate $? "moving to app directory"

unzip -o /tmp/shipping.zip &>> $Logs
validate $? "Unzipping the file" 

cd /app &>> $Logs

mvn clean package &>> $Logs
validate $? "Installing dependencies"

mv target/shipping-1.0.jar shipping.jar &>> $Logs
validate $? "Renaming jar file"

cp /home/centos/Git-Hub/Roboshop-Documentation/shipping.service /etc/systemd/system/shipping.service &>> $Logs
validate $? "Copying shipping service"

systemctl daemon-reload &>> $Logs
validate $? "Daemon reload"

systemctl enable shipping &>> $Logs
validate $? "Enabling Shipping"

systemctl start shipping &>> $Logs
validate $? "Starting Shipping"

dnf install mysql -y &>> $Logs
validate $? "Installing MYSQL Client"

mysql -h mysql.nanda.cfd -uroot -pRoboShop@1 < /app/schema/shipping.sql &>> $Logs
validate $? "Loading Shipping Data"

systemctl restart shipping &>> $Logs
validate $? "Restart Shipping"