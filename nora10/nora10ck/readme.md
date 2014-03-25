about this folder
=================

TODO
----

## new 2014-01-28
I discovered a problem with the variogram model. Now I'm trying to find out the best way to choose the model. 

abel/
----

### todo


I might have to do something for 3.3 handling (there may not be anything left depending on the choice of tarsplitn
remove non-ascii characters from locations.csv

### 17 Feb 2014

Noticed errors in which some tar files 0000-0009.tar etc. are created but contains no data (file size = zero). It seems to have continues after the "error". A better way to implement is 

1. not to use the COMPLETE file (just check every file is __not__ empty. If any .tar file is missing, create data for those missing. 
2. at the end of part 1, and at the end of part 2, check that the file is __not__ empty. 

### 18 Feb 2014

Also discovered the case where only partial files in the part 1 .tar file exists -- Job 5123272 ("l9312hur_2m"

### 20 Feb 2014

Should be mostly working well. Now trying to make multiple runs in one job so that the 400-job limitiation does not become limitation. I see that there are some free available slots in abel occasionally. 

### 21 Feb 2014

Reorganized the output directories.

## abel directories

- /work/users/kojito/nora10/nc/_varname_/
  - _ncfname_
  
This is where the original .nc files are kept (45-day expiry)

- /work/users/kojito/nora10/intermediate/_locationname_/_varname_/_timestat_/_year_/
  - _iiii_-_jjjj_.tar
    - contains for example: NORA10_1H_11km_wss_10m_2012_0002.txt.bz2
  - COMPLETED

This is where the extracted data at each time point (or statistics of it, see below) is stored

- time statistics
  - mean24: daily mean of the hourly data (n = 24)
  - mean8: daily mean of the three-hourly data (n = 8)
  - (maybe) 1H, 3H, max24, max8, min24, min8, etc...

- /work/users/kojito/nora10/interpolated/_locationname_/_varname_/_timestat_/_year_/
  - _iiii_-_jjjj_.tar
    - NORA10_1H_11km_ts_0m_2012_0000_Grunnaai_interpolated_cutoff_100_nlocal_50.txt
      - the interpolated data
    - NORA10_1H_11km_ts_0m_2012_0000_Grunnaai_metadatainterp_cutoff_100_nlocal_50.txt
      - stats about the interpolations
    - NORA10_1H_11km_ts_0m_2012_0000_Grunnaai_variograms_cutoff_100.RData
      - variogram model coefficients
  - COMPLETED

This is where the interpolate data at each time point is stored. 



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

Output columns
==============

## Dimension A1: interpolation methods (for predicted values)

1. __i1a__: value from nearest point
2. __i1b__: mean of the nearest four points
3. __i1c__: 2D linear interpolation (triangular plane) of the nearest three points
4. __i3an__: inverse distance (~ 1)
5. __i3ao__: inverse distance weighted (~ orog)
6. __i3bn__: ordinary kriging (~ 1) using linear variogram model
7. __i3bo__: universal kriging (~ orog) using linear variogram model
8. __i3cn__: ordinary kriging (~ 1) using "everything" variogram model
9. __i3co__: universal kriging (~ orog) using "everything" variogram model

Here __everything__ model is an additive model of: _nugget_, _linear_, _gaussian_, _exponential_, _spherical (partial sill at 50 percent max distance)_, and _spherical (psill at 75 percent max distance)_. 

## Dimension A2: statistics etc. 

1. __locallyhomog3__: was it locally homogeneous? (0 = _no_, 1 = _yes_)
  - if yes, no kriging done -- simply the homogeneous value
2. __maxgamma3__: max gamma (semivariance) for __sample variogram__ (call this __i__)
3. __maxgamma3o__: max gamma for __sample variogram for residual after orog__ (call this __ii__)
4. __maxdist3__: max distance in the variogram scope
5. __maxdist3o__: max distance in the variogram (residual after orog) -- sorry, __same as above__
6. __vfl3Lin__: VGM from __i__: partial sill for the linear model relative to max gamma
6. __vfl3oLin__: VGM from __ii__: partial sill for the linear model relative to max gamma
7. __vfe3Nug__: VGM from __i__: psill for "everything" nugget, relative to max gamma
7. __vfe3Lin__: VGM from __i__: psill for "everything" linear, relative to max gamma
7. __vfe3Gau__: VGM from __i__: psill for "everything" gaussian, relative to max gamma
7. __vfe3Exp__: VGM from __i__: psill for "everything" exponential, relative to max gamma
7. __vfe3S50__: VGM from __i__: psill for "everything" spherical50, relative to max gamma
7. __vfe3S75__: VGM from __i__: psill for "everything" spherical75, relative to max gamma
7. __vfe3oNug__: VGM from __ii__: psill for "everything" nugget, relative to max gamma
7. __vfe3oLin__: VGM from __ii__: psill for "everything" linear, relative to max gamma
7. __vfe3oGau__: VGM from __ii__: psill for "everything" gaussian, relative to max gamma
7. __vfe3oExp__: VGM from __ii__: psill for "everything" exponential, relative to max gamma
7. __vfe3oS50__: VGM from __ii__: psill for "everything" spherical50, relative to max gamma
7. __vfe3oS75__: VGM from __ii__: psill for "everything" spherical75, relative to max gamma
20. __vfl3SSE__: VGM from __i__: SSE of the fit for the linear model
21. __vfl3oSSE__: VGM from __ii__: SSE of the fit for the linear model
22. __vfe3SSE__: VGM from __i__: SSE of the fit for the "everything" model
23. __vfe3oSSE__: VGM from __ii__: SSE of the fit for the "everything" model
24. __vfl3RSSE__: VGM from __i__: SSE of the fit for the linear model, relative to max gamma
25. __vfl3oRSSE__: VGM from __ii__: SSE of the fit for the linear model, relative to max gamma
26. __vfe3RSSE__: VGM from __i__: SSE of the fit for the "everything" model, relative to max gamma
27. __vfe3oRSSE__: VGM from __ii__: SSE of the fit for the "everything" model, relative to max gamma
28. __var3an__: variance for __i3an__ (this is _NA_, due to the nature of the interpolation)
29. __var3ao__: variance for __i3ao__
30. __var3bn__: variance for __i3bn__
31. __var3bo__: variance for __i3bo__
32. __var3cn__: variance for __i3cn__
33. __var3co__: variance for __i3co__

For the moment I have only used _nlocal_ = 50, _cutoff_ = 100

## Dimension B: meterological variables

- __ta\_2m__: 2-m air temperature [K]
- __ts\_0m__: surface temperature [K]
- __pr__: atmospheric precipitation at surface [kg m-2 s-1]
- __ps__: surface atmopheric pressure [Pa]
- __psl__: sea-level atmospheric pressure [Pa]
- __albedo__: surface albedo [-]
- __wss\_10m__: 10-m wind speed [m s-1]
- __wfds\_10m__: 10-m wind direction [degree], 0 means N, 90 means E
- __hur\_2m__: 2-m relative (check) humidity percent [-]
- __clt__: cloud cover [-]
- __rls__: net longwave surface heat flux, positive downward (check)
- __rss__: net shortwave radiation flux, positive downward (check)

## Dimension C: locations

We can have locations as columns. 

## About NORA10

Reistad M., O. Breivik, H. Haakenstad, O. J. Aarnes, B. R. Furevik and J-R Bidlo, 2011. A high-resolution hindcast of wind and waves for The North Sea, The Norwegian Sea and The Barents Sea. J. Geophys. Res., 116, C05019, doi:10.1029/2010JC006402

Hints
=====

Note that R can handle gzipped files (.gz) transparently. 

```
yourdata <- read.table('yourfile.txt.gz', header = TRUE)
```

will do the reading.

A bit more advanced: Let's say you want to compare pr with different interpolation methods.

```
interpmethods <- paste('i', c('1a', '1b', '1c', 
                              '3an', '3ao', '3bn', '3bo', '3cn', '3co'))
filenames <- sprintf('NORA10_1H_11k_pr_2009-2012_mean24_interpolated_%s.txt.gz', 
                 interpmethods)
datalist <- lapply(list(filenames), read.table, header = TRUE)
names(datalist) <- interpmethods
## then explore
str(datalist)
lapply(datalist, function(x) { print(summary(x)) })
lapply(datalist[['i3co']], mean)
```

Done so far
===========

ta_2m, ts_0m, hur_2m, wss_10m, pr, ps, psl, clt, albedo for 1999 - 2012, daily mean only

Coming up... 
=============

In order of appearance... 

1. rls, wfds_10m
2. rss
3. 1958 - 1998 for lakes other than Langtjern for NIVA and Storgama
4. hourly or 3-hourly 
5. port to CORDEX

