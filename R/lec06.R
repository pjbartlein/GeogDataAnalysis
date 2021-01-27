# purled from lec06.Rmd

load(".RData")

library(sp)
library(rgeos)
library(rgdal)

library(sf)

library(RColorBrewer)
library(ggplot2)
library(classInt)

# read a shapefile 
shapefile <- "/Users/bartlein/Documents/geog495/data/shp/wus.shp"
wus_sp <- readOGR(shapefile)
class(wus_sp)

wus_sf <- st_read(shapefile)
class(wus_sf)
head(wus_sf)

shapefile <- "/Users/bartlein/Documents/geog495/data/shp/orcounty.shp"
orcounty_sf <- st_read(shapefile)
names(orcounty_sf)

plot(orcounty_sf, max.plot=52) # plot the attributes
plot(st_geometry(orcounty_sf), axes = TRUE)

# equal-frequency class intervals -- chunk 1
plotvar = "POP1990"
plotvals <- orcounty_sf$POP1990
title <- "Population 1990"
subtitle <- "Quantile (Equal-Frequency) Class Intervals"
nclr <- 8
plotclr <- brewer.pal(nclr,"BuPu")
class <- classIntervals(plotvals, nclr, style="quantile")
colcode <- findColours(class, plotclr)

# chunk 2
plot(orcounty_sf[plotvar], col=colcode, xlim=c(-124.5, -115), ylim=c(42,47))
title(main=title, sub=subtitle)
legend("bottomright", legend=names(attr(colcode, "table")),
    fill=attr(colcode, "palette"), cex=1.0, bty="n")

# equal-interval class intervals -- chunk 1
plotvar = "POP1990"
plotvals <- orcounty_sf$POP1990
title <- "Population 1990"
subtitle <- "Equal-size Class Intervals"
nclr <- 8
plotclr <- brewer.pal(nclr,"BuPu")
class <- classIntervals(plotvals, nclr, style="equal")
colcode <- findColours(class, plotclr)

# chunk 2
plot(orcounty_sf[plotvar], col=colcode, xlim=c(-124.5, -115), ylim=c(42,47))
title(main=title, sub=subtitle)
legend("bottomright", legend=names(attr(colcode, "table")),
       fill=attr(colcode, "palette"), cex=1.0, bty="n")

pal <- brewer.pal(9, "Greens") #[3:6]
ggplot()  +
  geom_sf(data = orcounty_sf, aes(fill = POP1990)) +
  scale_fill_gradientn(colors = pal) +
  coord_sf() + theme_bw()

# symbol plot -- equal-interval class intervals
plotvals <- orstationc$tann
title <- "Oregon Climate Station Data -- Annual Temperature"
subtitle <- "Equal-Interval Class Intervals"
nclr <- 8
plotclr <- brewer.pal(nclr,"PuOr")
plotclr <- plotclr[nclr:1] # reorder colors
class <- classIntervals(plotvals, nclr, style="equal")
colcode <- findColours(class, plotclr)

plot(st_geometry(orcounty_sf), xlim=c(-124.5, -115), ylim=c(42,47))
points(orstationc$lon, orstationc$lat, pch=16, col=colcode, cex=2)
points(orstationc$lon, orstationc$lat, cex=2)
title(main=title, sub=subtitle)
legend(-117, 44, legend=names(attr(colcode, "table")),
    fill=attr(colcode, "palette"), cex=1.0, bty="n")

# symbol plot -- equal-interval class intervals
shapefile <- "/Users/bartlein/Documents/geog495/data/shp/orstations.shp"
orstations_sf <- st_read(shapefile)
plot(orstations_sf, max.plot=52) # plot the stations
plot(st_geometry(orstations_sf), axes = TRUE)

# symbol plot -- fixed-interval class intervals
plotvals <- orstations_sf$pann
title <- "Oregon Climate Station Data -- Annual Precipitation"
subtitle <- "Fixed-Interval Class Intervals"
nclr <- 5
plotclr <- brewer.pal(nclr+1,"BuPu")[2:(nclr+1)]
class <- classIntervals(plotvals, nclr, style="fixed",
  fixedBreaks=c(0,200,500,1000,2000,9999))
colcode <- findColours(class, plotclr)

# block 2
plot(st_geometry(orcounty_sf), xlim=c(-124.5, -115), ylim=c(42,47))
points(orstations_sf$lon, orstations_sf$lat, pch=16, col=colcode, cex=2)
points(orstations_sf$lon, orstations_sf$lat, cex=2)
title(main=title, sub=subtitle)
legend(-117, 44, legend=names(attr(colcode, "table")),
  fill=attr(colcode, "palette"), cex=1.0, bty="n")

cutpts <- c(0,200,500,1000,2000,9999)
plot_factor <- factor(findInterval(orstations_sf$pann, cutpts))
nclr <- 5
plotclr <- brewer.pal(nclr+1,"BuPu")[2:(nclr+1)]
ggplot() +
  geom_sf(data = orcounty_sf, fill=NA) +
  geom_point(aes(orstations_sf$lon, orstations_sf$lat, color = plot_factor), size = 5.0, pch=16) +
  geom_point(aes(orstations_sf$lon, orstations_sf$lat), size = 5.0, pch=1) +
  scale_colour_manual(values=plotclr, aesthetics = "colour",
                    labels = c("0 - 200", "200 - 500", "500 - 1000", "1000 - 2000", "> 2000"),
                     name = "Ann. Precip.", drop=TRUE) +
  labs(x = "Longitude", y = "Latitude") +
  theme_bw()

