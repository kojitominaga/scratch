cat */*.md5 > md5sums
cat */ranges.csv | grep ,time, > timeranges.csv
cat */ranges.csv | grep ,0, > initidalhourranges.csv
cat */checkresult | grep error > filecouldnotopen
cat */ranges.csv | grep ,lat, > latranges.csv
cat */ranges.csv | grep ,lon, > lonranges.csv
