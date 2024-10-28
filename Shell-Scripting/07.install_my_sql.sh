#!/bin/bash
 
Id=$(id -u)
if [ $Id -ne 0 ]
then
    echo "Error::Please run this script with root access"
    exit 1 #you can anything other than 0
else
    echo "You are Root User"
fi #fi means reverse of if ,indicating condition end
yum install mysql -y

if [ $? -ne 0 ] #Exit status of previoys command
then
    echo "Error:: Installing Mysql is failed"
    exit 1
else
     echo "Installing Mysql is Success"
fi
yum install git -y
if [$? -ne 0 ]
then
    echo "Error:: Installing git is failed"
    exit 1
else
    echo "Installing git is success"
fi