# bubble plot equal-frequency class intervals
orcounty_cntr <- (st_centroid(orcounty_sf))
ggplot()  +
  geom_sf(data = orcounty_sf) +
  geom_sf(data = orcounty_cntr, aes(size = POP1990), color="purple") + 
  scale_size_area(max_size = 15) +
  labs(x = "Longitude", y = "Latitude", title = "Area") +
  theme_bw()

library(maps)

wus_map <- map("state", regions=c("washington", "oregon", "california", "idaho", "nevada",
  "montana", "utah", "arizona", "wyoming", "colorado", "new mexico", "north dakota", "south dakota",
  "nebraska", "kansas", "oklahoma", "texas"), plot = FALSE, fill = FALSE)

class(wus_map)
str(wus_map)

plot(wus_map, pch=16, cex=0.5)

wus_sf <- st_as_sf(map("state", regions=c("washington", "oregon", "california", "idaho", "nevada",
    "montana", "utah", "arizona", "wyoming", "colorado", "new mexico", "north dakota", "south dakota",
    "nebraska", "kansas", "oklahoma", "texas"), plot = FALSE, fill = TRUE))

class(wus_sf)

plot(wus_sf)

plot(st_geometry(wus_sf))

head(wus_sf)

ggplot() + geom_sf(data = wus_sf) + theme_bw()

na_sf <- st_as_sf(map("world", regions=c("usa", "canada", "mexico"), plot = FALSE, fill = TRUE))
conus_sf <- st_as_sf(map("state", plot = FALSE, fill = TRUE))

na2_sf <- rbind(na_sf, conus_sf)

head(na2_sf)

ggplot() + geom_sf(data = na2_sf) + theme_bw()

shapefile <- "/Users/bartlein/Documents/geog495/data/csv/wus_pratio.csv"
wus_pratio <- read.csv(shapefile)
names(wus_pratio)

# get July to annual precipitation ratios
wus_pratio$pjulpjan <- wus_pratio$pjulpann/wus_pratio$pjanpann  # pann values cancel out
head(wus_pratio)

# convert the (continous) preciptation ratio to a factor
cutpts <- c(0.0, .100, .200, .500, .800, 1.0, 1.25, 2.0, 5.0, 10.0, 9999.0)
pjulpjan_factor <- factor(findInterval(wus_pratio$pjulpjan, cutpts))
head(cbind(wus_pratio$pjulpjan, pjulpjan_factor, cutpts[pjulpjan_factor]))

## ggplot2 map of pjulpjan
ggplot() +
  geom_sf(data = na2_sf, fill=NA, color="gray") +
  geom_sf(data = wus_sf, fill=NA, color="black") +
  geom_point(aes(wus_pratio$lon, wus_pratio$lat, color = pjulpjan_factor), size = 1.0 ) +
  scale_color_brewer(type = "div", palette = "PRGn", aesthetics = "color", direction = 1,
                     labels = c("0.0 - 0.1", "0.1 - 0.2", "0.2 - 0.5", "0.5 - 0.8", "0.8 - 1.0",
                                "1.0 - 1.25", "1.25 - 2.0", "2.0 - 5.0", "5.0 - 10.0", "> 10.0"),
                     name = "Jul:Jan Ppt. Ratio") +
  labs(x = "Longitude", y = "Latitude") +
  coord_sf(crs = st_crs(wus_sf), xlim = c(-125, -90), ylim = c(25, 50)) +
  theme_bw()

# projection of wus_sf
laea = st_crs("+proj=laea +lat_0=30 +lon_0=-110") # Lambert equal area
wus_sf_proj = st_transform(wus_sf, laea)

plot(st_geometry(wus_sf_proj), axes = TRUE)
plot(st_geometry(st_graticule(wus_sf_proj)), axes = TRUE, add = TRUE)

ggplot() + geom_sf(data = wus_sf_proj) + theme_bw()

# project the other outlines
na_sf_proj = st_transform(na_sf, laea)
conus_sf_proj = st_transform(conus_sf, laea)
na2_sf_proj = st_transform(na2_sf, laea)

class(wus_pratio)

wus_pratio_sf <- st_as_sf(wus_pratio, coords = c("lon", "lat"))

class(wus_pratio_sf)

wus_pratio_sf

# set crs
st_crs(wus_pratio_sf) <- st_crs("+proj=longlat")

st_crs(wus_pratio_sf)

# projection of wus_pratio_sf
laea = st_crs("+proj=laea +lat_0=30 +lon_0=-110") # Lambert equal area
wus_pratio_sf_proj = st_transform(wus_pratio_sf, laea)

# plot the projected points
plot(st_geometry(wus_pratio_sf_proj), pch=16, cex=0.5, axes = TRUE)
plot(st_geometry(st_graticule(wus_pratio_sf_proj)), axes = TRUE, add = TRUE)

# ggplot2 map of pjulpman projected
ggplot() +
  geom_sf(data = na2_sf_proj, fill=NA, color="gray") +
  geom_sf(data = wus_sf_proj, fill=NA) +
  geom_sf(data = wus_pratio_sf_proj, aes(color = pjulpjan_factor), size = 2.0 ) +
  scale_color_brewer(type = "div", palette = "PRGn", aesthetics = "color", direction = 1,
                     labels = c("0.0 - 0.1", "0.1 - 0.2", "0.2 - 0.5", "0.5 - 0.8", "0.8 - 1.0",
                                "1.0 - 1.25", "1.25 - 2.0", "2.0 - 5.0", "5.0 - 10.0", "> 10.0"),
                     name = "Jul:Jan Ppt. Ratio") +
                       labs(x = "Longitude", y = "Latitude") +
  coord_sf(crs = st_crs(wus_sf_proj), xlim = c(-1400000, 1500000), ylim = c(-400000, 2150000)) +
  theme_bw()
