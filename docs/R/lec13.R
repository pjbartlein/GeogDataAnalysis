# purled from Lec13.Rmd

# regrex3
attach(regrex3)
summary(regrex3)
head(cbind(y5,x1,x2))

# create the column vector y
n <- length(y5)
y <- matrix(y5, nrow=n, ncol=1)
dim(y)
head(y)

# create the predictor-variable matrix
X <- matrix(cbind(rep(1,n),x1,x2), nrow=n, ncol=3)
dim(X)
head(X)

# calculate the regression coefficients
b <- solve(t(X) %*% X) %*% (t(X) %*% y)
print(b)
dim(b)

# linear model with lm()
lm1 <- lm(y5 ~ x1+x2, data=regrex3)
lm1

# matrix fitted values
yhat <- X %*% b

head(cbind(yhat,lm1$fitted.values))

# regrex3
summary(regrex3)
# matrix plot of the data
plot(regrex3[,2:8])

# set up for plotting
oldpar <- par(mfrow = c(2, 2))

# first regression
regr_y1x1 <- lm(y1 ~ x1, data=regrex3)
summary(regr_y1x1)
oldpar <- par(mfrow = c(2, 2))
plot(regr_y1x1, which=c(1,2,4,5), main="First Regression")

# add a second predictor
regr_y1x1x2 <- lm(y1 ~ x1 + x2, data=regrex3)
summary(regr_y1x1x2)
oldpar <- par(mfrow = c(2, 2))
plot(regr_y1x1x2, which=c(1,2,4,5), main="Two Predictors")

# outliers
regr_y2x1 <- lm(y2 ~ x1, data=regrex3)
summary(regr_y2x1)
oldpar <- par(mfrow = c(2, 2))
plot(regr_y2x1, which=c(1,2,4,5), main="Outliers")

# no help for outliers
regr_y2x1x2 <- lm(y2 ~ x1 + x2, data=regrex3)
summary(regr_y2x1x2)
oldpar <- par(mfrow = c(2, 2))
plot(regr_y2x1x2, which=c(1,2,4,5), main="Still Outliers")

# heteroscedasticity
regr_y3x1 <- lm(y3 ~ x1, data=regrex3)
summary(regr_y3x1)
oldpar <- par(mfrow = c(2, 2))
plot(regr_y3x1, which=c(1,2,4,5), main="Heteroscedasticity")

# nonlinear relationship
regr_y4x1 <- lm(y4 ~ x1, data=regrex3)
summary(regr_y4x1)
oldpar <- par(mfrow = c(2, 2))
plot(regr_y4x1, which=c(1,2,4,5), main="Nonlinear Relationship")

# alternative nonlinear log(y4) ~ x1
regr_logy4x1 <- lm(log10(y4-min(y4) + 0.001) ~ x1, data=regrex3)
summary(regr_logy4x1)
oldpar <- par(mfrow = c(2, 2))
plot(regr_logy4x1, which=c(1,2,4,5), main="Transformation of y")

# alternative nonlinear (quadratic) y4 ~ x1, x1^2
regr_y4x1x1 <- lm(y4 ~ x1 +I(x1^2), data=regrex3)
summary(regr_y4x1x1)
oldpar <- par(mfrow = c(2, 2))
plot(regr_y4x1x1, which=c(1,2,4,5), main="Quadratic Polynomial")

# model inadequacy, missing predictor
regr_y5x1 <- lm(y5 ~ x1, data=regrex3)
summary(regr_y5x1)
oldpar <- par(mfrow = c(2, 2))
plot(regr_y5x1, which=c(1,2,4,5), main="Missing Predictor")

# check for correlation between residuals and other predictors
par(oldpar)
plot(regr_y5x1$residual ~ regrex3$x2)

# last model, y5 ~ x1 and x2
regr_y5x1x2 <- lm(y5 ~ x1+x2, data=regrex3)
summary(regr_y5x1x2)
oldpar <- par(mfrow = c(2, 2))
plot(regr_y5x1x2, which=c(1,2,4,5), main="Two Predictors")

par(oldpar)

library(sf)
library(ggplot2)
library(RColorBrewer)
library(spdep)
library(leaps)
library(ggplot2)

## # libraries
## library(sf)
## library(ggplot2)
## library(RColorBrewer)
## library(spdep)
## library(leaps)
## library(ggplot2)

# read a state outline shape file
shapefile <- "/Users/bartlein/Documents/geog495/data/shp/midwotl.shp"
midwotl_sf <- st_read(shapefile)
midwotl_sf
plot(midwotl_sf) # plot the outline
plot(st_geometry(midwotl_sf), axes = TRUE)

## # read the data file (if not already in the workspace)
## csv_path <- "/Users/bartlein/Documents/geog495/data/csv/midwtf2"
## midwtf2 <- read.csv(csv_path)

