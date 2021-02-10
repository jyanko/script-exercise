#!/usr/local/bin/python3

import datetime
def checkDate(lineDate, dLo, dHi):
    #
    # check if lineDate is between dLo and dHi - return true if it is within range
    #
    # print("lineDate is greater than dLo : ", lineDate > dLo)
    # print("lineDate is less    than dHi : ", lineDate < dHi)
    
    lineDate = datetime.datetime.strptime(lineDate, '%d/%b/%Y:%H:%M:%S %z')
    dLo  = datetime.datetime.strptime(dLo, '%d/%b/%Y:%H:%M:%S %z')
    dHi = datetime.datetime.strptime(dHi, '%d/%b/%Y:%H:%M:%S %z')
        
    if ((lineDate > dLo) and (lineDate < dHi)):
        return True
    else:
        return False
        
print('Test1: Pass') if checkDate("04/Jun/2015:07:08:35 +0000", "04/Jun/2015:06:06:00 +0000", "04/Jun/2015:07:08:55 +0000") else print('Test1: Fail')
print('Test2: Pass') if checkDate("04/Jun/2015:08:08:35 +0000", "04/Jun/2015:06:06:00 +0000", "04/Jun/2015:07:08:55 +0000") else print('Test2: Fail')
print('Test3: Pass') if checkDate("04/Jun/2015:07:08:35 +0000", "04/Jun/2015:06:06:00 +0000", "04/Jun/2015:07:08:55 +0000") else print('Test3: Fail')
    

    
    