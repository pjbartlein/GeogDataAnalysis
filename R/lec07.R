# purled from lec07.Rmd

# load packages
library(raster)
library(rasterVis)
library(RColorBrewer)
library(sf)

# read potential natural vegetation data sage_veg30.nc:
# modify the following path to reflect local files
vegtype_path <- "/Users/bartlein/Documents/geog495/data/nc_files/"
vegtype_name <- "sage_veg30.nc"
vegtype_file <- paste(vegtype_path, vegtype_name, sep="")
vegtype <- raster(vegtype_file, varname="vegtype")
vegtype

mapTheme <- rasterTheme(region=rev(brewer.pal(8,"Greens")))
levelplot(vegtype, margin=FALSE, par.settings=mapTheme,
                 main="Potential Natural Vegetation")

# read GCDv3 sites
# modify the following path to reflect local files
csv_path <- "/Users/bartlein/Documents/geog495/data/csv/"
csv_name <- "v3i_nsa_globe.csv"
csv_file <- paste(csv_path, csv_name, sep="")
gcdv3 <- read.csv(csv_file) 
str(gcdv3)
plot(gcdv3$Lon, gcdv3$Lat, pch=16, cex=0.5, col="blue")

# turn into an sf object
gcdv3_sf <- st_as_sf(gcdv3, coords = c("Lon", "Lat"))
class(gcdv3_sf)
gcdv3_sf

st_crs(gcdv3_sf) <- st_crs("+proj=longlat")
# gcdv3_pts <- as_Spatial(gcdv3_sf)

plt <- levelplot(vegtype, margin=FALSE, par.settings=mapTheme,
                 main="Potential Natural Vegetation")
plt + layer(sp.points(as_Spatial(gcdv3_sf), col="blue", pch=16, cex=0.5))

# extract data from the raster at the target points
gcdv3_vegtype <- extract(vegtype, gcdv3_sf, method="simple")
class(gcdv3_vegtype)
head(gcdv3_vegtype)

pts <- data.frame(gcdv3$Lon, gcdv3$Lat, gcdv3_vegtype)
names(pts) <- c("Lon", "Lat", "vegtype")
head(pts, 10)
plotclr <- rev(brewer.pal(8,"Greens"))
plotclr <- c("#AAAAAA", plotclr)
cutpts <- c(0, 2, 4, 6, 8, 10, 12, 14, 16)
color_class <- findInterval(gcdv3_vegtype, cutpts)
plot(pts$Lon, pts$Lat, col=plotclr[color_class+1], pch=16)

plt <- levelplot(vegtype, margin=FALSE, par.settings=mapTheme,
                 main="Potential Natural Vegetation")
plotclr <- rev(brewer.pal(8,"Greens"))

cutpts <- c(0, 2, 4, 6, 8, 10, 12, 14, 16)
color_class <- findInterval(gcdv3_vegtype, cutpts)
plt + layer(sp.points(as_Spatial(gcdv3_sf), col=plotclr[color_class], pch=16, cex=0.6)) + 
  layer(sp.points(as_Spatial(gcdv3_sf), col="black", pch=1, cex=0.6))

library(ncdf4)
library(lattice)
library(classInt)
library(RColorBrewer)

# set path and filename
# modify the following path to reflect local files
ncpath <- "/Users/bartlein/Documents/geog495/data/nc_files/"
ncname <- "cru10min30_bio.nc"  
ncfname <- paste(ncpath, ncname, sep="")
# open a netCDF file
ncin <- nc_open(ncfname)
print(ncin)
# get longitude and latitude
lon <- ncvar_get(ncin,"lon")
nlon <- dim(lon)
head(lon)
lat <- ncvar_get(ncin,"lat")
nlat <- dim(lat)
head(lat)
print(c(nlon,nlat))
# get the mtco data
mtco <- ncvar_get(ncin,"mtco")
dlname <- ncatt_get(ncin,"mtco","long_name")
dunits <- ncatt_get(ncin,"mtco","units")
fillvalue <- ncatt_get(ncin,"mtco","_FillValue")
dim(mtco)
mtco[mtco==fillvalue$value] <- NA

# close the netCDF file
nc_close(ncin)

