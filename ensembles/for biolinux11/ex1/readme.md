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

testing for compression, significant digits etc.
================================================

    1571245  1 Nov 09:44 test_originalsize.nc
    1499373  1 Nov 09:50 test_zlib.nc
    1354110  1 Nov 09:56 test_zlib_signif1.nc
    1361158  1 Nov 09:52 test_zlib_signif2.nc
    1361073  1 Nov 09:59 test_zlib_signif2_comp9.nc

Couldn't notice the difference in speed when using 3 variables with dimensions ca. 3000 x 3 x 4 x 1 x 1 x 1.

Looks like it's best to use zlib_signif2 or other necessary significant digits, but keep the compression level default of 4. 

