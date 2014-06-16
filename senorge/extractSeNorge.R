## Rscript extractSeNorge.R --args year

require(raster)
require(rgdal)
require(RSAGA)
require(sp)

myRAG <- function (file, return.header = TRUE, print = 0, nodata.values = c(), 
    at.once = TRUE, na.strings = "NA") 
{
    if (is.character(file)) {
        file = default.file.extension(file, ".asc")
        con = file(file, open = "r")
        on.exit(close(con), add = TRUE)
    }
    else {
        con = file
        if (!isOpen(file, "read")) 
            stop("'file' must be a file name or a connection opened for reading")
    }
    hdr = read.ascii.grid.header(con)
    if (at.once) {
        data = scan(con, quiet = TRUE, na.strings = na.strings)
        ## data = scan(con, nlines = hdr$nrows, quiet = TRUE, na.strings = na.strings)
        data = matrix(data, ncol = hdr$ncols, nrow = hdr$nrows, 
            byrow = TRUE)
        na = is.na(data) | (data == hdr$nodata_value)
        for (na.val in nodata.values) na = na | (data == na.val)
        if (any(na)) 
            data[na] = NA
    }
    else {
        data = matrix(NA, ncol = hdr$ncols, nrow = hdr$nrows)
        for (i in 1:hdr$nrows) {
            if (print == 2) 
                cat(i, " ", ifelse(round(i/20) == i/20, "\n", 
                  ""))
            if (print == 1) 
                if (round(i/100) == i/100) 
                  cat(i, " ", ifelse(round(i/1000) == i/1000, 
                    "\n", ""))
            x = scan(con, nlines = 1, quiet = TRUE, na.strings = na.strings)
            na = is.na(x) | (x == hdr$nodata_value)
            for (na.val in nodata.values) na = na | (x == na.val)
            if (any(na)) 
                x[na] = NA
            data[i, ] = x
        }
    }
    if (print == 2) 
        cat("\nDone!\n")
    if (print == 1) 
        cat("\n")
    if (return.header) 
        data = list(header = hdr, data = data)
    invisible(data)
}




year <- as.integer(commandArgs(trailingOnly = TRUE)[1])
cat('year is ') ; cat(sprintf('%s', year)) ; cat('\n')


dir <- sprintf('/work/users/kojito/senorge/gwb_ascii_%s', year)
dates <- seq(from=as.Date(sprintf('%s-01-01', year)),
             to=as.Date(ifelse(year == 2014,
               sprintf('%s-06-10', year),
               sprintf('%s-12-31', year))),
             by='day')

nbf.sub <- readOGR('catchments', 'nbf.sub')
nbf.sub.data <- slot(nbf.sub, 'data')

vars <- c('eva', 'frd', 'gwt', 'is', 'os', 'q', 'rr',
          'sd', 'smd', 'swe', 'tm')
## br (breen) not done because they don't exist in most of the catchments

out <- array(NA, dim=c(length(dates), length(vars), nrow(nbf.sub)))
dimnames(out) <- list(format(dates), vars, nbf.sub[['vatn_lnr']])
for (vi in 1:length(vars)) {
  var <- vars[vi]
  for (di in 1:length(dates)) {
    flag <- FALSE
    d <- dates[di]
    fn <- sprintf('%s/gwb_%s_%s.asc.gz', dir, var, format(d, '%Y_%m_%d'))
    if ((d == as.Date('2012-08-06')) & (var == 'swe')) {
      flag <- TRUE
    }
    if ((d == as.Date('2005-01-24')) & (var == 'eva')) {
      flag <- TRUE
    }
    if ((d == as.Date('2005-02-17')) & (var == 'eva')) {
      flag <- TRUE
    }
    if ((d == as.Date('2005-10-22')) & (var == 'frd')) {
      flag <- TRUE
    }
    if ((d == as.Date('2005-12-22')) & (var == 'frd')) {
      flag <- TRUE
    }
    if ((d == as.Date('2005-01-15')) & (var == 'gwt')) {
      flag <- TRUE
    }
    if ((d == as.Date('2005-06-18')) & (var == 'gwt')) {
      flag <- TRUE
    }
    if ((d == as.Date('2005-08-27')) & (var == 'gwt')) {
      flag <- TRUE
    }
    if ((d == as.Date('2005-12-11')) & (var == 'gwt')) {
      flag <- TRUE
    }
    if ((d == as.Date('2005-12-15')) & (var == 'gwt')) {
      flag <- TRUE
    }
    if ((d == as.Date('2005-06-23')) & (var == 'rr')) {
      flag <- TRUE
    }
    if ((d == as.Date('2005-02-06')) & (var == 'sd')) {
      flag <- TRUE
    }
    if ((d == as.Date('2005-02-26')) & (var == 'sd')) {
      flag <- TRUE
    }
    if ((d == as.Date('2005-10-26')) & (var == 'sd')) {
      flag <- TRUE
    }
    if ((d == as.Date('2005-12-22')) & (var == 'sd')) {
      flag <- TRUE
    }
    if ((d == as.Date('2005-03-23')) & (var == 'smd')) {
      flag <- TRUE
    }
    if ((d == as.Date('2005-04-14')) & (var == 'smd')) {
      flag <- TRUE
    }
    if ((d == as.Date('2005-05-10')) & (var == 'os')) {
      flag <- TRUE
    }
    if ((d == as.Date('2005-10-01')) & (var == 'is')) {
      flag <- TRUE
    }
    if ((d == as.Date('2005-09-24')) & (var == 'tm')) {
      flag <- TRUE
    }
    if (flag) {
      out[di, vi, ] <- NA
      next
    }
    cat(fn) ; cat('\n')
    if (file.exists(fn)) {
      f <- gzfile(fn, open='r')
      a <- myRAG(f)
      close(f)
      h <- a[['header']]
      ra <- raster(a[['data']],
                   xmn=h[['xllcorner']],
                   ymn=h[['yllcorner']],
                   xmx=(h[['xllcorner']] + h[['cellsize']] * h[['ncols']]),
                   ymx=(h[['yllcorner']] + h[['cellsize']] * h[['nrows']]),
                   crs=CRS("+proj=utm +zone=33 +datum=WGS84 +units=m +no_defs"))
      ex <- extract(ra, nbf.sub, small=TRUE, fun=mean, na.rm=TRUE)
      out[di, vi, ] <- ex
    } else {
      out[di, vi, ] <- NA
    }
  }
}
save(out, file=sprintf('%s.RData', year))


