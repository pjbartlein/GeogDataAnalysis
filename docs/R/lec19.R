options(width = 105)
knitr::opts_chunk$set(dev='png', dpi=300, cache=FALSE)
pdf.options(useDingbats = TRUE)
klippy::klippy(position = c('top', 'right'))
load(".Rdata")

# plot January vs. July precipitation ratios
opar <- par(mfcol=c(1,2))

# opaque symbols
plot(wus_pratio$pjanpann, wus_pratio$pjulpann, pch=16, cex=1.25, col=rgb(1,0,0))

# transparent symbols
plot(wus_pratio$pjanpann, wus_pratio$pjulpann, pch=16, cex=1.25, col=rgb(1,0,0, .2))
par <- opar

## # transparent symbols using the pdf() device
## pdf(file="highres_enhanced_plot01.pdf")
## plot(wus_pratio$pjanpann, wus_pratio$pjulpann, pch=16, cex=1.25, col=rgb(1,0,0, .2))
## dev.off()
## # transparent symbols using the pdf() device
## pdf(file="highres_enhanced_plot01.pdf")
## plot(wus_pratio$pjanpann, wus_pratio$pjulpann, pch=16, cex=1.25, col=rgb(1,0,0, .2))
## dev.off()

# stripcharts -- opaque symbols
opar <- par(mfcol=c(1,2))
stripchart(wus_pratio$pjanpann, xlab="PJan/Pann", method="overplot", pch=15, col=rgb(0,0,0))
stripchart(wus_pratio$pjanpann, xlab="PJan/Pann", method="stack", pch=15, col=rgb(0,0,0))
opar <- par

# stripcharts -- alpha-channel transparency
opar <- par(mfcol=c(1,2))
stripchart(wus_pratio$pjanpann, xlab="PJan/Pann", method="overplot", pch=15, col=rgb(0,0,0,0.1))
stripchart(wus_pratio$pjanpann, xlab="PJan/Pann", method="stack", pch=15, col=rgb(0,0,0,0.1))
par <- opar

# seasonal precipitation vs. elevation
opar <- par(mfcol=c(1,3))
plot(wus_pratio$elev, wus_pratio$pjanpann, pch=16, col=rgb(0,0,1, 0.1))
plot(wus_pratio$elev, wus_pratio$pjulpann, pch=16, col=rgb(0,0,1, 0.1))
plot(wus_pratio$elev, wus_pratio$pjulpjan, pch=16, col=rgb(0,0,1, 0.1))
par <- opar

# load packages
library(sf)
library(ggplot2)
library(tidyr)
library(GGally)
#library(gridExtra)

# read the data -- output suppressed
csvfile <- "c:/Users/bartlein/Documents/geog495/data/csv_files/global_fire.csv"
gf <- read.csv(csvfile)
str(gf)
summary(gf)

# reorder megabiomes -- output suppressed
megabiome_name <- c("TropF", "WarmF", "SavDWd", "GrsShrb", "Dsrt", "TempF", "BorF", "Tund", "None", "Ice")
gf$megabiome <- factor(gf$megabiome, levels=megabiome_name)

# reorder vegtypes
vegtype_name <- c("TrEFW","TrDFW","TeBEFW","TeNEFW","TeDFW","BrEFW","BrDFW","EDMFW",
                  "Savan","GrStp","ShrbD","ShrbO","Tund","Dsrt","PDRI")
gf$vegtype <- factor(gf$vegtype, levels=vegtype_name)

# check the new ordering of factor levels
str(gf[16:17])

# drop last two categories
mb2 <- c("TropF", "WarmF", "SavDWd", "GrsShrb", "Dsrt", "TempF", "BorF", "Tund")
gf <- gf[gf$megabiome %in% mb2, ]
table(gf$megabiome)

gf$hrmc <- sqrt(gf$hrmc)
min(log10(gf$gpw[gf$gpw > 0]))
gf$gpw <- log10(gf$gpw + 1e-10)
gf$map <- sqrt(gf$map)
gf$pme <- sqrt(gf$pme - min(gf$pme))
## # transformations (output suppressed)
## hist(gf$hrmc)
## gf$hrmc <- sqrt(gf$hrmc)
## hist(gf$hrmc)
## 
## hist(log10(gf$gpw[gf$gpw > 0]))
## min(log10(gf$gpw[gf$gpw > 0]))
## gf$gpw <- log10(gf$gpw + 1e-10)
## hist(gf$gpw)
## 
## hist(gf$map)
## gf$map <- sqrt(gf$map)
## hist(gf$map)
## 
## hist(gf$pme)
## gf$pme <- sqrt(gf$pme - min(gf$pme))
## hist(gf$pme)

