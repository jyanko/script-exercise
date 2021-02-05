#!/bin/bash

function yesOrNo(){
  #
  # Function accepts char and checks if char is Yy or Nn
  #
  # If the character is 'Y' or 'y' display "YES".
  # If the character is 'N' or 'n' display "NO".
  # No other character will be provided as input.
  #
  # Example:
  #   yesOrNo <value>
  #   yesOrNo y
  #   yesOrNo N
  #
  # input params
  # @1 : used for input value
  #
  a=($1)
  
  for x in ${a[*]};do 
  echo "==> x is: $x ==="
      case $x in
           n|N ) echo "NO";;
           y|Y ) echo "YES";;
           *   ) echo "NO:UNKNOWN_INPUT";;
      esac
      # alternative simple oneliner not using case statement
      echo $x | egrep -i '^y$' >/dev/null && echo YES || echo NO
  done
}

yesOrNo "yabba"
yesOrNo "y"
yesOrNo "n"
yesOrNo "Y"
yesOrNo "N"
yesOrNo "Z"




