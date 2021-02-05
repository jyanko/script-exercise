#!/bin/bash


determineTriagleType(){
  
  #
  # Function to determine triangle type, giveng lenght of the three sides
  #
  # Example:
  #   determineTriagleType <side1> <side2> <side3>
  #
  # input params
  # @1 : used for a value input
  # @2 : used for b value input
  # @3 : used for c value input
  #
  #
  # Output:
  # - EQUILATERAL if all three sides are equal.
  # - ISOSCELES   if two sides are equal.
  # - SCALENE     if no sides are equal

  x=$1
  y=$2
  z=$3

  echo "$FUNCNAME"
  echo "-> x: $x"
  echo "-> y: $y"
  echo "-> z: $z"
  
  a=( $x $y $z )
  u="$(for i in ${a[@]};do echo $i ; done | sort -u | wc -l | tr -d ' ')"
  echo "==> ${a[@]}"
  echo "==> $u"
  if [ $u -eq 1 ];then
  	echo EQUILATERAL
  elif [ $u -eq 2 ];then
  	echo ISOSCELES
  else 
  	echo SCALENE
  fi

  case $u in 
  	1 ) TRIANGLE_TYPE="EQUILATERAL" ;;
  	2 ) TRIANGLE_TYPE="ISOSCELES" ;;
  	3 ) TRIANGLE_TYPE="SCALENE" ;; 
  esac
  
  echo "Type: $TRIANGLE_TYPE"
}

determineTriagleType 2 2 2
determineTriagleType 2 2 6
determineTriagleType 2 4 7









