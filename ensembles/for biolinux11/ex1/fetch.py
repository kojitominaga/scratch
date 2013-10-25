"""fetch from ENSEMBLES RT3"""
import urllib

## testing with the ERA40 simulation
address1 = "http://ensemblesrt3.dmi.dk/data/ERA40/SMHI/50km/"
address2 = ["DM/"] * 9
address3 = "SMHIRCA_CTR_ERA40_DM_50km_1991-2000_"
address4 = ['tas', 'tasmin', 'tasmax', 'wss', 
            'rsds', 'rlds', 'ps', 'pr', 'huss']
address5 = ".nc.gz"

addresses = [''.join([address1, address2[i], address3, address4[i], address5])
             for i in range(len(address4))]

for a in addresses:
    print(a)
    urllib.urlretrieve(a, a.split('/')[-1])

    

