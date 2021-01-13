# purled from lec09.Rmd

# Sierra Nevada tree-ring summer temperature reconstructions
attach(sierra)

# sort and rank TSum values
sort_Tsum <- sort(TSum) # arranges values from low to high
rank_Tsum <- rank(TSum) # replaces values with rank number (1 to n)

# inspect the sorted and ranked values
# close window to exit
sierra_sort <- data.frame(Year, TSum, rank(TSum), sort_Tsum, rank(sort_Tsum),
     Year[rank(TSum)])
head(sierra_sort)
tail(sierra_sort)

## View(sierra_sort)

# nice histogram
cutpts <- seq(12.0, 18.0, by=0.1)
hist(TSum, breaks=cutpts, probability=T, xlim=c(13,18))
lines(density(TSum))
rug(TSum)

# empirical cumulative density function
ecdf_Tsum <- rank(sort_Tsum)/length(TSum)
plot(sort_Tsum, ecdf_Tsum, type="l")
sierra_ecdf <- data.frame(Year, TSum, rank(TSum), sort_Tsum, rank(sort_Tsum),
     Year[rank(TSum)], ecdf_Tsum)
head(sierra_ecdf); tail(sierra_ecdf)

## View(sierra_ecdf)

quantile(TSum, probs = c(0.0,.05,.10,.25,.50,.75,.90,.95, 1.0))

mean(TSum[(length(TSum)-29):(length(TSum))])

# repeated sampling and calculation of means
nsamp <- 200 # number of samples
Means30yr <- matrix(1:nsamp) # matrix to hold means
for (i in 1:nsamp) {
     samp <- sample(TSum, 30, replace=T)
          Means30yr[i] <- mean(samp)
     }

# histograms of data and of 30-Means
par(mfrow=c(2,1))
cutpts <- seq(12.0, 18.0, by=0.1)
hist(TSum, breaks=cutpts, probability=T, xlim=c(12,20))
lines(density(TSum))
hist(Means30yr, breaks=cutpts, probability=T, xlim=c(12,20))
lines(density(Means30yr))

# repeated sampling and calculation of means
# consecutive samples
nsamp <- 200 # number of samples
Means30yrb <- matrix(1:nsamp) # matrix to hold means
for (i in 1:nsamp) {
     start <- runif(1, min=1, max=length(Year)-30)
     start <- round(start)
     sampmean <- 0.0
     for (j in 1:30) {
          sampmean <- sampmean + TSum[start+j-1]
     }
     Means30yrb[i] <- sampmean/30.0
}

# histograms of data and of 30-Means from consecutive samples
par(mfrow=c(2,1))
cutpts <- seq(12.0, 18.0, by=0.1)
hist(TSum, breaks=cutpts, probability=T, xlim=c(12,20))
lines(density(TSum))
hist(Means30yrb, breaks=cutpts, probability=T, xlim=c(12,20))
lines(density(Means30yrb))

# probability density function
x <- seq(-3, +3, by=.1)
pdf_norm<- dnorm(x, mean=0, sd=1)
plot(x, pdf_norm, type="l")

# cumulative density function
x <- seq(-3, +3, by=.1)
cdf_norm<-pnorm(x, mean=0, sd=1)
plot(x, cdf_norm, type="l")

# inverse cumulative density function
pr <- seq(0, 1, by=.01)
invcdf_norm<- qnorm(pr, mean=0, sd=1)
plot(pr, invcdf_norm, type="l")

# normally distributed random numbers
z <- rnorm(n=1000, mean=0, sd=1)
hist(z, nclass=40)
plot(z)

n <- 1000
stdNormal <- rnorm(n, mean=0, sd=1)
Normal <- rnorm(n, mean=4.0, sd=2.0)
logNormal <- rlnorm(n, meanlog=1.0, sdlog=0.5)
Uniform <- runif(n, min=0.0, max=1.0)

opar <- par(mfrow=c(2,2))
hist(stdNormal)
hist(Normal)
hist(logNormal)
hist(Uniform)
par <- opar

# take repeated samples from each distribution and calculate and save means
# repeated sampling and calculation of means
nsamp <- 200 # number of samples
mean_stdNormal <- matrix(1:nsamp) # matrix to hold means
mean_normal <- matrix(1:nsamp) # matrix to hold means
mean_logNormal <- matrix(1:nsamp) # matrix to hold means
mean_Uniform <- matrix(1:nsamp) # matrix to hold means

for (i in 1:nsamp) {
     samp <- sample(stdNormal, 30, replace=T)
     mean_stdNormal[i] <- mean(samp)

     samp <- sample(Normal, 30, replace=T)
     mean_normal[i] <- mean(samp)

     samp <- sample(logNormal, 30, replace=T)
     mean_logNormal[i] <- mean(samp)

     samp <- sample(Uniform, 30, replace=T)
     mean_Uniform[i] <- mean(samp)
}


# histograms of data and of sample means
par(mfrow=c(2,1))

# standard Normal
xmax <- max(stdNormal)
xmin <- min(stdNormal)
hist(stdNormal, nclass=40, probability=T, xlim=c(xmin,xmax))
hist(mean_stdNormal, nclass=40, probability=T, xlim=c(xmin,xmax))
# Normal
xmax <- max(Normal)
xmin <- min(Normal)
hist(Normal, nclass=40, probability=T, xlim=c(xmin,xmax))
hist(mean_normal, nclass=40, probability=T, xlim=c(xmin,xmax))
# log Normal
xmax <- max(logNormal)
xmin <- min(logNormal)
hist(logNormal, nclass=40, probability=T, xlim=c(xmin,xmax))
hist(mean_logNormal, nclass=40, probability=T, xlim=c(xmin,xmax))
# Uniform
xmax <- max(Uniform)
xmin <- min(Uniform)
hist(Uniform, nclass=40, probability=T, xlim=c(xmin,xmax))
hist(mean_Uniform, nclass=40, probability=T, xlim=c(xmin,xmax))

