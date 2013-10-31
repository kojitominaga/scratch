import numpy as np

lat = np.loadtxt('lat.txt')
lat2 = lat.reshape((95 * 85, ))
lon = np.loadtxt('lon.txt')
lon2 = lon.reshape((95 * 85, ))

x = range(95) # direction north
y = range(85) # direction east

x2 = x * len(y)
y2 = [elem for elem in y for _ in range(len(x))]

names = ['%03d-%03d' % (x2[i], y2[i]) for i in range(len(x2))]

outlist = ['"%s","%.18f,%.18f"\n' % (names[i], lat2[i], lon2[i])
           for i in range(len(names))]

f = open('latlonflat.csv', 'w')
f.writelines(outlist)
f.close()


