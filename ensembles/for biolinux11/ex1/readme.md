Experiment to test how quickly Flake runs
=========================================

also testing the packing of resulting netCDF file (eventually)

computation time
----------------

extracting .csv.gz from .nc: a few seconds each vertex
making 24 hours for rsds and tas: ca 30 seconds per vertex
running flake and writing to csv/*.csv.xz: ca. 33 seconds per vetex

Fennoscandia rectangle: 058-035 to 093-064 (whole range is 000-000 to 094-085)
x-y (north-east)
36 times 30 = 1080 vertices

scripts to run in order
-----------------------

1. fetch.py
2. ncgz2nc.sh
3. nc2csvgz.py -- createws many folders at grid vertices
4. getlatlon.py -- this creates lat.txt and lon.txt
5. make24hours.R -- this uses the lat.txt and lon.txt files
6. runsimplesimpler.R -- just for FLake, without rLakeAnalyzer
7. runsimple.R (it doesn't work as of 2013-10-28; waiting for rLakeAnalyzer response)

others
------
latlon2kml.py