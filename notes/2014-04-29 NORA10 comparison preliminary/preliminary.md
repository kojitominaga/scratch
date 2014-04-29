Preliminary assessment of interpolation methods from NORA10
===========================================================

done against the weather station Blindern in Oslo

Variables
---------

### Air temperature

![](png/air temperature (degree C) i3co.png)

Good overall. 

### Precipitation

![](png/precipitation (mm) i3co.png)

5-day runninge mean has much less error than daily accuracy. The extreme events seem to happen about equally often (not tested). 

### Other variables

![](png/atm. pres. at station level (hPa) i3co.png)
![](png/relative humidity (percent) i3co.png)
![](png/wind speed (m s-1) i3co.png)
![](png/cloud cover (octas) i3co.png)

- Quite satisfied with cloud cover
- Wind speed could have been better, but should be of good utility
- Relative humidity and air pressure is not most important for lake modelling, and I think it's acurate enough for the purpose. 

Comparison of interpolation methods
-----------------------

### The elevation correction is important. Seem to make it more accurate.

#### Nearest vertex (i1a) vs Co-kriging method 2 (i3co)

![](png/atm. pres. at station level (hPa) i1a.png)
![](png/atm. pres. at station level (hPa) i3co.png)

### The 'i3co' methos is probably the best in terms of precision and accuracy. 

See [more results here](png)