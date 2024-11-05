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

curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>> $Logs
validate $? "Downloading erlang Script"

curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>> $Logs
validate $? "Downloading rabbitmq Script"

dnf install rabbitmq-server -y  &>> $Logs
validate $? "Installing Rabbitmq server"

systemctl enable rabbitmq-server &>> $Logs
validate $? "Enabling Rabbitmq server"

systemctl start rabbitmq-server &>> $Logs
validate $? "Starting Rabbitmq server"

rabbitmqctl add_user roboshop roboshop123 &>> $Logs
validate $? "Creating user"

rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>> $Logs
validate $? "Setting permission"