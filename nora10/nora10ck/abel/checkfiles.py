import os
import sys
import time

files = sys.argv[1:]

finished = False

while not finished:
    flag = True
    print('----')
    for f in files:
        thisflag = os.path.exists(f)
        print(' '.join([f, 'finished' if thisflag else 'not finished']))
        flag = flag and os.path.exists(f)
    if flag:
        finished = True
    time.sleep(120)

