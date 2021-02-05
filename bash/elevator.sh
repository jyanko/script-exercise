#!/bin/bash

####################################################################################################################
# Design an Elevator System
####################################################################################################################
#
# Problem Description
#
# R1. The elevator can move up & down
# R2. The elevator has buttons inside to let the user who got in select their desired floor
# R3. Each floor has buttons to summon the elevator to go to floors above and below respectively
# R4. Buttons illuminate indicating the request is accepted (assume all buttons, inside and out)
# R5. When the elevator reaches the requested floor the button stops illuminating

echo "==== START OF ELEVATOR EXERCISE ===="

#
# USAGE
#
#    scriptname.sh <calling> <current> <target>
#
# EXAMPLES
#
#    scriptname.sh 1 4 3       # will set calling, current, and target as defined
#    scriptname.sh 1 4         # will set calling and current as defined, and prompt for target (unless TEST_MODE sets to default value)
#    scriptname.sh             # will set calling and current to defaults, prompt for target (unless TEST_MODE sets to default value)
#

INPUT_PARAMS=($@)

FLOOR_CALLING=${INPUT_PARAMS[0]}
FLOOR_CURRENT=${INPUT_PARAMS[1]}
FLOOR_TARGET=${INPUT_PARAMS[2]}

# lobby_panels is an array 
CALL_PANELS=(
    "floorNum upLite downLite"
    "1 off off"
    "2 off off"
    "3 off off"
    "4 off off"
)
# CAR_PANELS is an array 
CAR_PANELS=(
    "floorNum liteOn"
    "1 off"
    "2 off"
    "3 off"
    "4 off"
)

# R2. The elevator has buttons inside to let the user who got in select their desired floor
#     choose number from menu of options (numbers on panel)
function pushFloorNumberButton(){
	#
	# Determine the target floor and update button light on the car panel for that floor
	#    if target floor not provided as a param, prompt user for this input
	#
	# Params:
	#    @param1 - optional - value of target floor
	# 
	# Usage:
	#
	#    pushFloorNumberButton "3"
	#
	floorTarget=$1
    if [ -z $floorTarget ];then
        floorCount=$(echo ${CAR_PANELS[@]:(-1)} | awk '{print $1}')
        read -p "Enter Desired Floor (1-${floorCount}): " FLOOR_TARGET
	else
	    FLOOR_TARGET=$floorTarget
    fi
	CAR_PANELS[$FLOOR_TARGET]="$FLOOR_TARGET on"         # turn on floor number light on car panel
}

# R3. Each floor has buttons to summon the elevator to go to floors above and below respectively
function pushCallButton(){
	#
	# Determine direction and calling floor number, and illuminate lobby panel button lights accordingly
	#
	# Params:
	#    @param1 - required - value of floor calling the elevator
	#    @param2 - required - value of directional button selected at call panel
	# 
	# Usage:
	#
	#    pushCallButton "1" "up"
	#    pushCallButton "3" "down"
	#
    FROM_FLOOR=$1
    DIRECTION=$2
    echo "Pushing button ($DIRECTION) in lobby on floor ($FROM_FLOOR)"
    if [ $DIRECTION == "up" ];then
        # call to light the up arrow on floor $1
        CALL_PANELS[$1]="$1 on off"
    elif [ $DIRECTION == "down" ];then
        # call to light the down arrow on floor $1
        CALL_PANELS[$1]="$1 off on"
    fi
	showPanelLiteStatus "$FLOOR_CALLING"
	
}

