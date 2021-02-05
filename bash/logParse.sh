##################################################################
# CHALLENGE #1
##################################################################
# Given a set of logfiles in format as follows...
# 
#    127.0.0.1 user-identifier frank [10/Oct/2000:13:55:36 -0700] "GET /apache_pb.gif HTTP/1.0" 200 2326
#
# 1) generate a report of file requests per day from all logfiles in a log directory
# 2) given that all logfiles have .log suffix and are in root of the  log dir (not nested or compressed)
# 3) output should be printed as DATE followed by count of requests for that day
#
# Desired Output like this...
#    09/Oct/2000 15234
#    10/Oct/2000 44030
#    11/Oct/2000 39478
#
LOGDIR=./logs.fake
DATES=`egrep -i ' \/.* ' $LOGDIR/*.log | awk '{print $4}' | awk -F ':' '{print $1}' | tr -d '[' | sort -u `
for DATE in ${DATES[*]};do
    YMD=$(echo $DATE)
    echo "$YMD $(fgrep "[$YMD" $LOGDIR/* | wc -l)"
done
