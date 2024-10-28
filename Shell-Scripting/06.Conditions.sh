#!/bin/bash
Number=$1

if [ $Number -gt 100 ]
then
    echo "Give number $Number is greater than 100"
else
    echo "Give number $Number is not greater than 100"
fi
