#!/bin/bash

#
# Determine final balance for each person 
# - Input Format is CSV
# - Fields are: <name>,<action>,<amount>
# - Action is either D or W indicating Deposit or Withdrawal
#

# Setup the Input file...
printf "Bob,D,100
Jim,D,500
Sal,D,100
Rox,D,300
Bob,W,50
Jim,D,300
Bob,D,100
Jim,D,300
Bob,W,25
Jim,W,99
Sal,D,100
Sal,W,10
Sal,W,10
Rox,W,15" > /tmp/input.txt

#
# Start Script to process the file...
#
A_NAMES=($(cat /tmp/input.txt | awk -F ',' '{print $1}' | sort -u))

function doMath(){
	# param $1 is action
	# param $2 is value to add/subtract 
	# param $3 is current balance
	l_ACT=$1
	l_VAL=$2
	l_BAL=$3
	if [ $l_ACT == "D" ];then
		l_newbal=$(( $l_BAL + $2 ))
	elif [ $l_ACT == "W" ];then
		l_newbal=$(( $l_BAL - $2 ))
	fi
	echo $l_newbal
}


echo "Found ${#A_NAMES[*]} names => ${A_NAMES[*]}"

for NAME in ${A_NAMES[*]};do
	BALANCE="0"
	#printf "\n=> Processing $NAME\n"
	#cat /tmp/input.txt | grep $NAME
	while read LINE ; do
		if [ `echo $LINE | egrep "$NAME"` ];then
			ACTION=$(echo $LINE | awk -F ',' '{print $2}')
			VALUE=$(echo $LINE | awk -F ',' '{print $3}')
			BALANCE=$(doMath $ACTION $VALUE $BALANCE)
		fi	
	done < /tmp/input.txt
	echo "FINAL BALANCE for ($NAME): $BALANCE"
done
