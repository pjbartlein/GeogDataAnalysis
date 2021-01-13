# purled from ex04.Rmd

install.packages("classInt")

library(ggplot2)

options(CRAN = "http://cran.us.r-project.org/") # tell R where to look for packages

update.packages()

library(classInt)
library(ggplot2)
library(lattice)
library(RColorBrewer)
library(sf)

# read and attach the climate data
# assume the data file is in your working directory
csvfile <- "/Users/bartlein/Documents/geog495/data/csv/orstationc.csv"
orstationc <- read.csv(csvfile)
str(orstationc)
attach(orstationc)

# read a county outline shape file
shapefile <- "/Users/bartlein/Documents/geog495/data/shp/orotl.shp"
orotl_sf <- st_read(shapefile)
orotl_sf
plot(orotl_sf) # plot the outline
plot(st_geometry(orotl_sf), axes = TRUE)

# set variable and get colors
plotvals <- pjan # pick a variable to plot
plottitle <- "January Precipitation"
nclr <- 8 # number of colors
plotclr <- brewer.pal(nclr,"BuPu") # get nclr colors

# find equal-frequency intervals
class <- classIntervals(plotvals, nclr, style="quantile")
colcode <- findColours(class, plotclr)
cutpts <- round(class$brks, digits=1)

# plot the shape file and the selected variable
plot(st_geometry(orotl_sf), axes = TRUE)
points(lon, lat, pch=16, col=colcode, cex=2) # add points
points(lon, lat, cex=2) # draws black line around each point
legend(x=-117, y=43.5, legend=names(attr(colcode, "table")), # add legend
    fill=attr(colcode, "palette"), cex=1, bty="n")
title(plottitle) # add the title

# symbol plot -- fixed-interval class intervals
plotvals <- pann
title <- "Oregon Climate Station Data -- Annual Precipitation"
subtitle <- "Fixed-Interval Class Intervals"
nclr <- 5
plotclr <- brewer.pal(nclr+1,"BuPu")[2:(nclr+1)]

# get color codes
class <- classIntervals(plotvals, nclr, style="fixed",
                        fixedBreaks=c(0,200,500,1000,2000,9999))
colcode <- findColours(class, plotclr)

# plot
plot(st_geometry(orcounty_sf), xlim=c(-124.5, -115), ylim=c(42,47))
points(lon, lat, pch=16, col=colcode, cex=2)
points(lon, lat, cex=2)
title(main=title, sub=subtitle)
legend(-117, 43.5, legend=names(attr(colcode, "table")),
       fill=attr(colcode, "palette"), cex=1.0, bty="n")

# ggplot2
# convert the (continous) temperature values to a factor
cutpts <- c(-8, -6, -4, -2, 0, 2, 4, 6, 8, 9999)
tmp_factor <- factor(findInterval(orstationc$tjan, cutpts))
head(cbind(orstationc$tjan, tmp_factor, cutpts[tmp_factor]))

## ggplot2 map of temperature
library(ggplot2)
ggplot() +
  geom_sf(data = orotl_sf, fill="grey70", color="black") +
  geom_point(data = orstationc, aes(x = lon, y = lat, color = tmp_factor), size = 5.0 ) +
  scale_color_brewer(type = "div", palette = "RdBu", aesthetics = "color", direction = -1,
                     labels = c("-8 to -6", "-6 to -4", "-4 to -2", "-2 to 0", "0 to 2",
                                "2 to 4", "4 to 6", "6 to 8", "> 8"),
                     name = "Annual Temp (C)") +
  labs(x = "Longitude", y = "Latitude", title = "Oregon Climate Station Data") +
  theme_bw()

# detach orstation
detach(orstationc)

attach(orstationc)

coplot(tann ~ elev | lon * lat, number=5, overlap=.5,
    panel=function(x,y,...) {
        panel.smooth(x,y,span=.8,iter=5,...)
        abline(lm(y ~ x), col="blue")
    }
 )

pdf("coplot.pdf")
coplot(tann ~ elev | lon * lat, number=5, overlap=.5,
  panel=function(x,y,...) {
    points(x,y,...)
    abline(lm(y ~ x), col="blue")
  }
)
dev.off()

detach(orstationc)

csvfile <- "/Users/bartlein/Documents/geog495/data/csv/cirques.csv"
cirques <- read.csv(csvfile)
attach(cirques)
names(cirques)

cloud(Elev ~ Lon*Lat, pch=16, cex=1.25, col=unclass(as.factor(Glacier)))

Lat2 <- equal.count(Lat,4,.5)
Lon2 <- equal.count(Lon,4,.5)
plot(Lat2)
plot(Lon2)

# Cirque elevation as a function of longitude, given latitude
plot2 <- xyplot(Elev ~ Lon | Lat2,
    layout = c(4, 2),
    panel = function(x, y) {
        panel.grid(v=2)
        panel.xyplot(x, y)
        panel.loess(x, y, span = .8, degree = 1, family="gaussian")
        panel.abline(lm(y~x))
    },
    xlab = "Longitude",
    ylab = "Elevation (m)"
)
print(plot2)

# Lattice stripplot
plot4 <- stripplot(Glacier ~ Elev | Lat2*Lon2)
print(plot4)

# Lattice boxplot
plot5 <- bwplot(Glacier ~ Elev| Lat2*Lon2)
print(plot5)

