#!/bin/bash

name=""
wishes=""

usage() {
    echo "Usage: $(basename $0) -n <name> -w <wishes>"
    echo "Options:"
    echo " -n, specify the name (mandatory)"
    echo " -w, specify the wishes, e.g., 'Good Morning'"
    echo " -h, display help and exit"
}

while getopts ":n:w:h" opt; do
    case $opt in
        n) name="$OPTARG";;
        w) wishes="$OPTARG";;
        h) usage; exit;;
        \?) echo "Invalid option: -$OPTARG" >&2; usage; exit 1;;
        :) echo "Option -$OPTARG requires an argument." >&2; usage; exit 1;;
    esac
done

# Debugging line to check the values of $name and $wishes
echo "Debug: name='$name', wishes='$wishes'"

if [ -z "$name" ] || [ -z "$wishes" ]; then
    echo "Error: Both -n and -w are mandatory options."
    usage
    exit 1
fi

echo "Hello $name. $wishes. I have been learning Shell Script."
