# purled from lec18.Rmd

library(sf)
library(lattice)
library(RColorBrewer)

# calculate a Squared Chord-Distance dissimilarity matrix for
# Midwestern pollen data
X <- as.matrix(midwtf2[,7:21])
nvars <- 14
nobs <- 124
SCDist <- array(0.0, c(nobs^2,3))
dimnames(SCDist) <- list(NULL,c("i","j","SCD"))
SCDist_matrix <- array(0.0, c(nobs,nobs))
for (i in 1:nobs) {
    for (j in 1:nobs) {
    distance <- 0.0
        for (k in 1:nvars) {
            distance <- distance + ((sqrt(X[i,k])-sqrt(X[j,k]))^2)
            }
            m <-((i-1)*nobs)+j
            SCDist[m,3] <- sqrt(distance)
            SCDist_matrix[i,j] <- sqrt(distance)
            SCDist[m,1] <- i
            SCDist[m,2] <- j
    }
}

# display the distance matrix
grid <- expand.grid(obs1 = seq(1:nobs), obs2 = seq(1:nobs))
levelplot(SCDist_matrix ~ obs1*obs2, data=grid, col.regions = gray(seq(0,1,by=0.0625)),
  xlab="observation", ylab="observation")


# Mahalonobis distances
# July and annual temperature
X <- as.matrix(midwtf2[,4:5])
X_cov <- var(scale(X)) # standardize first
X_cov <- var(X)
X_mean <- apply(X,2,mean)
X_mah <- mahalanobis(X, X_mean, X_cov)

# plot the variables, conf. ellipses and M.D.
library(car)
library(plotrix)

# plot points, Mahalanobis distances and Euclidean distances
plot(midwtf2$tmeanjul, midwtf2$tmeanyr, asp=1, pch=16, col="gray50")
ellipse(X_mean, X_cov, radius=1, add=TRUE)
ellipse(X_mean, X_cov, radius=2, add=TRUE)
points(midwtf2$tmeanjul, midwtf2$tmeanyr, cex=10*(X_mah-min(X_mah))/(max(X_mah)-
    min(X_mah)))
draw.circle(X_mean[1], X_mean[2], radius=1, lwd=2, bor="red")
draw.circle(X_mean[1], X_mean[2], radius=2, lwd=2, bor="red")

# Mahalonobis distances for individual spectra, Midwestern pollen data
X <- as.matrix(midwtf2[,7:21])
X_cov <- var(X)
X_mean <- apply(X,2,mean)
X_mah <- mahalanobis(X, X_mean, X_cov, tol.inv=1e-16)

# Map the Midwestern study area
# plot shape file
plot(st_geometry(midwotl_sf), axes=TRUE)
points(midwtf2$longitud, midwtf2$latitude, cex=10*(X_mah-min(X_mah))/(max(X_mah)-min(X_mah)))

## Multi-dimensional scaling (MDS)
# plot Oregon climate stations

# plot station names as a conventional map
plot(st_geometry(orotl_sf))
#points(lon, lat, pch=3)
text(orstationc$lon, orstationc$lat, labels=as.character(orstationc$station), cex=.6)

# MDS "map" based only on distances between stations, not their absolute coordinates
X <- as.matrix(orstationc[,2:3]) # longitude and latitude only
X_scal <- cmdscale(dist(X), k=2, eig=T)
X_scal$points[,1] <- -X_scal$points[,1] # may need to reverse axes
# X_scal$points[,2] <- -X_scal$points[,2]
plot(X_scal$points, type="n")
text(X_scal$points, labels = orstationc$station, cex=.6)

# multidimensional scaling of Oregon climate station data
# now with climate variables not locations
X <- as.matrix(orstationc[,5:10])
X_scal <- cmdscale(dist(X), k=2, eig=T)
X_scal$points[,1] <- -X_scal$points[,1]
X_scal$points[,2] <- -X_scal$points[,2]
plot(X_scal$points, type="n")
text(X_scal$points, labels = orstationc$station, cex=.6)

# multidimensional scaling of Midwestern pollen data
X <- as.matrix(midwtf2[,7:21])
X_scal <- cmdscale(dist(X), k=2, eig=T)
X_scal$points[,2] <- -X_scal$points[,2]
plot(X_scal$points, type="n", main="latitude")
text(X_scal$points, labels = (format(signif(midwtf2$latitude,digits=3))),
    cex=.6)
plot(X_scal$points, type="n", main="longitude")
text(X_scal$points, labels = (format(signif(midwtf2$longitud,digits=3))),
    cex=.6)

# hierarchical clustering, Ward's method, Yellowstone pollen data
X <- as.matrix(ypolsqrt[,4:35]) # just the pollen data
X_dist <- dist(scale(X))
# image(seq(1:58),seq(1:58),as.matrix(X_dist))
hier_cls <- hclust(X_dist, method = "ward.D2")
plot(hier_cls, labels=ypolsqrt$Veg, cex=.7)

# list subjective vegetation zones
levels(ypolsqrt$Veg)
# cut dendrogram to give 5 clusters
nclust <- 5
clusternum <- cutree(hier_cls, k=nclust)
class_table_hier <- table(ypolsqrt$Veg, clusternum)
mosaicplot(class_table_hier, color=T)

# k-means clustering of Yellowstone pollen data
library(cluster)
X <- as.matrix(ypolsqrt[,4:35])
kmean_cls <- kmeans(X, centers=5)
class_table_km <- table(ypolsqrt$Veg, kmean_cls$cluster)
mosaicplot(class_table_km, color=T)

# flexclust library version of k-means, with stripes plot
library(flexclust)
X <- as.matrix(ypolsqrt[,4:35])
flexclust_cls <- cclust(X, dist="euclidean", method="kmeans", k=5)
class_table_flexclust <- table(ypolsqrt$Veg, flexclust_cls@cluster)
stripes(flexclust_cls, type="second", col = 1)
mosaicplot(class_table_flexclust, color=T)

# "pam" clustering of Yellowstone pollen data
library(cluster)
X <- as.matrix(ypolsqrt[,4:35])
pam_cls <- pam(X, k=5)
plot(pam_cls)
class_table_pam <- table(ypolsqrt$Veg, pam_cls$cluster)
mosaicplot(class_table_pam, color=T)