# levelplot of the slice
grid <- expand.grid(lon=lon, lat=lat)
cutpts <- c(-50,-40,-30,-20,-10,0,10,20,30,40,50)
levelplot(mtco ~ lon * lat, data=grid, at=cutpts, cuts=11, pretty=TRUE, 
  col.regions=(rev(brewer.pal(10,"RdBu"))))

j <- sapply(gcdv3$Lon, function(x) which.min(abs(lon-x)))
k <- sapply(gcdv3$Lat, function(x) which.min(abs(lat-x)))
head(cbind(j,k)); tail(cbind(j,k))

mtco_vec <- as.vector(mtco)
jk <- (k-1)*nlon + j
gcdv3_mtco <- mtco_vec[jk]
head(cbind(j,k,jk,gcdv3_mtco,lon[j],lat[k]))

gcdv3_mtco[is.na(gcdv3_mtco)] <- -99
pts <- data.frame(gcdv3$Lon, gcdv3$Lat, gcdv3_mtco)
names(pts) <- c("Lon", "Lat", "mtco")
head(pts, 20)

plotclr <- rev(brewer.pal(10,"RdBu"))
plotclr <- c("#AAAAAA", plotclr)
cutpts <- c(-50,-40,-30,-20,-10,0,10,20,30,40,50)
color_class <- findInterval(gcdv3_mtco, cutpts)
plot(gcdv3$Lon, gcdv3$Lat, col=plotclr[color_class+1], pch=16)

# read the shape file for Picea Mariana
# modify the following path to reflect local files
shp_file <- "/Users/bartlein/Documents/geog495/data/shp/picemari.shp"
picea_sf <- st_read(shp_file)
picea_sf

plot(st_geometry(picea_sf))

# read the na10km_v2 points (as a .csv file)
csv_file <- "/Users/bartlein/Documents/geog495/data/csv/na10km_v2.csv"
na10km_v2 <- read.csv(csv_file)
str(na10km_v2)

na10km_v2 <- na10km_v2[na10km_v2$lon <= -45.0, ]
str(na10km_v2)

# make an sf object
na10km_v2_sf <- st_as_sf(na10km_v2, coords = c("lon", "lat"))
st_crs(na10km_v2_sf) <- st_crs("+proj=longlat")
na10km_v2_sf
plot(st_geometry(na10km_v2_sf), pch=16, cex=0.2) # takes a little while

# overlay the two
st_crs(picea_sf) <- st_crs(na10km_v2_sf) # make sure CRS's exactly match
picea_pts_sf <- st_join(na10km_v2_sf, picea_sf)
picea_pts_sf <- na.omit(picea_pts_sf)
picea_pts_sf

plot(st_geometry(na10km_v2_sf), pch=16, cex=0.2, axes=TRUE)
plot(st_geometry(picea_pts_sf), pch=16, cex=0.2, col="green", add=TRUE)

library(raster)
library(rasterVis)

# read the FPA-FOD fire-start data
# modify the following path to reflect local files
csv_path <- "/Users/bartlein/Dropbox/DataVis/working/data/csv_files/"
csv_name <- "fpafod_1992-2013.csv"
csv_file <- paste(csv_path, csv_name, sep="")
fpafod <- read.csv(csv_file) # takes a while
str(fpafod)

fpafod_coords <- cbind(fpafod$longitude, fpafod$latitude)
fpafod_pts <- SpatialPointsDataFrame(coords=fpafod_coords, data=data.frame(fpafod$area_ha))
names(fpafod_pts) <- "area_ha"

# create (empty) rasters
cell_size <- 0.5
lon_min <- -128.0; lon_max <- -65.0; lat_min <- 25.5; lat_max <- 50.5
ncols <- ((lon_max - lon_min)/cell_size)+1; nrows <- ((lat_max - lat_min)/cell_size)+1
us_fire_counts <- raster(nrows=nrows, ncols=ncols, xmn=lon_min, xmx=lon_max, ymn=lat_min, ymx=lat_max, res=0.5, crs="+proj=longlat +datum=WGS84")
us_fire_counts
us_fire_area <- raster(nrows=nrows, ncols=ncols, xmn=lon_min, xmx=lon_max, ymn=lat_min, ymx=lat_max, res=0.5, crs="+proj=longlat +datum=WGS84")
us_fire_area

