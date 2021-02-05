#!/bin/bash

function allTheMath(){
  #
  # Function to find the sum, difference, product, and quotient of two given integers (x and y)
  #
  # Example:
  #   allTheMath <xValue> <yValue>
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
  mS=$(( $x + $y ))
  mD=$(( $x - $y ))
  mP=$(( $x * $y ))
  mQ=$(( $x / $y ))
  mM=$(( $x % $y ))
  printf "Sum : $mS\nDiff: $mD\nProd: $mP\nQuot: $mQ\nModu: $mM\n"
}

allTheMath "4" "2"
allTheMath "6" "3"
allTheMath "9" "4"

echo
echo

function doMathWithBC(){
  #
  # Function accepts a problem (as string) to be passed to bc and get result to 7 decimal places
  #
  # Example:
  #   doMathWithBC <problem>
  #   doMathWithBC "5+50*3/20 + (19*2)/7"
  #
  # input params
  # @1 : the input problem as a string
  #
  problem="$1"

  echo "$FUNCNAME"
  echo "-> problem: $problem"

  r=$(echo "scale=7;$problem" | bc -l )

  printf "=> result  : $r \n"
  printf "=> result:3: %.3f\n" $r 
  printf "=> result:5: %.5f\n" $r 
}

doMathWithBC "5+50*3/20 + (19*2)/7"
doMathWithBC "5+50*3/20 + (19*2)/6"
doMathWithBC "5+51*3/21 + (19*2)/9"










