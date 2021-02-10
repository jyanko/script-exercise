#!/usr/local/bin/python3

#
# ReversoChange-o
#
# Given space seperated string
# 1. convert to list
# 2. reverse every other element
# 3. print newstring containing the modified result
# 
def reversoChangeo(inputS):
    v1=inputS
    v2=v1.split()
    print("Incoming List: " + str(v2))

    toggle=0
    newString=""
    for cI in v2:
        if toggle == 0:
            # print("Reverse It : " + cI)
            cI = cI[::-1]
            toggle=1
            # print(cI)
            
        else:
            # print("Leave   It : " + cI)
            toggle=0
            
        newString=newString + " " + cI
        
    print("Final: " + newString)
        

        

reversoChangeo("foo bar mop onion")
reversoChangeo("my big bad greek wedding was rated awesome")




    
    