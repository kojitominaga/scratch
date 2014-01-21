about this folder
=================

freebee/
--------

- getfromlinux11.py -> getfromlinux11.sh
- getfromlinux11_small_data.sh
  - these fetches .nc and comsat lake data from biolinux11
  - creates:
    comsat/

- readorog.py -> 
    latfn = 'NORA10_11km_lat.txt'
    lonfn = 'NORA10_11km_lon.txt'
    orogfn = 'NORA10_11km_orog.txt'
- spatial_interpolation
  - usage: 
    ## usage: Rscript spatial_interpolation.R --args NORA10file
  - uses:
    readCOMSAT.R which uses readorog.R
  - uses:
    readNORA10.py
  - usage of readNORA10.py
    usage: python readNORA10.py ncfname timei signifdigits alldays(logical) outdir
  - creates:
    - many files in:
       - temp/ this is intermediate files between .nc and interpolation analyses
       - interpolated/ results of interpolation


