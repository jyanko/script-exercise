#!/usr/local/bin/python3

##################################
# TASK #5
# 
# Below we will define an n-interesting polygon. Your task is to find the area of a polygon for a given n.
#
# A 1-interesting polygon is just a square with a side of length 1. An n-interesting polygon is obtained by taking the n - 1-interesting polygon and appending 1-interesting polygons to its rim, side by side. You can see the 1-, 2-, 3- and 4-interesting polygons in the picture below.
#
# Example
#
# For n = 2, the output should be
# shapeArea(n) = 5;
# For n = 3, the output should be
# shapeArea(n) = 13.
def shapeArea(n):
    print("*** START: shapeArea: " + str(n) )
    if n == 1:
        baseRow   = 1
        rowCount  = 1
        area      = 1
    else:
        baseRow   = (2 * n) - 1    # number of squares in baseRow
        rowCount  = n              # number of rows above baseRow
        lastRow   = baseRow        # number of squares in lastRow    
        upperRows = 0              # number of squares found in upperRows
        
        print("baseRow is " + str(baseRow))
        for i in range(1, rowCount):
            #print("=> lastRow was " + str(lastRow))
            currRow   = lastRow - 2
            upperRows = upperRows + currRow
            print("=> row " + str(i) + " is " + str(currRow) + " / lastRow was " + str(lastRow) + " / upperRows area " + str(upperRows))
            lastRow = currRow
        
        # area is the baseRow + (2 * upperRows)
        area = baseRow + (2 * upperRows)
        
    print("=> area    is " + str(area) )
    
    return area
    
    
# baseRow = 1 or 1 + input
# above rows will belowRow - 2
# below rows will be aboveRow - 2

shapeArea(1)
shapeArea(2)
shapeArea(3)
shapeArea(4)
shapeArea(5)


 




    
    