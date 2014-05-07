import os
import sys

lake = sys.argv[1]
newpars = sys.argv[2:]
# potentially expand to many numbers later

with open('cmdarguments.txt') as f:
    lines = f.readlines()

cmddict = dict([line.strip().split(' ', 1) for line in lines])    

thecommand = 'octave -qf runmylake.m ' + cmddict[lake] + ' ' + ' '.join(newpars)
print(thecommand)
os.system(thecommand)

