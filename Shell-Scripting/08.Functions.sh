#!/bin/bash
Id=$(id -u)
validate(){
    if [ $1 -ne 0 ]
    then
        echo "Error:: $2 ... failed"
        exit 1
    else
        echo "$2 ...Success"
    fi
}
if [ $Id -ne 0 ]
then
    echo "Error::Please run this script with root access"
    exit 1 
else
    echo "You are Root User"
fi

yum install mysql -y
validate $? "Installed mysql"
yum install git -y
validate $? "Installed git"