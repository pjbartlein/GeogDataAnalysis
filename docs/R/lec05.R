# purled from lec05.Rmd

# load(".Rdata")

attach(specmap)
plot(O18 ~ Insol, pch=16, cex=0.6)

cor(O18, Insol)

library(RColorBrewer)
library(classInt) # class-interval recoding library
plotvar <- Insol
nclr <- 8
plotclr <- brewer.pal(nclr,"PuOr")
plotclr <- plotclr[nclr:1] # reorder colors
class <- classIntervals(plotvar, nclr, style="quantile")
colcode <- findColours(class, plotclr)

plot(O18 ~ Age, ylim=c(2.5,-2.5), type="l")
points(O18 ~ Age, pch=16, col=colcode, cex=1.5)
detach(specmap)

attach(sumcr)
plot(WidthWS ~ CumLen, pch=as.integer(Reach), col=as.integer(HU))
legend(25, 2, c("Reach A", "Reach B", "Reach C"), pch=c(1,2,3), col=1)
legend(650, 2, c("Glide", "Pool", "Riffle"), pch=1, col=c(1,2,3))
detach(sumcr)

plot(orstationc$lon, orstationc$lat, type="n")
symbols(orstationc$lon, orstationc$lat, circles=orstationc$elev, inches=0.1, add=T)

library(lattice)
cloud(orstationc$elev ~ orstationc$lon*orstationc$lat)

library(scatterplot3d)
library(RColorBrewer)

# get colors for labeling the points
plotvar <- orstationc$pann # pick a variable to plot
nclr <- 8 # number of colors
plotclr <- brewer.pal(nclr,"PuBu") # get the colors
colornum <- cut(rank(plotvar), nclr, labels=FALSE)
colcode <- plotclr[colornum] # assign color

# scatter plot
plot.angle <- 45
scatterplot3d(orstationc$lon, orstationc$lat, plotvar, type="h", angle=plot.angle, color=colcode, pch=20, cex.symbols=2, 
  col.axis="gray", col.grid="gray")

library(maps)

# get points that define Oregon county outlines
or_map <- map("county", "oregon", xlim=c(-125,-114), ylim=c(42,47), plot=FALSE)

# get colors for labeling the points
plotvar <- orstationc$pann # pick a variable to plot
nclr <- 8 # number of colors
plotclr <- brewer.pal(nclr,"PuBu") # get the colors
colornum <- cut(rank(plotvar), nclr, labels=FALSE)
colcode <- plotclr[colornum] # assign color

# scatterplot and map
plot.angle <- 135
s3d <- scatterplot3d(orstationc$lon, orstationc$lat, plotvar, type="h", angle=plot.angle, color=colcode, 
            pch=20, cex.symbols=2, col.axis="gray", col.grid="gray")
s3d$points3d(or_map$x,or_map$y,rep(0,length(or_map$x)), type="l")

## library(rgl)
## example(rgl.surface)
## 
## rgl.clear()
## example(rgl.spheres)

library(lattice)
attach(scanvote)
coplot(Yes ~ log10(Pop) | Country, columns=3,
     panel=function(x,y,...) {
          panel.smooth(x,y,span=.8,iter=5,...)
          abline(lm(y ~ x), col="blue") } 
)

detach(scanvote)

attach(sumcr)
coplot(WidthWS ~ DepthWS | CumLen, pch=14+as.integer(Reach), cex=1.5,
     number=3, columns=3,
     panel=function(x,y,...) {
          panel.smooth(x,y,span=.8,iter=5,...)
          abline(lm(y ~ x), col="blue")
     }
)

detach(sumcr)

library(lattice)
attach(orstationc)

# make a factor variable indicating which longitude band a station falls in
Lon2 <- equal.count(lon,8,.5)
# plot the lattice plot
plot1 <- xyplot(pann ~ elev | Lon2,
    layout = c(4, 2),
    panel = function(x, y) {
        panel.grid(v=2)
        panel.xyplot(x, y)
        panel.loess(x, y, span = 1.0, degree = 1, family="symmetric")
        panel.abline(lm(y~x))
    },
    xlab = "Elevation (m)",
    ylab = "Annual Precipitation (mm)"
)
print(plot1, position=c(0,.375,1,1), more=T)

