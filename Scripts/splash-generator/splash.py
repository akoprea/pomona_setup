#!/bin/python

import random

def main():
    splashes_file = "/home/zac/Scripts/splash-generator/splashes.txt"
    with open(splashes_file, 'r') as file:
        contents = file.read()
        file.close()
    
    # parse contents
    splashes = contents.split("%\n")
    splashes.pop(0) # remove empty first element

    num_splashes = len(splashes) # number of splashes

    for s in range(num_splashes):
        splashes[s] = splashes[s].strip() # strip ending \n from each splash
    
    ## for s in splashes: print(s+"\n") # DEBUG print all messages

    # Get random choice from splashes array
    choice = random.choice(splashes)
    ## print(choice)

    # Frame the choice nicely
    box_output = "" # str to add text to
    indent = "    "
    n_pad = 1
    box_vert = "│" #"│" #"|"
    box_horiz = "─"
    box_ll = "└"
    box_lr = "┘"
    box_ul = "┌"
    box_ur = "┐"

    box_output += indent + box_ul + (box_horiz*(2*n_pad+len(choice))) + box_ur + "\n"
    box_output += indent + box_vert + (" "*n_pad) + choice + (" "*n_pad) + box_vert + "\n"
    box_output += indent + box_ll + (box_horiz*(2*n_pad+len(choice))) + box_lr
    print(box_output)

    return None

if __name__ == '__main__':
    main()
