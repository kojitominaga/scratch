#!/usr/bin/python
# -*- coding: utf-8 -*-
import sqlite3
import os
import numpy as np
import pandas as pd
import datetime
import pytz
import math
import osgeo.ogr
import shutil
import openpyxl

pdsn = os.path.join('..', '..', '..', '..', 'GIS_DATA', 'fenoscand_lakes', 
                  'fisk_presence_absence')
pf = 'fisk_NO_09'
datasource = osgeo.ogr.Open(pdsn)
layer = datasource.GetLayerByName(pf)
lakenames = []
feat = layer.GetNextFeature()
while feat is not None:
    name = feat.items()['INNSJONAVN']
    if not name == 'NA':
        vatnlnr = feat.items()['vann_id']
        fylke = feat.items()['FYLKE']
        kommune = feat.items()['KOMMUNE']
        x = feat.items()['X_KOORD']
        y = feat.items()['Y_KOORD']
        lakenames.append((vatnlnr, name.lower(), fylke, kommune, x, y)[:9])
    feat = layer.GetNextFeature()
namesdf = pd.DataFrame(lakenames, 
                       columns=['vatnlnr', 'name', 'fylke', 'kommune', 
                                'x', 'y'])

p3 = os.path.join('..', '..', '..', '..', 'GIS_DATA', 'fenoscand_lakes')
p4 = 'ecco-biwa_lakes_v.0.1'
datasource = osgeo.ogr.Open(p3)
layer = datasource.GetLayerByName(p4)
comsatgeom = set()
feat = layer.GetNextFeature()
print('it will take a few minutes...')
eblnr = []
while feat is not None:
    vatn_lnr = feat.items()['vatn_lnr']
    if vatn_lnr > 1:
        if vatn_lnr == 118:
            ebint = 1310457
        else:
            ebint = feat.items()['EBint']
        eblnr.append((vatn_lnr, ebint))
    feat = layer.GetNextFeature()
eblnrdf = pd.DataFrame(eblnr, columns=['vatn_lnr', 'ebint'])                       


dict1 = {'hessen1': 147, 
         'hessen2': 118,
         'hessen3': 272,
         'hessen4': 149,
         'hessen5': 126,
         'hessen6': 514,
         'hessen7': 580,
         'hessen8': 6,
         'hessen9': 1224,
         'hessen10': 1400,
         'hessen11': None,
         'hessen12': None,
         'hessen13': 1734,
         'hessen14': 1806,
         'hessen15': 652,
         'hessen16': 857}


