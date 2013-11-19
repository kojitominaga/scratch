
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