## # read a world outlines shape file
## shp_path <- "/Users/bartlein/Documents/geog495/data/shp/"
## shp_name <- "ne_110m_admin_0_countries.shp"
## shp_file <- paste(shp_path, shp_name, sep="")
## world_sf <- read_sf(shp_file)
ggplot() +
  geom_sf(data = world_sf, fill="grey70", color="black") +
  scale_x_continuous(limits = c(-180, 180), breaks = seq(-180, 180, by=30)) +
  scale_y_continuous(limits = c(-90, 90), breaks = seq(-90, 90, by=30)) +
  labs(x = "Longitude", y =  "Latitude") +
  coord_sf(expand = FALSE) + 
  theme_bw()

## # parallel coordinate plot
## ggparcoord(data = gf[1:16],
##   scale = "uniminmax", alphaLines = 0.01) +
##   ylab("PCP of Global Fire Data") +
##   theme_bw() +
##   theme(axis.text.x  = element_text(angle=315, vjust=1.0, hjust=0.0, size=14),
##         axis.title.x = element_blank(),
##         axis.text.y = element_blank(), axis.ticks.y = element_blank() )
# parallel coordinate plot
pngfile <- "pcp01.png"
png(pngfile, width=600, height=600) # open the file
ggparcoord(data = gf[1:16],
  scale = "uniminmax", alphaLines = 0.01) + 
  ylab("PCP of Global Fire Data") +
  theme_bw() +
  theme(axis.text.x  = element_text(angle=315, vjust=1.0, hjust=0.0, size=14),
        axis.title.x = element_blank(), 
        axis.text.y = element_blank(), axis.ticks.y = element_blank() )
#dev.off()

# select those points with megabiome = "BorF"
gf$select_points <- rep(0, dim(gf)[1])
gf$select_points[gf$megabiome == "BorF"] <- 1
gf$select_points <- as.factor(gf$select_points)
table(gf$select_points)

## # pcp
## ggparcoord(data = gf[order(gf$select_points),],
## columns = c(1:16), groupColumn = "select_points",
## scale = "uniminmax", alphaLines=0.01) + ylab("")  +
## theme_bw() +
## theme(axis.text.x  = element_text(angle=315, vjust=1.0, hjust=0.0, size=14),
##       axis.title.x = element_blank(),
##       axis.text.y = element_blank(), axis.ticks.y = element_blank(),
##       legend.position = "none") +
## scale_color_manual(values = c(rgb(0, 0, 0, 0.2), "red"))

# pcp
pngfile <- "pcp02.png"
png(pngfile, width=600, height=600) # open the file
ggparcoord(data = gf[order(gf$select_points),],
columns = c(1:16), groupColumn = "select_points",
scale = "uniminmax", alphaLines=0.01) + ylab("")  +
theme_bw() + 
theme(axis.text.x  = element_text(angle=315, vjust=1.0, hjust=0.0, size=14),
      axis.title.x = element_blank(),
      axis.text.y = element_blank(), axis.ticks.y = element_blank(),
      legend.position = "none") +
scale_color_manual(values = c(rgb(0, 0, 0, 0.2), "red"))
#dev.off()

## # map
## ggplot()  +
##   geom_point(data = gf, aes(x = lon, y = lat, color = select_points), size = 0.8 ) +
##   geom_sf(data = world_sf, aes(geometry=geometry), fill=NA, color="black") +
##   theme_bw() +
##   theme(legend.position = "none") +
##   coord_sf() + scale_color_manual(values = c("gray80", "red"))
# map
pngfile <- "map02.png"
png(pngfile, width=600, height=300) # oppen the file

ggplot()  +
  geom_point(data = gf, aes(x = lon, y = lat, color = select_points), size = 0.8 ) +
  geom_sf(data = world_sf, aes(geometry=geometry), fill=NA, color="black") +
  theme_bw() + 
  theme(legend.position = "none") +
  coord_sf() + scale_color_manual(values = c("gray80", "red"))
#dev.off()

gf$select_points <- NULL

## library(rJava)
## library(iplots)

## con <- url("https://pjbartlein.github.io/GeogDataAnalysis/data/Rdata/geog495.RData")
## load(file=con)
## close(con)

## attach(wus_pratio)
## # simple scatter plot iplots version with transparency
## # use arrow keys to control transparency and symbol size
## iplot(elev,pjanpann, xlab="elev", ylab="pjanpann")
## detach(wus_pratio)

# linked interactive plots -- brushing
# example with Yellowstone region pratios iplots version
attach(yellpratio)
names(yellpratio)

## # parallel coordinate plot plus scatter plot map
## ipcp(yellpratio) # use arrow keys to control transparency
## iplot(Lon, Lat) # use arrow keys to control symbol size

detach(yellpratio)

# example with the higher-density western U.S. pratios
attach(wus_pratio) 

## # parallel coordiate plot plus scatter plot map
## ipcp(wus_pratio) # use arrow keys to control transparency
## iplot(lon, lat) # use arrow keys to control symbol size