# rasterize
us_fire_counts <- rasterize(fpafod_coords, us_fire_counts, fun="count")
us_fire_counts
plot(log10(us_fire_counts), col=brewer.pal(9,"BuPu"), sub="log10 Number of Fires")

us_fire_area <- rasterize(fpafod_pts, us_fire_area, fun=mean)
us_fire_area
plot(log10(us_fire_area$area_ha), col=brewer.pal(9,"YlOrRd"), sub="log10 Mean Area")

# make necessary vectors and arrays
lon <- seq(lon_min+0.25, lon_max-0.25, by=cell_size)
lat <- seq(lat_max-0.25, lat_min+0.25, by=-1*cell_size)
print(c(length(lon), length(lat)))

fillvalue <- 1e32
us_fire_counts2 <- t(as.matrix(us_fire_counts$layer, nrows=ncols, ncols=nrows))
dim(us_fire_counts2)
us_fire_counts2[is.na(us_fire_counts2)] <- fillvalue

us_fire_area2 <- t(as.matrix(us_fire_area$area_ha, nrows=ncols, ncols=nrows))
dim(us_fire_area2)
us_fire_area2[is.na(us_fire_area2)] <- fillvalue

# write out a netCDF file
library(ncdf4)

# path and file name, set dname
# modify the following path to reflect local files
ncpath <- "/Users/bartlein/Dropbox/DataVis/working/data/nc_files/"
ncname <- "us_fires.nc"
ncfname <- paste(ncpath, ncname, sep="")

# create and write the netCDF file -- ncdf4 version
# define dimensions
londim <- ncdim_def("lon","degrees_east",as.double(lon))
latdim <- ncdim_def("lat","degrees_north",as.double(lat))

# define variables

dname <- "fpafod_counts"
dlname <- "Number of fires, 1992-2013"
v1_def <- ncvar_def(dname,"1",list(londim,latdim),fillvalue,dlname,prec="single")
dname <- "fpafod_mean_area"
dlname <- "Average Fire Size, 1992-2013"
v2_def <- ncvar_def(dname,"ha",list(londim,latdim),fillvalue,dlname,prec="single")

# create netCDF file and put arrays
ncout <- nc_create(ncfname,list(v1_def, v2_def),force_v4=TRUE)

# put variables
ncvar_put(ncout,v1_def,us_fire_counts2)
ncvar_put(ncout,v2_def,us_fire_area2)

# put additional attributes into dimension and data variables
ncatt_put(ncout,"lon","axis","X")
ncatt_put(ncout,"lat","axis","Y")

# add global attributes
ncatt_put(ncout,0,"title","FPA-FOD Fires")
ncatt_put(ncout,0,"institution","USFS")
ncatt_put(ncout,0,"source","http://www.fs.usda.gov/rds/archive/Product/RDS-2013-0009.3/")
ncatt_put(ncout,0,"references", "Short, K.C., 2014, Earth Syst. Sci. Data, 6, 1-27")
history <- paste("P.J. Bartlein", date(), sep=", ")
ncatt_put(ncout,0,"history",history)
ncatt_put(ncout,0,"Conventions","CF-1.6")

# Get a summary of the created file:
ncout

# close the file, writing data to disk
nc_close(ncout)

# load the ncdf4 package
library(ncdf4)
library(lattice)
library(fields)

# set path and filename
# modify the following path to reflect local files
ncpath <- "/Users/bartlein/Dropbox/DataVis/working/data/nc_files/"
ncname <- "etopo1_ig_06min.nc"
ncfname <- paste(ncpath, ncname,  sep="")
dname <- "elev"

# open a netCDF file
ncin <- nc_open(ncfname)
print(ncin)

# get longitude and latitude
lon <- ncvar_get(ncin,"lon")
nlon <- dim(lon)
head(lon)
lat <- ncvar_get(ncin,"lat")
nlat <- dim(lat)
head(lat)
print(c(nlon,nlat))

# get elevations
etopo1_array <- ncvar_get(ncin,dname)
dlname <- ncatt_get(ncin,dname,"long_name")
dunits <- ncatt_get(ncin,dname,"units")
fillvalue <- ncatt_get(ncin,dname,"_FillValue")
dsource <- ncatt_get(ncin, "elev", "source")
dim(etopo1_array)