attach(midwtf2)
names(midwtf2)

# get point locations of modern data
midwtf2_loc=cbind(longitud, latitude)

# distance neighbors
d <- 100 # points are neighbors if locations are within d km of one another
midwtf2_neighbors_dist <- dnearneigh(midwtf2_loc, 0, d, longlat=TRUE) 
plot(st_geometry(midwotl_sf), axes=TRUE)
points(midwtf2_loc)
plot(midwtf2_neighbors_dist, midwtf2_loc, add=TRUE, col="magenta")

# examine the data set
# plot lat, lon and climate variables
plot(midwtf2[,2:6])

# plot July temperature and selected pollen types
plot(midwtf2[,c(4,7,10,13,21)])

# plot July temperature and transformed pollen 
plot(midwtf2[,c(4,22,25,28,36)])

# ggplot2 map of temperature
plotvar <- tmeanjul
plotvar <- plotvar-mean(plotvar)
plottitle <- "Modern Climate (mean subtracted)"
leglable <- "tmeanjul (C)"
ggplot() +
  geom_sf(data = midwotl_sf, fill="grey70", color="black") +
  geom_point(data = midwtf2, aes(x = longitud, y = latitude, color = plotvar), size = 3) +
  scale_fill_gradient2(low = "blue", mid= "white", high = "red", aesthetics = 'color',
                       limits = c(-5, 5), breaks = seq(-5, 5, by = 1), guide = 'colorbar', name = leglable) +
  labs(x = "Longitude", y = "Latitude", title = plottitle) 

# spatial autocorrelation of dependent variable (tmeanjul)
moran.test(tmeanjul, zero.policy=T, 
     nb2listw(midwtf2_neighbors_dist, zero.policy=T, style="W"))

# naive model
tmeanjul_lm0 <- lm(tmeanjul ~ Picea + Abies + Juniper
   + Pinus + Betula + Fraxinus + Quercus + Ulmus
   + Acer + Juglans + Carya + Tsuga + Fagus
   + Alnus + Herbsum)

summary(tmeanjul_lm0)
oldpar <- par(mfrow = c(2, 2))
plot(tmeanjul_lm0, which=c(1,2,4,5))
par(oldpar)

# ggplot2 map of residuals
plotvar <- residuals(tmeanjul_lm0)
plotvar <- plotvar-mean(plotvar)
plottitle <- "Naive model residuals (C)"
leglable <- "residuals tmeanjul_lm0"
ggplot() +
  geom_sf(data = midwotl_sf, fill="grey70", color="black") +
  geom_point(data = midwtf2, aes(x = longitud, y = latitude, color = plotvar), size = 3) +
  scale_fill_gradient2(low = "blue", mid= "white", high = "red", aesthetics = 'color',
                       limits = c(-3, 3), breaks = seq(-3, 3, by = 1), guide = 'colorbar', name = leglable) +
  labs(x = "Longitude", y = "Latitude", title = plottitle) 

# Moran test
moran.test(residuals(tmeanjul_lm0), zero.policy=T, 
     nb2listw(midwtf2_neighbors_dist, zero.policy=T, style="W"))

kappa(tmeanjul_lm0)

# a second model, transformed predictors
tmeanjul_lm1 <- lm(tmeanjul ~ Picea.50 + Abies.100 + Junip.100
    + Pinus.100 + Betula.50 + Frax.15 + Querc.25 + Ulmus.25
    + Acer.100 + Juglans.25 + Carya.25 + Tsuga.100 + Fagus.100
    + Alnus.100 + Herbs.25)

summary(tmeanjul_lm1)
oldpar <- par(mfrow = c(2, 2))
plot(tmeanjul_lm1, which=c(1,2,4,5))
par(oldpar)

# ggplot2 map of residuals
plotvar <- residuals(tmeanjul_lm1)
plotvar <- plotvar-mean(plotvar)
plottitle <- "Second model residuals (C)"
leglable <- "residuals tmeanjul_lm1"
ggplot() +
  geom_sf(data = midwotl_sf, fill="grey70", color="black") +
  geom_point(data = midwtf2, aes(x = longitud, y = latitude, color = plotvar), size = 3) +
  scale_fill_gradient2(low = "blue", mid= "white", high = "red", aesthetics = 'color',
                       limits = c(-3, 3), breaks = seq(-3, 3, by = 1), guide = 'colorbar', name = leglable) +
  labs(x = "Longitude", y = "Latitude", title = plottitle) 

# Moran test
moran.test(residuals(tmeanjul_lm1), zero.policy=T, 
     nb2listw(midwtf2_neighbors_dist, zero.policy=T, style="W"))

kappa(tmeanjul_lm1)

