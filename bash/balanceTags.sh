#!/bin/bash

##################################################################
# CHALLENGE
##################################################################
# write a function to test for balanced tags (parenthesis, curlies, square brackets)
# - input string is one of six types (see 'valid' line below)
# - return true if input is balanced pair/valid input (otherwise false)
# 
# SAMPLES of possible valid (balanced) and invalid (unbalanced) input strings
# - note the samples are each a line of space seperated strings
#
# () [] {} (()) (){} ({{}}[]()) ((()))    # <= valid   (balanced)
# ) ( )( ()) (() (] ([)]                  # <= invalid (unbalanced)

####################################################
# CONFIG
####################################################

DEBUG="false"
bigLine="-------------------------------------------"

####################################################
# FUNCTIONS
####################################################

function banner(){
	echo "$bigLine"
	echo "$1"
	echo "$bigLine"
}

function debugMsg(){
	if [ $DEBUG == "true" ];then
		echo "[DEBUG] $1" 
	fi
}

function charInfo(){
	debugMsg "$FUNCNAME: start function"
	case "$1" in
		\( ) cName="P" cType="open"  cChar=")"    ;;
		\) ) cName="P" cType="close" cChar="null" ;;
		\{ ) cName="C" cType="open"  cChar="}"    ;;
		\} ) cName="C" cType="close" cChar="null" ;;
		\[ ) cName="S" cType="open"  cChar="]"    ;;
		\] ) cName="S" cType="close" cChar="null" ;;
	esac
	debugMsg "$FUNCNAME: end function"
}

function verifyBracket(){
	# verifyBracket "<currentChar> <topOpenBracket>"
	debugMsg "$FUNCNAME: start function"
	currentChar=$1
	topOpenBracket=$2
	debugMsg "$FUNCNAME -> currentChar   : $currentChar"
	debugMsg "$FUNCNAME -> topOpenBracket: $topOpenBracket"
	
	case "$currentChar" in
		\) ) oChar="(" ;;
		\} ) oChar="{" ;;
		\] ) oChar="[" ;;
		*  ) oChar="null" ;;
	esac
	
	debugMsg "$FUNCNAME: comparing :: currentChar:'$currentChar'  | topOpen:'$topOpenBracket' | oChar:'$oChar' "
	if [ "$oChar" == "$topOpenBracket" ];then
		verifyStatus=0
	else
		verifyStatus=1
	fi
	debugMsg "$FUNCNAME: verifyStatus: $verifyStatus"
	return $verifyStatus
}

function checkString(){
	
	test $DEBUG == "true" && banner "Processing: $1"
	cName=null
	cType=null
	brackets=()     # define array to track brackets
	inString=$1
	inArr=( $(echo $1 | grep -o .) )
	returnStatus=0 # set as zero until error condition is caught
	
	for c in ${inArr[*]};do 
		debugMsg "*** $c ***********************"
		debugMsg "Input Char  : $c"
		debugMsg "Brackets(*) : ${brackets[*]}"
		debugMsg "Brackets(#) : ${#brackets[*]}"
		debugMsg "Brackets(0) : ${brackets[0]}"
		debugMsg "Brackets(1) : ${brackets[1]}"
		debugMsg "Brackets(2) : ${brackets[2]}"
		debugMsg "Brackets(3) : ${brackets[3]}"
		debugMsg "returnStatus: $returnStatus"
		
		# call charInfo func to define cName, cType, cChar values
		charInfo "$c"
		
		debugMsg "cType       : $cType"
		
		# add $c to top of brackets array if $cType matches for open
		if [ $cType == "open" ];then
			# add $c to top of brackets array
			debugMsg "enter condition: open"
			brackets=($c ${brackets[*]})
		elif [ $cType == "close" ];then
			# if cType is closing, make sure $c corresponds with top element of $brackets array
			# check if length of brackets array is zero
			debugMsg "enter condition: close (cType is not 'open')"
			
			if [ ${#brackets[*]} -ne 0 ];then
				debugMsg "-> brackets length ${#brackets[*]} is not zero, moving fwd"
				# closing detected...
				# compare to top of brackets (does $c make sense with top element of $brackets array?)
				debugMsg "-> Brackets(0) : ${brackets[0]}"
				debugMsg "-> Curr Char   : $c"
				debugMsg "-> Curr Name   : $cName"
				debugMsg "-> Curr Type   : $cType"
				
				# call verifyBracket() to determine if closure corresponds to last opened
				verifyBracket "$c" "${brackets[0]}" && closureStatus="pass" || closureStatus="fail"
				
				debugMsg "-> closureStatus: $closureStatus"
				
				# if closure corresponds to last opened
				# - remove top element from array
				# - if it is not corresponding, return non-zero so we can bail out
				if [ $closureStatus == "pass" ];then
					# remove the first element of the array?
					unset -v 'brackets[0]'   # <= this should remove the first element of brackets
					brackets=( ${brackets[*]} )
				else
					debugMsg "UPDATING returnStatus=1"
					returnStatus=1
				fi
			else
				debugMsg "brackets length is zero, problem time"
				debugMsg "UPDATING returnStatus=1"
				returnStatus=1
			fi
		else
			debugMsg "enter condition: else (unknown cType)"
		fi		
	done
	
	# check that the array is empty 
	# - expected that it should be cleared out at this point
	# - if not clear, we probably have more open elements than we had closures
	if [ ${#brackets[*]} -ge 1 ];then
		debugMsg "brackets: not empty ->  ${#brackets[*]}"
		debugMsg "UPDATING $returnStatus=1"
		returnStatus=1
	fi
	debugMsg "Return Status : $returnStatus"
	debugMsg "$returnStatus : $inString"
	return $returnStatus
}

function test_checkString(){
	# call testThis function with params
	# 	@param1 <assertion>
	# 	@param2 <string>
	#
	assert="$1"
	iString="$2"
	checkString "$iString" &&  STATUS="PASS" || STATUS="FAIL"
	
	if [ $STATUS == $assert ];then
		assertionPass="( valid )"
	else
		assertionPass="(invalid)"
	fi
	echo "$assertionPass :: [$STATUS] assert: '$assert' - input string: '$iString'"
}

####################################################
# RUN
####################################################


# TESTS	
test_checkString "PASS" "({}[])"
test_checkString "PASS" "(())"
test_checkString "PASS" "({{}}[]())"
test_checkString "PASS" "((()))"
test_checkString "FAIL" "([)]"
test_checkString "PASS" "[]"
test_checkString "FAIL" "(}[])"
test_checkString "PASS" "()"
test_checkString "PASS" "[]"
test_checkString "PASS" "{}"
test_checkString "PASS" "(){}"
test_checkString "FAIL" ")"
test_checkString "FAIL" "("
test_checkString "FAIL" ")("
test_checkString "FAIL" "())"
test_checkString "FAIL" "(()"
test_checkString "FAIL" "(]"




