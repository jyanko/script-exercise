#!/bin/bash

# TODO: verify this script works properly...
# 
# if more than half the lines are indented using spaces, change all the tabs used for indentation to spaces. 
# if more lines are indented using tabs, change the spaces used for indentation to tabs. 
# Lines that are not indented or lines that have mixed indentation styles won't count towards the total number of lines that you're considering (i.e. they will not affect the ratio of tabs to spaces). 
# If there are an equal number of lines that have been indented using spaces and tabs, then you'll leave the file as it is and change it manually later.
# Assume that 1 tab "equals" or aligns to 4 spaces

# write a script that goes through the files and 
# 1. outputs the file name
# 2. followed by the contents of the file with its indentation for all lines converted to style that is most prevalent
# 3. If there is an equal number of lines indented using spaces and tabs, add  ? after the filename & skip the content.




DEBUG="true"

function debugMsg {
	if [ $DEBUG = "true" ];then
		echo [DEBUG] $1
	fi
}
	
cd /Users/jyanko/codesignal/root/devops

for MF in `ls -1 *`;do   
	COUNT_TABS=0
	COUNT_SPACES=0
	COUNT_MIXED=0
	
	debugMsg "--------------------------------------"
    debugMsg  "File: $MF" 
	debugMsg "--------------------------------------"
	if [ $DEBUG = "true" ];then
		cat $MF
		
	fi
	debugMsg "---end file--"
	
	TAB_LINES="$(egrep -c '^(\t+)([A-Za-z0-9]*)' $MF )"          # match lines starting with 1 or more tabs count as indented
	SPC_LINES="$(egrep -c '^((\ \ \ \ )+)([A-Za-z0-9]*)' $MF )"  # match lines starting with 4 spaces count as indented
	MIX_LINES="$(egrep -c '^((\t+\ +)|(\ +\t+))' $MF )"          # match lines with mixed spaces/tabs DON'T count as indented
	INDENTED_LINES=$(( $TAB_LINES + $SPC_LINES  ))               # mixed don't count toward indented lines total
	INDENTED_LINES_HALF=$(( $INDENTED_LINES / 2 ))              
	INDENTED_LINES_MODU=$(( $INDENTED_LINES % 2 ))
	
	debugMsg "indented: $INDENTED_LINES"
	debugMsg "indented: half: $INDENTED_LINES_HALF modulo: $INDENTED_LINES_MODU"
	debugMsg "indented: tab : $TAB_LINES "
	debugMsg "indented: spc : $SPC_LINES "
	debugMsg "indented: mix : $MIX_LINES "
	
	# test2 
	# - a : should print (majority tabs)
	# - b : should print ? condition
	# - c : should print (file has only a single space)
	# - d : should print ? condition
	
	if [ $INDENTED_LINES = 0 ];then
		debugMsg "Condition: Zero indented lines - nothing to do..."
		echo  "$MF"
	elif [ $SPC_LINES -gt $INDENTED_LINES_HALF ] && [ $SPC_LINES -gt 0 ];then
		debugMsg "Condition: SPACE More than Half"
		echo  "$MF"
		cat $MF | perl -pe 's/\t/\ \ \ \ /gi;'
		
	elif [ $TAB_LINES -gt $INDENTED_LINES_HALF ] && [ $TAB_LINES -gt 0 ];then
		debugMsg "Condition: TABS More than Half"
		echo  "$MF"
		cat $MF | perl -pe 's/\s{4}/\t/gi;'
	elif [ $TAB_LINES = $SPC_LINES ];then
		debugMsg "Condition: TAB matches count of SPACE"
		echo  "$MF ?"
	else
		debugMsg "Condition: Else: Unknown handling..."
		echo  "$MF ?"
	fi
	
	
done