# another model, all possible subsets regression
tmeanjul_lm2 <- regsubsets(tmeanjul ~ Picea.50 + Abies.100 + Junip.100
    + Pinus.100 + Betula.50 + Frax.15 + Querc.25 + Ulmus.25
    + Acer.100 + Juglans.25 + Carya.25 + Tsuga.100 + Fagus.100
    + Alnus.100 + Herbs.25, data=midwtf2)
summary(tmeanjul_lm2)

# rerun one of the best-subsets regressions
tmeanjul_lm3 <- lm(tmeanjul ~ Picea.50 + Abies.100 + Betula.50 + Fraxinus
     + Querc.25 + Fagus.100 + Herbs.25)

summary(tmeanjul_lm3)
oldpar <- par(mfrow = c(2, 2))
plot(tmeanjul_lm1, which=c(1,2,4,5))
par(oldpar)

# ggplot2 map of residuals
plotvar <- residuals(tmeanjul_lm3)
plotvar <- plotvar-mean(plotvar)
plottitle <- "All-possible subsets model residuals (C)"
leglable <- "residuals tmeanjul_lm3"
ggplot() +
  geom_sf(data = midwotl_sf, fill="grey70", color="black") +
  geom_point(data = midwtf2, aes(x = longitud, y = latitude, color = plotvar), size = 3) +
  scale_fill_gradient2(low = "blue", mid= "white", high = "red", aesthetics = 'color',
                       limits = c(-3, 3), breaks = seq(-3, 3, by = 1), guide = 'colorbar', name = leglable) +
  labs(x = "Longitude", y = "Latitude", title = plottitle) 

# Moran test
moran.test(residuals(tmeanjul_lm3), zero.policy=T,
    nb2listw(midwtf2_neighbors_dist, zero.policy=T, style="W"))

kappa(tmeanjul_lm3)

# compare Moran tests
# dependent variable (tmeanjul)
moran.test(tmeanjul, zero.policy=T, 
     nb2listw(midwtf2_neighbors_dist, zero.policy=T, style="W"))
# lm0 (naive model) no transformation, all predictors included
moran.test(residuals(tmeanjul_lm0), zero.policy=T,
    nb2listw(midwtf2_neighbors_dist, zero.policy=T, style="W"))
# lm1 transformed predictors, all predictors included
moran.test(residuals(tmeanjul_lm1), zero.policy=T,
    nb2listw(midwtf2_neighbors_dist, zero.policy=T, style="W"))
# lm3 transformed predictors, best subset model
moran.test(residuals(tmeanjul_lm3), zero.policy=T,
    nb2listw(midwtf2_neighbors_dist, zero.policy=T, style="W"))

library(sf)
library(ggplot2)
library(RColorBrewer)

library(sf)
library(ggplot2)
library(RColorBrewer)

# read a Scandinavian province/county shape file
shapefile <- "/Users/bartlein/Documents/geog495/data/shp/scand_prov.shp"
scand_prov_sf <- st_read(shapefile)
scand_prov_sf
plot(st_geometry(scand_prov_sf), axes = TRUE)

# get coordinates of district centroids
scand_prov_pts <- (st_centroid(scand_prov_sf))

# ggplot2 map of District names
ggplot() +
  geom_sf(data = scand_prov_sf, fill=NA, color="gray") +
  geom_sf_text(data = scand_prov_pts, aes(geometry=geometry, label=as.character(District)), size = 2) +
  coord_sf(xlim=c(2.5,32.5)) +
  labs(x="Longitude", y="Latitude") +
  theme_bw()

# get variable values from .dbf attributes
Y <- scand_prov_sf$Yes
X <- scand_prov_sf$Pop
Country <- scand_prov_sf$Country

# plot Yes votes -- setup
pal <- brewer.pal(8, "PuOr") 
ggplot()  +
  geom_sf(data = scand_prov_sf, aes(fill = Yes)) +
  geom_sf_text(data = scand_prov_pts, aes(geometry=geometry, label=as.character(Yes)), size = 2) +
  scale_fill_gradientn(colors = pal) +
  labs(title = "Yes Vote (%)", x="Longitude", y="Latitude")

# scatter plot with Country labels
plot(Y ~ log10(X), type="n")
text(log10(X),Y, labels=Country, cex=0.8)

# linear model, Yes ~ log10(Pop)
vote_lm1 <- lm(Y ~ log10(X))
summary(vote_lm1)
oldpar <- par(mfrow = c(2, 2))
plot(vote_lm1, which=c(1,2,4,5))
par(oldpar)

# examine the regression equation
plot(Y ~ log10(X), type="n")
text(log10(X),Y, labels=Country)
abline(vote_lm1)
segments(log10(X), fitted(vote_lm1), log10(X), Y)

# confidence intervals
pred_data <- data.frame(X=seq(1,1151,by=50))
pred_int <- predict(vote_lm1, int="p", newdata=pred_data)
conf_int <- predict(vote_lm1, int="c", newdata=pred_data)

