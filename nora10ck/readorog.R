require(sp)

nx = 248
ny = 400
## below x (lon, 248) moves faster than y (lat, 400)
lat = scan('data/NORA10_11km_lat.txt')
lon = scan('data/NORA10_11km_lon.txt')
orograw = scan('data/NORA10_11km_orog.txt')
x = rep(1:nx, times = ny)
y = rep(1:ny, each = nx)

llCRS <- CRS('+proj=longlat +ellps=WGS84 +datum=WGS84')

orogdf = data.frame(x, y, lat, lon, orograw)
coordinates(orogdf) <- c('lon', 'lat')
## promotes orodf to SpatialPointsDataFrame
proj4string(orogdf) <- llCRS




