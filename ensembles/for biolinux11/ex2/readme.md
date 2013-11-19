experiment to find out the optimum depths for estimating regional f
===================================================================
where f is the function of geography (climate, especially continentality and polarity), 
lake morphology and maybe colour


approaches (TODO)
=================

1. Make FLake possible to run in the FME context
2. Again, using FLake, make a simulation (call this target) with known target parameters (say attenuation and fetch), and let the MCMC function in FME find the values - for example give temperature at selection of time (e.g., weekly) and selection of depth as the "observation target" to the MCMC.  
3. Go about doing many different directions from here: for example put it in multiple-model context, real world observation context, or regional functional parameter (e.g., fetch parameter as a function of geography/climate, area, and hypsography)

an email quote
==============
o you think we can start with just one model (for the moment we can just use FLake - it's faster)? That is, not using FLake and MyLake, like I said in the below email. 

I am thinking of a simplest design:
```
p: parameters (say p1 attenuation coefficient and p2 fetch)
t: time
d: depth
T(t, d | p): temperature profile obtained with a model given p, function of t and d
```
we make arbitrarily a target temperature profile, say 
```
p1 = 2
p2 = 1000
```
then we obtain `T*(t, d)`, whole 2-d domain

Now, the question (as your idea points to) is about finding the optimal set `d'` such that, when 

    || T*(t, d') - T(t, d' | p^hat) || 

is made smallest, `p^hat` actually is closer to `p1 = 2` and `p2 = 1000`. 

The suggested present study is still a worthy test even using the same model and known parameters. At the end of the day it's about the extent of self-explanability FLake's parameter space has. 

If the above could be the Part 1, then Part 2 will be about either using multiple models, or using real observation, or on the regional context (we want fetch or BV parameters as a function of geography/climate, hypsographic curve, and surface area, for example p(geo, hyp, area)). Part 2 will then not assume any more that the model is perfect representation of reality. 


FME::modFit exercise
====================

PDF files available under directory modFit


```
## the following is easy: starting from the answer
> Fit1 <- modFit(objective, c(pars, recursive = TRUE),
               lower = pars.gs.range[['min']],
               upper = pars.gs.range[['max']]
               )
> print(summary(Fit1))

Parameters:
       Estimate Std. Error   t value Pr(>|t|)    
depth 2.000e+01  5.230e-15 3.824e+15   <2e-16 ***
fetch 1.000e+03  6.123e-12 1.633e+14   <2e-16 ***
atten 2.000e+00  1.874e-15 1.067e+15   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 1.464e-14 on 362 degrees of freedom

Parameter correlation:
       depth  fetch  atten
depth 1.0000 0.1839 0.4971
fetch 0.1839 1.0000 0.1860
atten 0.4971 0.1860 1.0000

## starting a bit off, takes more iterations
> Fit2 <-  modFit(objective, c(pars, recursive = TRUE) / 2,
               lower = pars.gs.range[['min']],
               upper = pars.gs.range[['max']]
               )
> print(summary(Fit2))
    Parameters:
       Estimate Std. Error   t value Pr(>|t|)    
depth 2.000e+01  1.684e-13 1.188e+14   <2e-16 ***
fetch 1.000e+03  1.971e-10 5.073e+12   <2e-16 ***
atten 2.000e+00  6.034e-14 3.314e+13   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 4.712e-13 on 362 degrees of freedom

Parameter correlation:
       depth  fetch  atten
depth 1.0000 0.1838 0.4971
fetch 0.1838 1.0000 0.1860
atten 0.4971 0.1860 1.0000
```

FME::modMCMC
============

Continuing from the previous case. 1-year daily water surface temperature

the answer:
```
depth: 20
fetch: 1000
atten: 2
```
starting values:
```
depth: 10
fetch: 500
atten: 1
```
Note:

- Depth and atten converged quickly but fetch didn't converge after 500th iteration.
- SSR got reduced to minimum (optimum at 50th iteration, but at this stage fetch was not converged)

See modMCMC/mcmc3.RData and modMCMC/mcmc.pdf

dream::dream
============

contrast dream3 and dream4 -- dream4 is more precise faster. 

another email
=============

- Assume we have a lake (located near Lillestrøm, arbitrary choice) with known depth (25 m) and attenuation coefficient (2, both arbitrary). Assume also we know the weather for a certain year (I picked 1991). Assume also that the lake model (FLake) is capable of fully representing the lake's heat-balance perfectly. 

- Now, we create a simulation with a target fetch (say 1000 m). Fetch for FLake is a proxy for MyLake's B-V diffusion coefficient, right?  We make the DREAM-MCMC algorithm to find this fetch value, 1000. 

- In order to be somewhat realistic, let's say that we have daily observation for the period
 - from one month after ice break
 - to mid August

- We compare several depth "approaches" -- this is the _meat_ of the study
 - surface only 
 - 1 m only, 2 m only, 3 m only, ..., 20 m only
 - 5C21 of the above (randomly sample 100 combinations)
 - 10C21 of the above (randomly sample 100 combinations) 

- This will result in 221 calibrations (1 + 20 + 100 + 100)

- I am expecting that those depth approaches with near-surface only would fail to find the fetch value, because spring-summer surface temperature is mostly about weather, not about lake parameters, such as depth, attenuation, or fetch. 

- If we let it have 20 hours, each calibration is given 5 min each. That's about 600 model iteration in each calibration using the 2-core biolinux11. That's probably enough time for calibrating only one parameter. I'll give it 3 'sequences' of MCMC chains for each calibration, so 3 times 200 parameter values. 