# R1. The elevator can move up & down
# R5. When the elevator reaches the requested floor the button stops illuminating
function moveElevator() {
	#
	# Move the elevator to the target floor
	#    cancel all appropriate lobby and car panel lights upon arrival
	#
	# Params:
	#    @param1 - required - value of the target floor
	# 
	# Usage:
	#
	#    moveElevator "1"
	#
    
    tgtFloor=$1  # ending floor
    
    echo "Moving Elevator from floor: $FLOOR_CURRENT to floor: $tgtFloor"
    until [ "$FLOOR_CURRENT" == "$tgtFloor" ];do
        echo -n "    => current floor: $FLOOR_CURRENT"
        test "$FLOOR_CURRENT" -lt "$tgtFloor" && myDirection="up"   && FLOOR_CURRENT=$(( $FLOOR_CURRENT + 1 ))
        test "$FLOOR_CURRENT" -gt "$tgtFloor" && myDirection="down" && FLOOR_CURRENT=$(( $FLOOR_CURRENT - 1 ))
        echo " - going $myDirection"
    done
    echo "    => arrived at floor: $tgtFloor"
    echo "    => cancelling lights for Car:Button:$tgtFloor and lobby:$tgtFloor($myDirection)"
    CALL_PANELS[$tgtFloor]="$tgtFloor off off"   # turn off up|down light on lobby panel
    CAR_PANELS[$tgtFloor]="$tgtFloor off"         # turn off floor number light on car panel

    
    showPanelLiteStatus "$tgtFloor"
}

# visualize current state of panel lights
function showPanelLiteStatus(){
	#
	# Display the panel light status for both lobby call buttons and floor button in car panel
	#
	# Params:
	#    @param1 - required - value of floor to check for button light status
	# 
	# Usage:
	#
	#    showPanelLiteStatus "3"
	#
	
	tgtFloor=$1
	
    floor=$(echo ${CALL_PANELS[$1]} | awk '{print $1}')
    up=$(echo    ${CALL_PANELS[$1]} | awk '{print $2}')
    down=$(echo  ${CALL_PANELS[$1]} | awk '{print $3}')
	
	buttonLite=$(echo ${CAR_PANELS[$1]} | awk '{print $2}')
    echo "    => Panel Status ->  Car:Button:$tgtFloor($buttonLite) / Lobby:$floor: up($up) down($down) " 

}

function infoMessage(){
	#
	# Display a provided string as informational message during runtime - useful for debugging
	#    outputs a message like => "[INFO] Param Count: 3"
	#
	# Params:
	#    @param1 - required - string to print as info a message
	# 
	# Usage:
	#
	#    infoMessage "message to print"
	#

    echo "[INFO] $1" 1>&2   # redirected to stderr 

}

####################################################################################################################
# START FLOW - assume we are in elevator lobby on floor 1 to start, and the elevator car is up at floor 4
#
TEST_MODE="true"                      # true|false - enable or disable test mode features
FLOOR_CALLING=${FLOOR_CALLING:-"1"}   # floor where call button is being pressed (default to 1 if no param provided)
FLOOR_CURRENT=${FLOOR_CURRENT:-"4"}   # elevator car's current floor             (default to 4 if no param provided)

if [ $TEST_MODE == "true" ];then	
	FLOOR_TARGET=${FLOOR_TARGET:-"3"} # target floor the passenger will press upon entering the car (default 3 if undef and testmode=true)
fi

# call infoMessage to print formatted message to console
infoMessage "Input Params : ${INPUT_PARAMS[*]}"
infoMessage "Param Count  : ${#INPUT_PARAMS[*]}"
infoMessage "TEST_MODE    : $TEST_MODE"
infoMessage "FLOOR_CALLING: $FLOOR_CALLING"
infoMessage "FLOOR_CURRENT: $FLOOR_CURRENT"
infoMessage "FLOOR_TARGET : $FLOOR_TARGET"
	

echo "Walk into elevator lobby on floor: $FLOOR_CALLING"
# initial check to view current status of panel illumination...
showPanelLiteStatus "$FLOOR_CALLING"

# push button to call elevator (pass in current floor and desired direction as params)
pushCallButton "$FLOOR_CALLING" "up"

# when arrives, turn off directional call button light
moveElevator "$FLOOR_CALLING"

# get into the elevator, and press button for desired floor
echo "Step into Elevator"
echo "Push button to choose target floor"
pushFloorNumberButton "$FLOOR_TARGET"
showPanelLiteStatus "$FLOOR_TARGET"

# move elevator in to target floor
# - upon arrival at target floor, turn off light on floor selection panel
moveElevator "$FLOOR_TARGET"

echo "==== END OF ELEVATOR EXERCISE ===="





