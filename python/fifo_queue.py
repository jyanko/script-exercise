#!/usr/local/bin/python3

#
# TASK: create a first in/first out queue
#
# Requirements
# - 
# - function: enqueue(element) : takes element as only param, provides no return value
# - function: dequeue()        : takes no input, removes item from the queue
# - function: get(index)       : takes index to get as param, returns element


def enqueue(e):
    global aQ
    aQ.insert(0, e)  # appends to front of list
    
def dequeue():
    global aQ
    aQ.pop(-1)       # removes from tail of list

def get(i):
    myThing = aQ[i]
    return myThing

print('===== START SCRIPT =====')
# start with an empty list
aQ=[]

# Populate some elements to the list by calling enqueue() 
# - 'count' defines high number of elements to create in queue sample
count=range(1,10)    
for i in count:
    enqueue(f'item-{i}')

print(f'\nQueue has: {len(aQ)} elements\n')

# Work through items in the queue
while len(aQ) > 0:
    print(f'aQ: {aQ}')
    print(f'=> set var to last element of list')
    var=get(-1)
    print(f'=> var: {var}')
    dequeue()
    
if len(aQ) <= 0:
    print("\nQueue is CLEAR\n")
    print(f'=> aQ: {aQ}')



