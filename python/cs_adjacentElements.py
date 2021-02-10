#!/usr/local/bin/python3


##################################
# TASK #4
# 
# Given an array of integers, find the pair of adjacent elements that has the largest product and return that product.
#
# Example
#
# For inputArray = [3, 6, -2, -5, 7, 3], the output should be
# adjacentElementsProduct(inputArray) = 21.
#
# 7 and 3 produce the largest product.
#
def adjacentElementsProduct(inputArray):
    #print(len(inputArray))
    eFirst=0
    eLast=len(inputArray) - 1
    hiVal=None
    
    #print("eLast: " + str(eLast))
    for eIndex, eValue in enumerate(inputArray):
        
        if eIndex >= eLast:
            pass # skipping if last element of list detected
        else:
            eNext=eIndex + 1
            currProduct=inputArray[eIndex] * inputArray[eNext]
        
            if hiVal == None or hiVal < currProduct:
                hiVal = currProduct
                        
    return hiVal
        
   
# setup some input lists to run against...     
inputLists=[
    [3, 6, -2, -5, 7, 3],
    [-23, 4, -3, 8, -12],
    [4, 9, 2, 1, 7, 10, 5, 3]
]

for myList in inputLists:
    print("Processing: ", myList)
    hiVal=str(adjacentElementsProduct(myList))
    print("=> HiVal: " + hiVal)



