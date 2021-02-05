#!/bin/bash

#
# FRACTAL TREES
#
# https://www.hackerrank.com/challenges/fractal-trees-all/problem
#
# In the beginning, we simply create a Y. 
# There are 63 rows and 100 columns in the grid below. 
# The triangle is composed of underscores and ones as shown below. 
# The vertical segment and the slanting segments are both 16 characters in length.

# Iterations after first...
#     At the top of the left and right branches of the first Y, 
#     add a pair of Y-shapes, which are half the size of the original/previous Y(s).

#
# Input Format
#     A single integer, N.
#
# Constraints
#     N <= 5
#
# Output Format
#     The Nth iteration of the Fractal Tree, as shown above. 
#     It should be a matrix of 63 rows and 100 columns. (i.e. 6300 printable characters) 
#     It should be composed entirely of underscores and ones, in a manner similar to the examples provided. 
#     Do not include any extra leading or trailing spaces.
#


###################################
# FUNCTIONS
###################################

function debugMessage(){
	if [ "$debug" == "true" ];then
		echo "[DEBUG] $1"
	fi
}

function addLegs(){
	#
	# adds legs to current row being processed
	#
	# PARAMS:
	# @1 - required - position
	# @2 - required - current row value 
	#
	legPosition="$1"
	currRow="$2"
	currRow=$(echo $currRow | sed s/./1/$legPosition )
	echo "$currRow"
}

function addArms(){
	armL="$1"
	armR="$2"
	currRow="$3"
	#debugMessage "$FUNCNAME ($1 $2)"
	# debugMessage "=> armL    : $armL"
	# debugMessage "=> armR    : $armR"
	# debugMessage "=> currRow : $currRow"
	currRow=$(echo $currRow | sed s/./1/$armL )
	currRow=$(echo $currRow | sed s/./1/$armR )
	echo "$currRow"
}

function forkFromRoot(){
	#
	# determine two positions based on input integer and step value
	#
	# PARAMS:
	# @1 - required - position value
	# @2 - required - step value to increment/decrement by
	#
	echo $(( $1 + $2 )) $(( $1 - $2 ))
}


###################################
# RUN STARTS HERE
###################################
# input is expected to be <= 5
iterations=$((cat))
debug="false"
testHarness=2  # test value - ignored if $input from STDIN is >=1
maxRows=63     # maximum rows to print
maxCols=100    # max columns
rowCount=0     # var to carry the rowcount (ie: rows drawn so far)
height=16      # initial height of Y segement (leg height or fork height)


# TODO: first  fork new roots = root+16 & root-16
#       - figure out how to get this into use with the addArms logic
#       - can call the forkThis function to find next roots
# forkThis 50 16  # position & stepper
# forkThis 66 8
# forkThis 74 4
# forkThis 78 2
# exit
	


echo "Input from STDIN: ${input[*]}"
if [ "$iterations" -lt "1" ];then
	iterations=$testHarness
fi
echo "Iterations (now): $iterations"

# need to know how many legs
# $maxCols / $legs should determine their positions
midPoint=$(( $maxCols / 2 ))
debugMessage "=> maxRows     : $maxRows"
debugMessage "=> maxCols     : $maxCols"
debugMessage "=> midPoint    : $midPoint"
debugMessage "=> iterations  : $iterations"
debugMessage "=> height      : $height"

# iterations
# 1st. one start point        position  = a (centered at char 51)
# 2nd. two start points       positions = a,b
# 3rd. four start points      positions = a,b,c,d
# 4th. eight start points     positions = a,b,c,d,e,f,g,h
# 5th. sixteen start points   positions = a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p


# define the row template - we will be replacing chars as needed
myRow=$(printf '_%.s' $(seq 1 $maxCols)) 



i=0
cRoots=($midPoint)      # array to hold root positions
cArms=()                # array to hold arm  positions

while [ $i -lt $iterations ];do
	i=$(( $i + 1))
	debugMessage "iterator:$i  height:$height roots:${cRoots[*]}"
	
	#
	# draw rows with legs - use height as the number of rows
	#
	legRows=$height
	while [ $legRows -gt 0 ];do
		debugMessage "iterator:$i  height:$height roots:${cRoots[*]}"
		for root in ${cRoots[*]};do
			debugMessage "legs: iterator:$i  height:$height root :$root / roots:${cRoots[*]}"
			addLegs "$root" "$myRow"
		done
		legRows=$(( $legRows - 1))
	done
	
	#
	# "draw rows with arms"
	#
	tempRoots=()
	myFork="start"
	armRows=$height
	debugMessage "armRows: $armRows"
	
	while [ $armRows -gt 0 ];do
		
		currRow="$myRow"
		for root in ${cRoots[*]};do
			
			debugMessage "167: armRows:$armRows  iterator:$i  height:$height root :$root / roots:${cRoots[*]}"
			
			
			
			
			newRoots=($(forkFromRoot "$root" "$height"))  # pass pos & step
			debugMessage "root    : $root"
			debugMessage "myFork  : $myFork"
			debugMessage "armRows : $armRows"
			debugMessage "newRoots: $newRoots"
			if [ $myFork == "start" ];then
				# toggle $myFork to in-progress
				myFork="inprogress"
				aRight=$(( $root + 1))
				aLeft=$(( $root - 1))
			else
				myFork="inprogress"
				aRight=$(( $aRight + 1))
				aLeft=$(( $aLeft - 1))
			fi
			
			debugMessage "aRight: $aRight"
			debugMessage "aLeft : $aLeft"
			addArms "$aLeft" "$aRight" "$currRow"
			
			if [ "$armRows" == "1" ];then
				#echo "TEMPROOTS CHECK: armRows:$armRows is ZERO"
				tempRoots=( "${tempRoots[*]}" "$aLeft" "$aRight" )
			fi
			#echo "tempRoots: ${tempRoots[*]}"
		done

		armRows=$(( $armRows - 1))
		debugMessage "201: armRows: $armRows"
		
	done
	
	#debugMessage "reducing height from $height to $(( $height / 2))"
	height=$(( $height / 2))
	# TODO: cRoots() needs to be redefined here to include fork positions
	cRoots=(${tempRoots[*]})
	debugMessage "cRoots: ${cRoots[*]}"
done

# echo $(addLegs "51" "$myRow")
# echo $(addArms "50" "52" "$myRow")
# echo $(addArms "49" "53" "$myRow")
# echo $(addArms "48" "54" "$myRow")
# echo $(addArms "47" "55" "$myRow")



# printf '=%.0s' {1..100}
# lim=25
# printf '=%.0s' $(seq 1 $lim)

