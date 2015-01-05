import sqlite3
import os
import numpy as np
import pandas as pd
import datetime
import matplotlib.pyplt as plt

conn = sqlite3.connect(os.path.join('data', 'processed', 'laketemp.sqlite'))

c = conn.execute('select eb_int from lakes group by eb_int')
eb_int_list = [e[0] for e in c.fetchall()]

def ctdplot(ebi):
    '''plots for one-day CTD measurements'''
    c = conn.execute('''select temperature, depth from temperature 
                        where eb_int = ? order by depth asc''', (ebi, ))
    
