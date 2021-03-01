# purled from lec17.Rmd

# ANOVA and MANOVA
library(lattice)
attach(sumcr)

# univariate analysis of variance
# set variable to analyze
varname <- "WidthWS"

# plot distributions by groups
histogram(~ eval(get(varname)) | Reach, nint=20, aspect=1/3, xlab=varname)

# test for homogeneity of group variances
tapply(get(varname), Reach, var)
bartlett.test(get(varname) ~ Reach)

# analysis of variance
sumcr_aov1 <- aov(get(varname) ~ Reach)
summary(sumcr_aov1)

# MANOVA
Y <- cbind(DepthWS, WidthWS, WidthBF, HUAreaWS, HUAreaBF, wsgrad)
sumcr_mva1 <- manova(Y ~ Reach)
summary.aov(sumcr_mva1)
summary(sumcr_mva1, test="Wilks")

# discriminant analysis example, Summit Cr. data, two variables, two groups
library(MASS)
library(lattice) # for plots

# recode Reach into two levels, Grazed and Ungrazed
Grazed <- as.integer(Reach)
Grazed[Grazed==3] <- 1
Grazed <- as.factor(Grazed)
levels(Grazed) <- c("G","U")
plot(WidthWS, DepthWS, type="n")
text(WidthWS, DepthWS, label=as.character(Grazed))

# discriminant analysis, coefficients and scores
Grazed_lda1 <- lda(Grazed ~ WidthWS + DepthWS, method="moment")
Grazed_lda1
plot(Grazed_lda1)
Grazed_dscore <- predict(Grazed_lda1, dimen=1)$x
cor(cbind(WidthWS, DepthWS, Grazed_dscore))
histogram(~ Grazed_dscore[,1] | Grazed, nint=20, aspect=1/3)

# plot discriminant function and classification line
# to make plots easier to interpret, rescale DepthWS by 10x
plot(WidthWS, DepthWS*10, type="n", asp=1)
text(WidthWS, DepthWS*10, label=as.character(Grazed), cex=.5)
     chw <- par()$cxy[1]
text(WidthWS+chw, DepthWS*10, label=as.character(round(Grazed_dscore,2)),
     cex=.6)

# DF1
slope_DF1 <- Grazed_lda1$scaling[2]/Grazed_lda1$scaling[1]
abline(7, slope_DF1, lwd=2)

# classification threshold line
slope_CL1 <- -1/(Grazed_lda1$scaling[2]/Grazed_lda1$scaling[1])
int_CL1 <- ((Grazed_lda1$means[1,]%*%Grazed_lda1$scaling +
    Grazed_lda1$means[2,]%*%Grazed_lda1$scaling)/2)*
    (Grazed_lda1$scaling[1]/
    Grazed_lda1$scaling[2]/Grazed_lda1$scaling[2])
abline(int_CL1, slope_CL1, col="purple", lwd=2)

# second example 
# linear discriminant analysis
Reach_lda1 <- lda(Reach ~ DepthWS + WidthWS + WidthBF + HUAreaWS + HUAreaBF
     + wsgrad)
Reach_lda1
plot(Reach_lda1, asp=1)

Reach_dscore <- predict(Reach_lda1, dimen=2)$x
histogram(~Reach_dscore[,1] | Reach, nint=20, aspect=1/3)
histogram(~Reach_dscore[,2] | Reach, nint=20, aspect=1/3)
cor(sumcr[6:11],Reach_dscore)

Reach_pred <- predict(Reach_lda1, dimen=2)$class
class_table <- table(Reach, Reach_pred)
mosaicplot(class_table, color=T)

