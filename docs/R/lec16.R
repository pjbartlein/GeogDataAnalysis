# purled from lec16.Rmd

#boxes_pca -- principal components analysis of Davis boxes data
boxes_matrix <- data.matrix(cbind(boxes[,1],boxes[,4]))
dimnames(boxes_matrix) <- list(NULL, cbind("long","diag"))

plot(boxes_matrix)
cor(boxes_matrix)

boxes_pca <- princomp(boxes_matrix, cor=T)
boxes_pca
summary(boxes_pca)
print(loadings(boxes_pca), cutoff=0.0)
biplot(boxes_pca)

# get parameters of component lines (after Everitt & Rabe-Hesketh)
load <-boxes_pca$loadings
slope <- load[2,]/load[1,]
mn <- apply(boxes_matrix,2,mean)
intcpt <- mn[2]-(slope*mn[1])

# scatter plot with the two new axes added
par(pty="s") # square plotting frame
xlim <- range(boxes_matrix) # overall min, max
plot(boxes_matrix, xlim=xlim, ylim=xlim, pch=16, col="purple") # both axes same length
abline(intcpt[1],slope[1],lwd=2) # first component solid line
abline(intcpt[2],slope[2],lwd=2,lty=2) # second component dashed
legend("right", legend = c("PC 1", "PC 2"), lty = c(1, 2), lwd = 2, cex = 1)

# projections of points onto PCA 1
y1 <- intcpt[1]+slope[1]*boxes_matrix[,1]
x1 <- (boxes_matrix[,2]-intcpt[1])/slope[1]
y2 <- (y1+boxes_matrix[,2])/2.0
x2 <- (x1+boxes_matrix[,1])/2.0
segments(boxes_matrix[,1],boxes_matrix[,2], x2, y2, lwd=2,col="purple")

cities_matrix <- data.matrix(cities[,2:12])
rownames(cities_matrix) <- cities[,1] # add city names as row labels

plot(cities[,2:12], pch=16, cex=0.6)
cor(cities[,2:12])

library(corrplot)
corrplot(cor(cities[,2:12]), method="ellipse")

corrplot(cor(cities[,2:12]), method="color")

library(qgraph)
qgraph(cor(cities[,2:12]))

qgraph(cor(cities[,2:12]), layout="spring", shape="rectangle", posCol="darkgreen", negCol="darkmagenta")

cities_pca <- princomp(cities_matrix, cor=T)
cities_pca
summary(cities_pca)
screeplot(cities_pca)
loadings(cities_pca)
biplot(cities_pca, col=c("black","red"), cex=c(0.7,0.8))

# define a function for producing qgraphs of loadings
qgraph_loadings_plot <- function(loadings_in, title) {
  ld <- loadings(loadings_in)
  qg_pca <- qgraph(ld, title=title, 
                   posCol = "darkgreen", negCol = "darkmagenta", arrows = FALSE, 
                   labels=attr(ld, "dimnames")[[1]])
  qgraph(qg_pca, title=title,
         layout = "spring", 
         posCol = "darkgreen", negCol = "darkmagenta", arrows = FALSE,
         node.height=0.5, node.width=0.5, vTrans=255, edge.width=0.75, label.cex=1.0,
         width=7, height=5, normalize=TRUE, edge.width=0.75)
}

library(psych)

# unrotated components
cities_pca_unrot <- principal(cities_matrix, nfactors=2, rotate="none")
cities_pca_unrot
summary(cities_pca_unrot)
qgraph_loadings_plot(cities_pca_unrot, "Unrotated component loadings")

# rotated components
cities_pca_rot <- principal(cities_matrix, nfactors=2, rotate="varimax")
cities_pca_rot
summary(cities_pca_rot)
biplot.psych(cities_pca_rot, labels=rownames(cities_matrix), col=c("black","red"), cex=c(0.7,0.8),
  xlim.s=c(-3,3), ylim.s=c(-2,4))

qgraph_loadings_plot(cities_pca_rot, "Rotated component loadings")

# cities_fa1 -- factor analysis of cities data -- no rotation
cities_fa1 <- factanal(cities_matrix, factors=2, rotation="none", scores="regression")
cities_fa1
biplot(cities_fa1$scores[,1:2], loadings(cities_fa1), cex=c(0.7,0.8))

qgraph_loadings_plot(cities_fa1, "Factor analysis")

# cities_fa2 -- factor analysis of cities data -- varimax rotation
cities_fa2 <- factanal(cities_matrix, factors=2, rotation="varimax", scores="regression")
cities_fa2
biplot(cities_fa2$scores[,1:2], loadings(cities_fa2), cex=c(0.7,0.8))

library(qgraph)
qgraph_loadings_plot(cities_fa2, "Factor analysis -- rotated factors")

# pca of multimodel means
library(corrplot)
library(qgraph)
library(psych)

# read data
datapath <- "/Users/bartlein/Documents/geog495/data/csv/"
csvfile <- "aavesModels_ltmdiff_NEurAsia.csv"
input_data <- read.csv(paste(datapath, csvfile, sep=""))
mm_data_in <- input_data[,3:30]
names(mm_data_in)
summary(mm_data_in)

# read data
datapath <- "/Users/bartlein/Documents/geog495/data/csv/"
csvfile <- "aavesModels_ltmdiff_NEurAsia.csv"
input_data <- read.csv(paste(datapath, csvfile, sep=""))
mm_data_in <- input_data[,3:30]
names(mm_data_in)
summary(mm_data_in)

# recode a few NA's to zero
mm_data_in$snd[is.na(mm_data_in$snd)] <- 0.0

# remove uneccesary variables
dropvars <- names(mm_data_in) %in% c("Kext","bowen","sm","evap")
mm_data <- mm_data_in[!dropvars]
names(mm_data)

cor_mm_data <- cor(mm_data)
corrplot(cor_mm_data, method="color")

qgraph(cor_mm_data, title="Correlations, multi-model ltm differences over months",
  # layout = "spring", 
  posCol = "darkgreen", negCol = "darkmagenta", arrows = FALSE,
  node.height=0.5, node.width=0.5, vTrans=255, edge.width=0.75, label.cex=1.0,
  width=7, height=5, normalize=TRUE, edge.width=0.75 ) 

qgraph(cor_mm_data, title="Correlations, multi-model ltm differences over months",
  layout = "spring", repulsion = 0.75,
  posCol = "darkgreen", negCol = "darkmagenta", arrows = FALSE,
  node.height=0.5, node.width=0.5, vTrans=255, edge.width=0.75, label.cex=1.0,
  width=7, height=5, normalize=TRUE, edge.width=0.75 ) 

nfactors <- 8
mm_pca_unrot <- principal(mm_data, nfactors = nfactors, rotate = "none")
mm_pca_unrot

nfactors <- 5
mm_pca_unrot <- principal(mm_data, nfactors = nfactors, rotate = "none")
mm_pca_unrot
loadings(mm_pca_unrot)

scree(mm_data, fa = FALSE, pc = TRUE)

qgraph_loadings_plot(mm_pca_unrot, title="Unrotated component loadings, all models over all months")

nfactors <- 4
mm_pca_rot <- principal(mm_data, nfactors = nfactors, rotate = "varimax")
mm_pca_rot
qgraph_loadings_plot(mm_pca_rot, "Rotated component loadings, all models over all months") 

