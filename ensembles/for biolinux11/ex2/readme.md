experiment to find out the optimum depths for estimating regional f
===================================================================
where f is the function of geography (climate, especially continentality and polarity), lake morphology and maybe colour


approaches (TODO)
=================

1. Make FLake possible to run in the FME context
2. Again, using FLake, make a simulation (call this target) with known target parameters (say attenuation and fetch), and let the MCMC function in FME find the values - for example give temperature at selection of time (e.g., weekly) and selection of depth as the "observation target" to the MCMC.  
3. Go about doing many different directions from here: for example put it in multiple-model context, real world observation context, or regional functional parameter (e.g., fetch parameter as a function of geography/climate, area, and hypsography)

an email quote
==============
o you think we can start with just one model (for the moment we can just use FLake - it's faster)? That is, not using FLake and MyLake, like I said in the below email. 

I am thinking of a simplest design:

    p: parameters (say p1 attenuation coefficient and p2 fetch)
    t: time
    d: depth
    T(t, d | p): temperature profile obtained with a model given p, function of t and d

we make arbitrarily a target temperature profile, say 

    p1 = 2
    p2 = 1000

then we obtain 

    T*(t, d), 

whole 2-d domain

now, the question (as your idea points to) is about finding the optimal set d' such that, when 

    || T*(t, d') - T(t, d' | p^hat) || 

is made smallest, p^hat actually is closer to p1 = 2 and p2 = 1000. 

The suggested present study is still a worthy test even using the same model and known parameters. At the end of the day it's about the extent of self-explanability FLake's parameter space has. 

If the above could be the Part 1, then Part 2 will be about either using multiple models, or using real observation, or on the regional context (we want fetch or BV parameters as a function of geography/climate, hypsographic curve, and surface area, for example p(geo, hyp, area)). Part 2 will then not assume any more that the model is perfect representation of reality. 
