#!/bin/bash



function checkForGreatness() {
  #
  # Function to determine if X is greater, equal, or less than Y
  #
  # Example:
  #   checkForGreatness <xValue> <yValue>
  #
  # input params
  # @1 : used for x value input
  # @2 : used for y value input
  #
  x=$1
  y=$2
  
  echo "$FUNCNAME"
  echo "-> x: $x"
  echo "-> y: $y"

  # which is greater
  status=""
  test $x -gt $y && status="greater"
  test $x -lt $y && status="less"
  test $x -eq $y && status="equal"

  case $status in
      equal  ) relationship="equal to";;
      greater) relationship="greater than";;
      less   ) relationship="less than";;
      *      ) relationship="unknown";;
  esac
  
  echo "$x $relationship $y "
}

checkForGreatness "5" "2"
checkForGreatness "3" "6"
checkForGreatness "4" "4"



