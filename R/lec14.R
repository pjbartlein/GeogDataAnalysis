# purled from lec14.Rmd

library(RColorBrewer)
library(sf)

library(RColorBrewer)
library(sf)
attach(ortann)
names(ortann)

plot(elevation, tann, pch=16)

# lowess
plot(elevation, tann, pch=16, cex=0.6)
points(lowess(elevation, tann), pch=16, col="red", cex=0.5)
lines(lowess(elevation,tann), col="red", lwd=2)

# different smoothing
lines(lowess(elevation, tann, f=0.33), col="blue", lwd=2)
lines(lowess(elevation, tann, f=0.80), col="purple", lwd=2)
legend("bottomleft", title = "lowess() spans", legend=c("0.667","0.8","0.33"), lwd=2, cex=1, col=c("red","blue","purple"))

# loess -- first model
loess_model <- loess(tann ~ elevation)
loess_model

# second model, smoother curve
loess_model2 <- loess(tann ~ elevation, span=0.90, degree=2)
loess_model2

# plot the curves
plot(tann ~ elevation, pch=16, cex=0.6)
hat1 <- predict(loess_model)
lines(elevation[order(elevation)], hat1[order(elevation)], col="red", lwd=2)
hat2 <- predict(loess_model2)
lines(elevation[order(elevation)], hat2[order(elevation)], col="blue", lwd=2)
legend("bottomleft", title = "loess() model", legend=c("span=0.667, deg=1","span=0.9, deg=2"), lwd=2, cex=1, col=c("red","blue"))

# tann as a function of latitude and longitude (and interaction)
tann_loess <- loess(tann ~ longitude + latitude, span=0.3)
summary(tann_loess)

# poor man's R-squared value
cor(tann, tann_loess$fitted)^2

# create an interpolation target grid to display predicted values
grid_longitude <- seq(-124.5000, -116.8333, .1667)
grid_latitude <- seq(42.0000, 46.1667, .0833)
grid_mar <- list(longitude=grid_longitude, latitude=grid_latitude)

# get the fitted (interpolated) values
tann_interp <- predict(tann_loess, expand.grid(grid_mar))
tann_z <- matrix(tann_interp, length(grid_longitude),
length(grid_latitude))

# plot the interpolated values as shaded rectangles and contours
nclr <- 8
plotclr <- brewer.pal(nclr, "PuOr")
plotclr <- plotclr[nclr:1] # reorder colors

plot(st_geometry(orotl_sf), axes=TRUE)
image(grid_longitude, grid_latitude, tann_z, col=plotclr, add=T)
contour(grid_longitude, grid_latitude, tann_z, add=TRUE)
points(longitude, latitude)
plot(st_geometry(orotl_sf), add=T)

# first-order polynomial (i.e. a straight line)
linear_model <- lm(tann ~ elevation)
linear_model

# second order polynomial
poly2_model <- lm(tann ~ elevation+ I(elevation^2))
poly2_model
poly2_hat <- predict(poly2_model)

spline_model <- smooth.spline(elevation, tann)
spline_model

plot(tann ~ elevation, pch=16, cex=0.6)
abline(linear_model, col="red", lwd=2)
lines(elevation[order(elevation)], poly2_hat[order(elevation)],
     col="blue", lwd=2)
lines(spline_model, col="purple", lwd=2)
legend("bottomleft", title = "smoothers", legend=c("linear","polynomial","spline"), lwd=2, cex=1, col=c("red","blue","purple"))