# get global attributes
title <- ncatt_get(ncin,0,"title")
institution <- ncatt_get(ncin,0,"institution")
datasource <- ncatt_get(ncin,0,"source")
history <- ncatt_get(ncin,0,"history")
Conventions <- ncatt_get(ncin,0,"Conventions")

# close the netCDF file
nc_close(ncin)

# levelplot of elevations
grid <- expand.grid(lon=lon, lat=lat)
cutpts <- c(-7000, -6000, -4000, -2000, 0, 500, 1000, 1500, 2000, 3000, 4000, 5000)
levelplot(etopo1_array ~ lon * lat, data=grid, at=cutpts, cuts=11, pretty=TRUE,
  col.regions=topo.colors(12))

# read na10km_v2 grid-point locations -- land-points only
# modify the following path to reflect local files
csv_path <- "/Users/bartlein/Dropbox/DataVis/working/data/csv_files/"
csv_name <- "na10km_v2_pts.csv"
csv_file <- paste(csv_path, csv_name, sep="")
na10km_v2 <- read.csv(csv_file)
str(na10km_v2)

# get number of target points
ntarg <- dim(na10km_v2)[1]
ntarg

# set dimesions of output array, and define "marginal" x- and y-values
nx <- 1078; ny <- 900
x <- seq(-5770000, 5000000, by=10000)
y <- seq(-4510000, 4480000, by=10000)

# define a vector and array that will contiain the interpolated values
interp_var <- rep(NA, ntarg)
interp_mat <- array(NA, dim=c(nx, ny))

# get array subscripts for each target point
j <- sapply(na10km_v2$x, function(c) which.min(abs(x-c)))
k <- sapply(na10km_v2$y, function(c) which.min(abs(y-c)))
head(cbind(j,k,na10km_v2$lon,na10km_v2$lat))
tail(cbind(j,k,na10km_v2$lon,na10km_v2$lat))

# bilinear interpolation from fields package
control_dat <- list(x=lon, y=lat, z=etopo1_array)
interp_var <- interp.surface(control_dat, cbind(na10km_v2$lon,na10km_v2$lat))

# put interpolated values into a 2-d array
interp_mat[cbind(j,k)] <- interp_var[1:ntarg]

grid <- expand.grid(x=x, y=y)
cutpts <- c(-7000, -6000, -4000, -2000, 0, 500, 1000, 1500, 2000, 3000, 4000, 5000)
levelplot(interp_mat ~ x * y, data=grid, at=cutpts, cuts=11, pretty=TRUE,
  col.regions=topo.colors(12))

# make a dataframe of the interpolated elevations
out_df <- data.frame(cbind(na10km_v2$x, na10km_v2$y, na10km_v2$lon, na10km_v2$lat, interp_var))
names(out_df) <- c("x", "y", "lon", "lat", "elev")
head(out_df); tail(out_df)

# ggplot or the interpolated data
library(ggplot2)
ggplot(data = out_df, aes(x = x, y = y)) + 
  geom_tile(aes(fill = interp_var)) + 
  scale_fill_gradientn(colors = terrain.colors(12)) + 
  theme_bw()

# make an sf object
NA_10km_v2_elev_sf <- st_as_sf(out_df, coords = c("x", "y"))
NA_10km_v2_elev_sf

# add (projected) CRS
st_crs(NA_10km_v2_elev_sf) <- 
  st_crs("+proj=laea +lon_0=-100 +lat_0=50 +x_0=0 +y_0=0 +ellps=WGS84 +datum=WGS84 +units=m +no_defs")
NA_10km_v2_elev_sf

# ggplot2 map
pal <- rev(brewer.pal(9, "Greys"))
ggplot(data = NA_10km_v2_elev_sf, aes(x = "lon", y = "lat")) + 
  geom_sf(aes(color = elev), size = .0001) + 
  scale_color_gradientn(colors = pal) +
  labs(x = "Longitude", y = "Latitude") +
  scale_x_discrete(breaks = seq(160, 360, by=10)) +
  scale_y_discrete(breaks = seq(0, 90, by=10)) +
  theme_bw()