# add the shingles
print(plot(Lon2), position=c(.1,0.0,.9,.4))
detach(orstationc)

library(sf)
attach(yellpratio)

# simple map
# read and plot shapefiles
ynp_state_sf <- st_read("/Users/bartlein/Documents/geog495/data/shp/ynpstate.shp")
plot(st_geometry(ynp_state_sf))
ynprivers_sf <- st_read("/Users/bartlein/Documents/geog495/data/shp/ynprivers.shp")
plot(st_geometry(ynprivers_sf), add = TRUE)
ynplk_sf <- st_read("/Users/bartlein/Documents/geog495/data/shp/ynplk.shp")
plot(st_geometry(ynplk_sf), add = TRUE)
points(Lon, Lat, pch=3, cex=0.6)

# stars plot for precipitation ratios
col.red <- rep("red",length(orstationc[,1]))
stars(yellpratio[,4:15], locations=as.matrix(cbind(Lon, Lat)),
col.stars=col.red, len=0.2, lwd=1, key.loc=c(-111.5,42.5), labels=NULL, add=T)

# create some conditioning variables
Elevation <- equal.count(Elev,4,.25)
Latitude <- equal.count(Lat,2,.25)
Longitude <- equal.count(Lon,2,.25)

# January vs July Precipitation Ratios by Elevation
plot2 <- xyplot(APJan ~ APJul | Elevation,
    layout = c(2, 2),
    panel = function(x, y) {
        panel.grid(v=2)
        panel.xyplot(x, y)
        panel.loess(x, y, span = 1.0, degree = 1, family="symmetric")
        panel.abline(lm(y~x))
    },
    xlab = "APJul",
    ylab = "APJan")
print(plot2, position=c(0,.375,1,1), more=T)
print(plot(Elevation), position=c(.1,0.0,.9,.4))

# January vs July Precipitation Ratios by Latitude and Longitude
plot3 <- xyplot(APJan ~ APJul | Latitude*Longitude,
    layout = c(2, 2),
    panel = function(x, y) {
        panel.grid(v=2)
        panel.xyplot(x, y)
        panel.loess(x, y, span = .8, degree = 1, family="gaussian")
        panel.abline(lm(y~x))
    },
    xlab = "APJul",
    ylab = "APJan")
print(plot3)

# Parallel plot of precipitation ratios
plot4 <- parallelplot(~yellpratio[,4:15] | Elevation,
    layout = c(4, 1),
    ylab = "Precipitation Ratios")
print(plot4)

# Lattice plot of scatter plot matrices
plot5 <- splom(~cbind(APJan,APJul,Elev) | Latitude*Longitude)
print(plot5)

detach(yellpratio)

# load the ggplot2 package
library(ggplot2)

# multi-panel lattice plot
cirques_sf$Glaciated <- ifelse(cirques_sf$Glacier=="G",1,0)
cirques_sf$Unglaciated <- ifelse(cirques_sf$Glacier=="U",1,0)

ggplot() + 
  geom_sf(data = orotl_sf) +
  geom_point(aes(cirques_sf$Lon, cirques_sf$Lat), size = 2.0 , color = cirques_sf$Glaciated + 1) +
  labs(x = "Longitude", y = "Latitude") +
  theme_bw()

ggplot(cirques_sf) + 
  geom_sf(data = orotl_sf) +
  geom_point(aes(Lon, Lat), size = 1.0 , color = cirques_sf$Glaciated + 1) +
  facet_wrap(~Glacier) +
  labs(x = "Longitude", y = "Latitude") +
  theme_bw()

ggplot(cirques_sf) + 
  geom_sf(data = orotl_sf) +
  geom_point(aes(Lon, Lat), size = 1.0 , color = cirques_sf$Glaciated + 1) +
  facet_wrap(~Region) +
  labs(x = "Longitude", y = "Latitude") +
  theme_bw()

plot(st_geometry(orotl_sf))
points(cirques_sf$Lon, cirques_sf$Lat, col=3-as.integer(cirques_sf$Glacier))
legend(-118, 43.5, c("Glaciated","Unglaciated"), pch=c(1,1), col=c(2,1))
