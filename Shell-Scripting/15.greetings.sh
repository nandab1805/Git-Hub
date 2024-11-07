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
        h|*) usage; exit;;
    esac
done