#!bin/bash/
Number1=$1
Number2=$2

sum=$(($Number1 + $Number2))

echo "Total :: $sum"
echo "how many args are passed :: $#"
echo "All args are passed :: $@"
