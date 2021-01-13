# purled from ex08.Rmd

# read the streams file (if not already in the workspace)
csv_path <- "/Users/bartlein/Documents/geog495/data/csv/streams"
streams <- read.csv(csv_path)

# read the transformed streams file (if not already in the workspace)
csv_path <- "/Users/bartlein/Documents/geog495/data/csv/tstreams"
tstreams <- read.csv(csv_path)

plot(streams[3:13], pch=16, cex=.5)
plot(tstreams[3:13], pch=16, cex=.5)

# principal components analysis of (transformed) NE Oregon streams data
tstreams_matrix <- data.matrix(tstreams[,3:13])
# rownames combining stream name and U/H
rownames(tstreams_matrix) <- paste(as.character(tstreams[,2]), as.character(tstreams[,1]))

library(psych)
tstreams_pca <- principal(tstreams_matrix, nfactors=4, rotate="none")

# display the results
tstreams_pca
summary(tstreams_pca)
VSS.scree(tstreams_matrix)
print(loadings(tstreams_pca),cutoff=0.0)
biplot(tstreams_pca$scores[,1:2], loadings(tstreams_pca)[,1:2],
  main="PCA Biplot -- 2 Components", cex=0.5)

# biplot -- observations
plot(tstreams_pca$scores[,1:2], type="n")
text(tstreams_pca$scores[,1:2], labels=seq(1:length(tstreams[,1])))

# biplot -- observations
plot(tstreams_pca$scores[,1:2], cex = 0.2)
text(tstreams_pca$scores[,1:2], labels = rownames(tstreams_matrix), cex = 0.5)

# biplot -- variables
plot(loadings(tstreams_pca)[,1:2])
text(loadings(tstreams_pca)[,1:2], labels=colnames(tstreams_matrix))

library(qgraph)

qgraph_loadings_plot <- function(loadings_in, title) {
  ld <- loadings(loadings_in)
  qg_pca <- qgraph(ld, title=title,
                   posCol = "darkgreen", negCol = "darkmagenta", arrows = FALSE, vTrans=256)
  qgraph(qg_pca, title=title,
         layout = "spring",
         posCol = "darkgreen", negCol = "darkmagenta", arrows = FALSE,
         node.height=0.5, node.width=0.5, vTrans=256, edge.width=0.75, label.cex=1.0,
         width=7, height=5, normalize=TRUE, edge.width=0.75)
}

qgraph_loadings_plot(tstreams_pca, "PCA tstreams, unrotated components")

# factor analysis:  extract 4 factors, no rotation
tstreams_fa1 <- factanal(tstreams_matrix, factors=4, rotation="none",
  scores="regression")
tstreams_fa1 # list the results
print(loadings(tstreams_fa1),cutoff=0.7)
biplot(tstreams_fa1$scores[,1:2], loadings(tstreams_fa1)[,1:2],
  main="PCA/Factor Analysis Biplot -- 4 Components", cex=0.5)

qgraph_loadings_plot(tstreams_fa1, "Factor Analysis tstreams, unrotated components")

# factor analysis with rotation
tstreams_fa2 <- factanal(tstreams_matrix, factors=3, rotation="varimax",
  scores="regression")
tstreams_fa2
print(loadings(tstreams_fa2),cutoff=0.7)
biplot(tstreams_fa2$scores[,1:2], loadings(tstreams_fa2)[,1:2],
  main="PCA/Factor Analysis Biplot -- 3 Rotated Components", cex=0.5)

qgraph_loadings_plot(tstreams_fa2, "Factor Analysis tstreams, 3 rotated components")

library(lattice)
# attach streams
attach(streams)

# plot distributions by groups
histogram(~ PoolDepth | Health, nint=20, layout=c(1,2), aspect=1/2)

# one-way analysis of variance

# test for homogeneity of group variances
tapply(PoolDepth, Health, var)
bartlett.test(PoolDepth ~ Health)

# analysis of variance
streams_aov1 <- aov(PoolDepth ~ Health)
summary(streams_aov1)

# MANOVA
Y <- cbind(DA, ReachLen, Pools, DeepPools, LargePools, SmLWD, LrgLWD,
  PoolDepth, PoolArea, PRratio, BFWDratio)
streams_mva1 <- manova(Y ~ Health)
summary.aov(streams_mva1)
summary(streams_mva1, test="Wilks")

# linear discriminant analysis
library(MASS)

health_lda1 <- lda(Health ~ DA + ReachLen + Pools + DeepPools + LargePools
    + SmLWD + LrgLWD + PoolDepth + PoolArea + PRratio + BFWDratio)

health_lda1
plot(health_lda1)

health_dscore <- predict(health_lda1, dimen=1)$x
boxplot(health_dscore ~ Health)
cor(tstreams[3:13],health_dscore)

health_class <- predict(health_lda1, dimen=1)$class
class_table <- table(Health, health_class)
mosaicplot(class_table, color=T)
detach(streams)

# hierarchical clustering of Oregon climate station data
library(sf)
library(lattice)
attach(orstationc)

# plot station abbreviations
plot(st_geometry(orotl_sf), axes=TRUE)
text(lon, lat, labels=station, cex=0.7, col="red")
title("Oregon Climate Stations")

# get dissimilarities (distances) and cluster
X <- as.matrix(orstationc[,5:10])
X_dist <- dist(scale(X))
grid <- expand.grid(obs1 = seq(1:92), obs2 = seq(1:92))
levelplot(as.matrix(X_dist)/max(X_dist) ~ obs1*obs2, data=grid,
    col.regions = gray(seq(0,1,by=0.0625)), xlab="observation", ylab="observation")

# cluster analysis
X_clusters <- hclust(X_dist, method = "ward.D2")
plot(X_clusters, labels=station, cex=0.5)

# cut dendrogram and plot points in each cluster (chunk 1)
nclust <- 3
clusternum <- cutree(X_clusters, k=nclust)
head(cbind(station, clusternum, as.character(Name)))
tail(cbind(station, clusternum, as.character(Name)))

# plot cluster membership of each station
plot(st_geometry(orotl_sf), axes=TRUE)
text(lon, lat, labels=clusternum, col="red")
title("Oregon Climate Stations -- 3 clusters")

# examine clusters -- simple plots (chunk 2)
tapply(tjan, clusternum, mean)
histogram(~ tjan | clusternum, nint=20, layout=c(1,3))

# discriminant analysis (chunk 3)
library(MASS)
cluster_lda1 <- lda(clusternum ~ tjan + tjul + tann + pjan + pjul + pann)
cluster_lda1
plot(cluster_lda1)

cluster_dscore <- predict(cluster_lda1, dimen=nclust)$x
for (j in 1:(nclust-1)) {
  boxplot(cluster_dscore[,j] ~ clusternum, xlab=paste("LD", as.character(j), sep=""))
  }
cor(orstationc[5:10],cluster_dscore)

