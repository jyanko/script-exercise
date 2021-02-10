#!/usr/local/bin/python3

##################################
# TASK #3
#
# Given the string, check if it is a palindrome.
#
# Example
#
# For inputString = "aabaa", the output should be
# checkPalindrome(inputString) = true;
#

def checkPalindrome(inputString):
    print("Forward : " + inputString)
    
    print("Backward: " + inputString[::-1])
    
    if inputString == inputString[::-1]:
        return True
    else:
        return False

    
myStrings=["gohangasalamiimalasagnahog","madamimadam","notapalindrome"]    

for myInput in myStrings:
    if checkPalindrome(myInput):
        print("PASS")
    else:
        print("FAIL")