plot(Y ~ log10(X), ylim=range(Y, pred_int, na.rm=T), type="n")
text(log10(X),Y, labels=Country, cex=0.7)
pred_X <- log10(pred_data$X)
matlines(pred_X, pred_int, lty=c(1,2,2), col="black")
matlines(pred_X, conf_int, lty=c(1,2,2), col="red")

# map the residuals
pal <- brewer.pal(8, "PuOr") 
plotlab <- as.character(round(vote_lm1$residuals, 1))
plottitle <- "Residuals from lm1"
ggplot()  +
  geom_sf(data = scand_prov_sf, aes(fill = vote_lm1$residuals)) +
  geom_sf_text(data = scand_prov_pts, aes(geometry=geometry, label=plotlab), size = 2) +
  scale_fill_gradientn(colors = pal, limits = c(-20, 20), breaks = seq(-20, 20, by = 5)) +
  labs(title = plottitle, x="Longitude", y="Latitude") 

opar <- par(mfrow=c(1,4))
# country-effect
boxplot(Y ~ Country, ylab="Yes")

# residual grouped boxplot
boxplot(residuals(vote_lm1) ~ Country, ylim=c(-15,15))
par <- opar

# Scandinavian EU Preference Vote -- dummy variable regression
# model with a factor as predictor
vote_lm2 <- lm(Y ~ log10(X)+Country)
summary(vote_lm2)

# display the fitted lines
plot(Y ~ log10(X))
legend("bottomright", legend=c("N","F","S"), lty=c(1,1,1), lwd=2, cex=1, col=c("red","blue","purple"))

lines(log10(X)[Country=="N"],fitted(vote_lm2)[Country=="N"], lwd=2, col="red")
lines(log10(X)[Country=="F"],fitted(vote_lm2)[Country=="F"], lwd=2, col="blue")
lines(log10(X)[Country=="S"],fitted(vote_lm2)[Country=="S"], lwd=2, col="purple")

# examine the model
oldpar <- par(mfrow = c(2, 2))
plot(vote_lm2, which=c(1,2,4,5))
par(oldpar)

# map residuals
pal <- brewer.pal(8, "PuOr") 
plotlab <- as.character(round(vote_lm2$residuals, 1))
plottitle <- "Residuals from lm2"
ggplot()  +
  geom_sf(data = scand_prov_sf, aes(fill = vote_lm2$residuals)) +
  geom_sf_text(data = scand_prov_pts, aes(geometry=geometry, label=plotlab), size = 2) +
  scale_fill_gradientn(colors = pal, limits = c(-20, 20), breaks = seq(-20, 20, by = 5)) +
  labs(title = plottitle, x="Longitude", y="Latitude") 

opar <- par(mfrow=c(1,4))
# country-effect
boxplot(Y ~ Country, ylab="Yes")

# residual grouped boxplot
boxplot(residuals(vote_lm1) ~ Country, ylim=c(-15,15))
boxplot(residuals(vote_lm2) ~ Country, ylim=c(-15,15))
par <- opar

vote_lm3 <- lm(Y ~ log10(X)*Country)
summary(vote_lm3)

# display the fitted lines
plot(Y ~ log10(X))
legend("bottomright", legend=c("N","F","S"), lty=c(1,1,1), lwd=2, cex=1, col=c("red","blue","purple"))

lines(log10(X)[Country=="N"],fitted(vote_lm3)[Country=="N"], lwd=2, col="red")
lines(log10(X)[Country=="F"],fitted(vote_lm3)[Country=="F"], lwd=2, col="blue")
lines(log10(X)[Country=="S"],fitted(vote_lm3)[Country=="S"], lwd=2, col="purple")

# map residuals
pal <- brewer.pal(8, "PuOr") 
plotlab <- as.character(round(vote_lm3$residuals, 1))
plottitle <- "Residuals from lm3"
ggplot()  +
  geom_sf(data = scand_prov_sf, aes(fill = vote_lm3$residuals)) +
  geom_sf_text(data = scand_prov_pts, aes(geometry=geometry, label=plotlab), size = 2) +
  scale_fill_gradientn(colors = pal, limits = c(-20, 20), breaks = seq(-20, 20, by = 5)) +
  labs(title = plottitle, x="Longitude", y="Latitude") 

# country-effect
opar <- par(mfrow=c(1,4))
boxplot(Y ~ Country, ylab="Yes")

# residual grouped boxplot
boxplot(residuals(vote_lm1) ~ Country, ylim=c(-15,15))
boxplot(residuals(vote_lm2) ~ Country, ylim=c(-15,15))
boxplot(residuals(vote_lm3) ~ Country, ylim=c(-15,15))
par <- opar
