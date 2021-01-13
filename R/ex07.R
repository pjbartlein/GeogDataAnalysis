# purled from ex07.Rmd

# load the appropriate packages
library(sf)
library(RColorBrewer)
library(ggplot2)

# read the shapefile (if not already in the workspace)
shapefile="/Users/bartlein/Documents/geog495/data/shp/orotl.shp"
orotl_sf <- st_read(shapefile)
plot(orotl_sf)
# read the data file (if not already in the workspace)
csv_path <- "/Users/bartlein/Documents/geog495/data/csv/ortann.csv"
ortann <- read.csv(csv_path)

attach(ortann)
plot(ortann[,2:5])

map_temp <- function(title, varname, plotvar, limits) {
  ggplot() +
    geom_sf(data = orotl_sf, fill="grey70", color="black") +
    geom_point(data = ortann, aes(x = longitude, y = latitude, color = plotvar), size = 5.0 ) +
    scale_color_distiller(type = "div", palette = "RdBu", aesthetics = "color", direction = -1,
                          limits = limits, name = varname) +
    labs(x = "Longitude", y = "Latitude", title = title) +
    theme_bw()
}

# map the annual tempeature values
title <- "Oregon Climate Station Data -- Annual Temperature"
varname <- "Annual Temp. (C)"
plotvar <- tann
limits <- c(-15, 15)
map_temp(title, varname, plotvar, limits)

# a null model, mean as the prediction
tann_lm0 <- lm(tann ~ 1)

# plot the regression line
plot(tann ~ elevation)
abline(abline(mean(tann),0))

# examine the model object
summary(tann_lm0)

# standard regression diagnostics (4-up)
oldpar <- par(mfrow = c(2, 2))
plot(tann_lm0, which=c(1,2,4))
par(oldpar)

# map the residuals
title <- "Residuals from tann_lm0 (C)"	
varname <- "tann_lm0$residuals"
plotvar <- tann_lm0$residuals
limits <- max(abs(tann_lm0$residuals)) * c(-1, 1)
map_temp(title, varname, plotvar, limits)

# first regression model -- tann ~ elev
tann_lm1 <- lm(tann ~ elevation)

# plot the regression line
plot(tann ~ elevation)
abline(tann_lm1, col="blue")

# examine the model object
summary(tann_lm1)

# standard regression diagnostics (4-up)
oldpar <- par(mfrow = c(2, 2))
plot(tann_lm1, which=c(1,2,4,5))
par(oldpar)

# another view of the residual scatter diagram
plot(tann_lm1$fitted.values, tann_lm1$residuals)
lines(lowess(tann_lm1$fitted.values, tann_lm1$residuals, f=0.80), col="red")

# map the residuals
title <- "Residuals from tann_lm1 (C)"	
varname <- "tann_lm1$residuals"
plotvar <- tann_lm1$residuals
limits <- max(abs(tann_lm0$residuals)) * c(-1, 1)
map_temp(title, varname, plotvar, limits)

# plot residuals vs. other predictors
plot(tann_lm1$residuals ~ longitude)
lines(lowess(tann_lm1$residuals ~ longitude, f=0.80), col="red")

plot(tann_lm1$residuals ~ latitude)
lines(lowess(tann_lm1$residuals ~ latitude, f=0.80), col="red")

# second regression -- tann ~ elevation + latitude + longitude
tann_lm2 <- lm(tann ~ elevation + latitude + longitude)

# loess -- simplest model
tann_lo1 <- loess(tann ~ elevation, span=0.80, degree=2)

# examine the fit
summary(tann_lo1)
plot(tann ~ elevation)
hat <- predict(tann_lo1)
lines(elevation[order(elevation)], hat[order(elevation)], col="red")
cor(tann, hat)^2

# residual scatter diagram
plot(tann_lo1$fitted, tann_lo1$residuals)
lines(lowess(tann_lo1$fitted, tann_lo1$residuals, f=0.80), col="red")

# normal probablility plot
qqnorm(tann_lo1$residuals)

# map the residuals
title <- "Residuals from tann_lo1 (C)"	
varname <- "tann_lo1$residuals"
plotvar <- tann_lo1$residuals
limits <- max(abs(tann_lo1$residuals)) * c(-1, 1)
map_temp(title, varname, plotvar, limits)

# loess -- elevation, latitude, and longitude
tann_lo2 <- loess(tann ~ elevation + latitude + longitude, span=0.80, degree=2)

# examine the fit
summary(tann_lo2)
hat <- predict(tann_lo2)
cor(tann, hat)^2

# residual scatter diagram
plot(tann_lo2$fitted, tann_lo2$residuals)
lines(lowess(tann_lo2$fitted, tann_lo2$residuals, f=0.80), col="red")

# normal probablility plot
qqnorm(tann_lo2$residuals)

