#!/usr/local/bin/python3

 
def loopSquares(n):
    # accept single integer as input
    # create a loop that prints the square of each integer from 0-n
    print("Process: ", n)
    myList=range(0,n+1) # add 1 to n to ensure n is actually included in range
    #print("myList: " + str(myList) + " type: " + str(type(myList)))
    for i in myList:
        print(str(i) + " " + str(i ** 2))
          
loopSquares(9)
loopSquares(5)




    
    