about this folder
=================

TODO
----

## new 2014-01-28
I discovered a problem with the variogram model. Now I'm trying to find out the best way to choose the model. 

abel/
----
# todo
I might have to do something for 3.3 handling (there may not be anything left depending on the choice of tarsplitn


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
- spatial_interpolation.R
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

- batchspatial.py -> batchspatial.sh
  - calls spatial_interpolation.R many times

Hours on abel
-------------
About 10 hours per interpolation

Why co-kringing is probably important
-------------

```
> ku30[which(ku30@data[['var1.pred']] == max(ku30@data[['var1.pred']])), ]
           coordinates var1.pred var1.var
30 (5.70417, 59.52667)  279.6142 2.439092
> r <- rank(spDistsN1(n10n, comsat[30, ], longlat = TRUE))
> n10n[r <= 10, ]
               coordinates      v   orog
33140 (5.479765, 59.44864) 274.15  627.5
33141 (5.627058, 59.38246) 272.90  732.0
33387  (5.46215, 59.58978) 274.02  698.5
33388  (5.610119, 59.5236) 272.27  904.0
33389 (5.757498, 59.45727) 271.59  904.0
33390 (5.904316, 59.39075) 271.71  854.0
33635 (5.593003, 59.66476) 272.84  898.0
33636 (5.741044, 59.59844) 271.09 1040.0
33637 (5.888494, 59.53196) 271.02  981.5
33884 (5.872556, 59.67315) 271.15 1054.0
> comsat[30, ]
           coordinates  ID       Lake       Date  Time orog Area.km2 NVE.ID
30 (5.70417, 59.52667) 394 Vatsvatnet 21.07.2011 17:18   15     2.17   2036
   NVE.REGINE SMHI.ID EU_CD VDRID
30     038.5B                    
> ku30[30, ]
           coordinates var1.pred var1.var
30 (5.70417, 59.52667)  279.6142 2.439092
> ko30[30, ]
           coordinates var1.pred  var1.var
30 (5.70417, 59.52667)  271.5875 0.2874269
```

Design
------

- meteorological variable
- year
- time entry ("hour" or "3 hours")
- interpolation methods

Interpolation methods
-------------

### interpolation types

- simple (1)
  - nearest (1a)
  - mean of nearest four (1b)
  - 2D linear interpolation (triangle) (1c)

- geographical (2 scopes: i. supra region (2), or ii. local near each lake (3)) either way there are 100 in the scope 
  - inverse distance (2an, 3an)
  - inverse distance with weighting (2ao, 3ao)
  - ordinary kriging with vgm-linear (see *nlocal*) (2bn *nlocal*, 3bn *nlocal*)
  - universal kriging with vgm-linear (see *nlocal*) (2bo *nlocal*, 3bo *nlocal*)
  - ordinary kriging with vgm-evrything (see *nlocal*) (2cn *nlocal*, 3cn *nlocal*)
  - universal kriging with vgm-everthing (see *nlocal*) (2co *nlocal*, 3co *nlocal*)

- nlocal (*nlocal*)
  - 10 vertices
  - 30 vertices
  - 50 vertices
  - 100 vertices (all)

### vgm-statistics (time x year x variable)

- vgms (n = nlakes + 1)
  - each for local vgm (n = nlakes) (3_lakeid)
  - one for the supra region (n = 1) (2)

- scope specific
  - vario (variogram)

- non-scope specific (i.e., need for all vgm configurations)
  - sills
  - RMSE / maxgamma

