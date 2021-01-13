# purled from ex06.Rmd

attach(specmap)
# statistics
O18_mean <- mean(O18)
O18_sd <- sd(O18)
O18_npts <- length(O18)
O18_semean <- O18_sd/sqrt(O18_npts)
print(c(O18_mean, O18_sd, O18_npts, O18_semean))

# confidence intervals
O18_upperCI <- O18_mean + 2*O18_semean
O18_lowerCI <- O18_mean - 2*O18_semean
print(c(O18_lowerCI, O18_mean, O18_upperCI))

# function for describing a variable
# usage:  descr(x), where x is the name of a variable
descr <- function(x) {
    x_mean <- mean(x); cat(" Mean=", x_mean, "\n")
    x_sd <- sd(x); cat(" StdDev=", x_sd, "\n")
    x_npts <- length(x); cat(" n=", x_npts, "\n")
    x_semean <- x_sd/sqrt(x_npts); cat("SE Mean=", x_semean, "\n")
    x_upperCI <- x_mean + 2*x_semean; cat(" Upper=", x_upperCI, "\n")
    x_lowerCI <- x_mean - 2*x_semean; cat(" Lower=", x_lowerCI, "\n")
    cat(" ", "\n")
    }

descr(O18)
descr(Insol)

# qqnorm plot with a line
qqnorm(O18)
qqline(O18)

# histogram and density plot for comparison
hist(O18, breaks=40, probability=T)
lines(density(O18))

# load the appropriate packages
library(sf)
library(RColorBrewer)
library(ggplot2)

# read the data file (if not already in the workspace)
csv_path <- "/Users/bartlein/Documents/geog495/data/csv/orsim.csv"
orsim <- read.csv(csv_path)

# read the shapefile (if not already in the workspace)
shapefile="/Users/bartlein/Documents/geog495/data/shp/orotl.shp"
orotl_sf <- st_read(shapefile)
plot(orotl_sf)

# attach the dataframe
attach(orsim)

# calculate Future - Present differences
orsim$TJanDiff <- orsim$TJan2x - orsim$TJan1x
orsim$PJanDiff <- orsim$PJan2x - orsim$PJan1x

## ggplot2 map of temperature
ggplot() +
    geom_sf(data = orotl_sf, fill="grey70", color="black") +
    geom_point(data = orsim, aes(x = Lon, y = Lat, color = TJanDiff), size = 5.0 ) +
    scale_fill_gradient2(low = "blue", mid= "white", high = "red", aesthetics = 'color',
            limits = c(-6, 6), breaks = seq(-6, 6, by = 2), guide = 'colorbar', name = "TJanDiff (C)") +
    labs(x = "Longitude", y = "Latitude", title = "Oregon Future Climate Simulations")

## ggplot2 map of precipitation
ggplot() +
    geom_sf(data = orotl_sf, fill="grey70", color="black") +
    geom_point(data = orsim, aes(x = Lon, y = Lat, color = PJanDiff), size = 5.0 ) +
    scale_fill_gradient2(low = "bisque4", mid= "white", high = "skyblue3", aesthetics = 'color',
           limits = c(-150, 150), breaks = seq(-150, 150, by = 50), guide = 'colorbar', name = "PJanDiff (mm)") +
    labs(x = "Longitude", y = "Latitude", title = "Oregon Future Climate Simulations")

# t-tests among groups with different variances
boxplot(TJan2x, TJan1x)
print(mean(TJan2x)-mean(TJan1x)) # the temperature difference
tt_TJan <- t.test(TJan2x, TJan1x)
tt_TJan

# two-tailed test
boxplot(PJan2x, PJan1x)
mean(PJan2x)-mean(PJan1x)
tt_PJan_1 <- t.test(PJan2x, PJan1x)
tt_PJan_1

# one-tailed test
boxplot(PJan2x, PJan1x)
mean(PJan2x)-mean(PJan1x)
tt_PJan_2 <- t.test(PJan2x, PJan1x, alternative="greater")
tt_PJan_2

attach(scanvote)
tapply(Yes, Country, descr)

# anova
aov1 <- aov(Yes ~ Country)
aov1
summary(aov1)

hov1 <- bartlett.test(Yes ~ Country)
hov1

plot(aov1)