detach(wus_pratio)

## # linked plots -- Summit Cr. data set, including categorical variables
## attach(sumcr)
## imosaic(data.frame(Reach,HU))
## ibar(HU)
## ibar(Reach)
## 
## # add a scatter plot
## iplot(CumLen, WidthWS)
## iplot.opt(col=unclass(Reach)+3)
## 
## # add a boxplot
## ibox(WidthWS, Reach)

## detach(sumcr)

# read the North American modern pollen data
csv_path <- "c:/Users/bartlein/Documents/geog495/data/csv_files/"
csv_name <- "NAmodpol.csv"
csv_file <- paste(csv_path, csv_name, sep="")
napol <- read.csv(csv_file) # takes a while
str(napol)

plot(st_geometry(world_sf), xlim=c(-180, -10), ylim=c(20, 80), axes=TRUE)
points(napol$Lat ~ napol$Lon, pch=16, cex=0.5, col="darkgreen")

library(tabplot)

## tableplot(napol, sortCol="Lat", scales="lin", fontsize = 8)
suppressWarnings(tableplot(napol, sortCol="Lat", scales="lin", fontsize = 8))

## tableplot(napol, sortCol="Lat", scales="lin", nBins=200, fontsize = 8)
suppressWarnings(tableplot(napol, sortCol="Lat", scales="lin", nBins=200, fontsize = 8))

## tableplot(napol, sortCol="Picea", scales="lin", nBins=100, , fontsize = 8)
suppressWarnings(tableplot(napol, sortCol="Picea", scales="lin", nBins=100, fontsize = 8))

## tableplot(napol, sortCol="Fed", scales="lin", nBins=100, fontsize = 8)
suppressWarnings(tableplot(napol, sortCol="Fed", scales="lin", nBins=100, fontsize = 8))

attach(gf)
tableplot(gf, sortCol="mat", scales="lin", fontsize = 8, pals=list("Set8", "Set8"))

tableplot(gf, sortCol="pme", scales="lin", fontsize = 8)

tableplot(gf, sortCol="gfed", scales="lin", fontsize = 8)

# read Carp L. pollen data (transformed to square-roots)
csvpath <- "c:/Users/bartlein/Documents/geog495/data/csv_files/"
csvname <- "carp96t.csv" # square-root transformed data
carp <- read.csv(paste(csvpath, csvname, sep=""))
summary(carp)

# transform 
tcarp <- carp
tcarp[4:25] <- sqrt(tcarp[4:25])
names(tcarp)

# cluster rearrangement
carp_heat <- heatmap(as.matrix(tcarp[4:25]), Rowv = NA, scale="none")
attributes(carp_heat)
carp_heat$colInd
sort_cols <- carp_heat$colInd + 3

# rearrange matrix
stcarp <- tcarp
names(stcarp)
stcarp[4:25] <- tcarp[sort_cols]
names(stcarp) <- c("Depth", "Age", "IS", names(tcarp)[sort_cols])
names(stcarp)

library(mvtsplot)
mvtsplot(stcarp[, 4:25], xtime=carp$Age, levels=9, margin=TRUE)

mvtsplot(stcarp[, 4:25], xtime=carp$Age, smooth.df=25, levels=9, margin=TRUE)

mvtsplot(stcarp[, 4:25], xtime=carp$Age, smooth.df=2, norm="internal", levels=9, margin=TRUE)

mvtsplot(stcarp[, 3:25], xtime=carp$Age, smooth.df=2, norm="internal", levels=9, margin=TRUE)

# load packages
library(ncdf4)
library(raster)
library(rasterVis)
library(maptools)
library(latticeExtra)
library(RColorBrewer)
library(cubeview)

# read TraCE21-ka transient climate-model simulation decadal data
tr21dec_path <- "c:/Users/bartlein/Documents/geog495/data/nc_files/"
tr21dec_name <- "Trace21_TREFHT_anm2.nc"
tr21dec_file <- paste(tr21dec_path, tr21dec_name, sep="")
tas_anm_ann <- brick(tr21dec_file, varname="tas_anm_ann", band=seq(1:2204))
tas_anm_ann <- rotate(tas_anm_ann)
tas_anm_ann

tas2 <- subset(tas_anm_ann, subset=seq(1,2201, by=10))

mapTheme <- rasterTheme(region=(rev(brewer.pal(10,"RdBu"))))
cutpts <- c(-40,-10,-5,-2,-1,0,1,2,5,10,20)
col <- rev(brewer.pal(10,"RdBu"))
plt <- levelplot(subset(tas2,1), at=cutpts, margin=FALSE, par.settings=mapTheme)
plt + latticeExtra::layer(sp.lines(as_Spatial(world_sf), col="black", lwd=1))

## cubeView(tas2, at=cutpts, col.regions=col)
