#!/bin/bash

person1=Ram
person2=sam

echo "$person1: Hello $person2, Good Morning"
echo "$person2: Hi $person1,Very Good Morning"
echo "$person1: How are you $person2?"
echo "$person2: I am good $person1, How are you"


date=$(date)
echo "Script started excuting: $date"

date=$(date)
echo "Date and time is: $date"

# Arguments

person1=$1
person2=$2

echo "$person1: Hello $person2, Good Morning"
echo "$person2: Hi $person1,Very Good Morning"
echo "$person1: How are you $person2?"
echo "$person2: I am good $person1, How are you"
