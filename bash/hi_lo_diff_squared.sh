#!/bin/bash

# CHALLENGE:
#
# create a function to determine the highest and lowest number in an array
# return the difference squared (max-min)^2
#

echo "==== START OF MATH EXERCISE ===="

function doMath(){
    
    a=( $1 )
    min="${a[0]}"
    max="${a[0]}"

    # check num each pass if it is higher or lower than current min/max
    for num in ${a[*]};do
        test $num -gt $max && max=$num  # update max, if higher than prev. seen numbers
        test $num -lt $min && min=$num  # update min, if lower  than prev. seen numbers
    done
    echo $(( ($max - $min) ** 2 ))      # print the result of (max-min)^2
    
}

gA=( 2 5 8 4 3 9 )
gB=( 4 5 1 2 3 6 )

echo -n "Process Array: ${gA[*]}  => "
doMath "${gA[*]}"

echo -n "Process Array: ${gB[*]}  => "
doMath "${gB[*]}"

echo -n "Process Array: 2 5 8 4 3 7  => "
doMath "2 5 8 4 3 7"

echo "==== END OF MATH EXERCISE ===="
echo
echo



