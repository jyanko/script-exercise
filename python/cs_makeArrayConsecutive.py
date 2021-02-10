#!/usr/local/bin/python3



##################################
# TASK #7
# 
# Ratiorg got statues of different sizes as a present from CodeMaster for his birthday, each statue having an non-negative integer size. Since he likes to make things perfect, he wants to arrange them from smallest to largest so that each statue will be bigger than the previous one exactly by 1. He may need some additional statues to be able to accomplish that. Help him figure out the minimum number of additional statues needed.
#
# 
# Example
#
# For statues = [6, 2, 3, 8], the output should be
# makeArrayConsecutive2(statues) = 3.
#
# Ratiorg needs statues of sizes 4, 5 and 7.

def makeArrayConsecutive2(statues):

    statues.sort()               # sort the incoming array
    lastIndex=len(statues)       # determine count of elements in array
    nLow  = statues[0]           # capture the lowest number
    nHigh = statues[-1]          # capture the highest number
    nMissing=[]                  # define an array to add the numbers missing from sequence
    myR = range(nLow,nHigh+1 )   # define an array of the sequence expected to exist
    
    for rVal in myR:
        if rVal not in statues:
            print(str(rVal) + " NOT found in list statues")
            nMissing.append(rVal)
        else:
            print(str(rVal) + " found in list statues")
             
    print("Statues List: " + str(statues))
    print("Last Postion: " + str(lastIndex))
    print("Lowest  Num : " + str(nLow))
    print("Highest Num : " + str(nHigh))
    print("myR         : " + str(myR))
    print("Statues Cnt : " + str(len(statues)))
    print("Missing Cnt : " + str(len(nMissing)))

    return len(nMissing)

statues = [6, 2, 3, 8]
minExtra=makeArrayConsecutive2(statues)
print("Final: " + str(minExtra))


