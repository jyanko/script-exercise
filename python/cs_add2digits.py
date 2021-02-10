#!/usr/local/bin/python3

##################################
# TASK #6
# 
# You are given a two-digit integer n. Return the sum of its digits.
#
# Example
#
# For n = 29, the output should be
# addTwoDigits(n) = 11.
#
def addTwoDigits(n):
    # myInput = str(n)
    myList = list(str(n))
    f1 = int(myList[0])
    f2 = int(myList[1])
    mySum = f1 + f2
    print("=> mySum: " + str(mySum))
    return mySum
    
addTwoDigits(29)
addTwoDigits(73)
addTwoDigits(11)
