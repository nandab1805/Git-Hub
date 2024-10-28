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
#git mysql postfix net-tools
#package=git for first time
for package in $@
do
    yum list installed $package &>> $Logs  #check installed or not 
    if [$? -ne 0] #if not installed
    then
        yum install $package -y &>> $Logs #install the package
        validate $? "Installation of $package" #validate
    else
        echo -e "$package is already installed... $Y skipping $N"
    fi
done



# yum install mysql -y &>> $Logs
# validate $? "Installing mysql"
# yum install git -y &>> $Logs
# validate $? "Installing git"
# echo "All arguments passed: $@"