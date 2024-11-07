#!/bin/bash

name=""
wishes=""

usage(){
    echo "usage:: $(basename $0) -n <name> -w<wishes>"
    echo "Options"
    echo " -n, specify the name (mandatory)"
    echo " -w, specify the wishes. ex, Good Morning"
    echo " -h, Display Help and exit"

}
while getopts ":n:w:h" opt;
do
    case $opt in
        n) name="$optarg";;
        w) wishes="$optarg";;
        \?) echo "invaild options: -"$optarg"" >&2; usage; exit;;
        :) usage; exit;; 
        h) usage; exit;;
    esac
done

if [ -z "$name" ] || [ -z "$wishes" ]; then
    echo "Error: Both -n and -w are mandatory option."
    usage
    exit 1
fi

echo "Hello $name. $wishes. I have been learning Shell Script."