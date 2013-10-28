Experiment to test how quickly Flake runs
=========================================

also testing the packing of resulting netCDF file (eventually)

path so far
-----------

1. fetch.py
2. ncgz2nc.sh
3. nc2csvgz.py -- createws many folders at grid vertices
4. getlatlon.py -- this creates lat.txt and lon.txt
5. make24hours.R -- this uses the lat.txt and lon.txt files
7. runsimple.R (it doesn't work as of 2013-10-28; waiting for rLakeAnalyzer response)
6. runsimplesimpler.R -- just for FLake, without rLakeAnalyzer