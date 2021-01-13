# purled from lec10.Rmd

load(".Rdata")

# generate 1000 random numbers from the normal distribution
npts <- 1000
demo_mean <- 5; demo_sd <- 2
data_values <- rnorm(npts, demo_mean, demo_sd)
hist(data_values); mean(data_values); sd(data_values)

nreps <- 1000 # number of replications (samples) for each sample size
max_sample_size <- 100 # number of example sample sizes

# matrix to hold means of each of the nreps samples
mean_samp <- matrix(1:nreps)
# matrices to hold means, sd’s and sample sizes for for each n
average_means <- matrix(1:(max_sample_size-1))
sd_means <- matrix(1:(max_sample_size-1))
sample_size <- matrix(1:(max_sample_size-1))

for (n in seq(1,max_sample_size-1)) {
   # for each sample size generate nreps samples and get their mean
   for (i in seq(1,nreps)) {
         samp <- sample(data_values, n+1, replace=T)
         mean_samp[i] <- mean(samp)
   }
   # get the average and standard deviation of the nreps means
   average_means[n] <- apply(mean_samp,2,mean)
   sd_means[n] <- apply(mean_samp,2,sd)
   sample_size[n] <- n+1
}

plot(sample_size, average_means, ylim=c(4.5, 5.5), pch=16)
plot(sample_size, sd_means, pch=16)
head(cbind(average_means,sd_means,sample_size))
tail(cbind(average_means,sd_means,sample_size))

plot(demo_sd/sqrt((2:max_sample_size)), sd_means, pch=16)

# data_values from a uniform distribution
data_values <- runif(npts, 0, 1)
hist(data_values); mean(data_values); sd(data_values)

# rescale the data_values so they have a mean of demo_mean
# and a standard deviation of demo_sd (standardize, then rescale)
data_values <- (data_values-mean(data_values))/sd(data_values)
mean(data_values); sd(data_values)
data_values <- (data_values*demo_sd)+demo_mean
hist(data_values); mean(data_values); sd(data_values)

for (n in seq(1,max_sample_size-1)) {
   # for each sample size generate nreps samples and get their mean
   for (i in seq(1,nreps)) {
         samp <- sample(data_values, n+1, replace=T)
         mean_samp[i] <- mean(samp)
   }
   # get the average and standard deviation of the nreps means
   average_means[n] <- apply(mean_samp,2,mean)
   sd_means[n] <- apply(mean_samp,2,sd)
   sample_size[n] <- n+1
}
plot(sample_size, sd_means, pch=16)
head(cbind(average_means,sd_means,sample_size))
tail(cbind(average_means,sd_means,sample_size))

## # generate 4000 random values from the Normal Distribution with mean=10, and standard deviation=1
## NormDat <- rnorm(mean=10, sd=1, n=4000)
## # generate a "grouping variable" that defines 40 groups, each with 100 observations
## Group <- sort(rep(1:40,100))
## cidat <- data.frame(cbind(NormDat, Group)) # make a data frame

attach(cidat)
summary(cidat)

group_means <- tapply(NormDat, Group, mean)
group_sd <- tapply(NormDat, Group, sd)
group_npts <- tapply(NormDat, Group, length)
group_semean <- (group_sd/(sqrt(group_npts)))
mean(group_means)
sd(group_means)

# plot means and data
par(mfrow=c(2,1))
plot(Group, NormDat)
points(group_means, col="red", pch=16)
# plot means and standard errors of means
plot(group_means, ylim=c(9, 11), col="red", pch=16, xlab="Group")
points(group_means + 2.0*group_semean , pch="-")
points(group_means - 2.0*group_semean , pch="-")
abline(10,0)

par(mfrow=c(1,1))
detach(cidat)

x <- seq(-3,3, by=.1)
pdf_t <- dt(x,3)
plot(pdf_t ~ x, type="l")

# t-tests
attach(ttestdat)
boxplot(Set1 ~ Group1)

# two-tailed tests
t.test(Set1 ~ Group1)

t.test(Set1 ~ Group1, alternative = "less")    # i.e. mean of group 0 is less than the mean of group 1
t.test(Set1 ~ Group1, alternative = "greater") # i.e. mean of group 0 is greater than the mean of group 1

boxplot(Set2 ~ Group2)
t.test(Set2 ~ Group2)
detach(ttestdat)

attach(foursamples)

# nice histograms
cutpts <- seq(0.0, 20.0, by=1)
par(mfrow=c(2,2))
hist(Sample1, breaks=cutpts, xlim=c(0,20))
hist(Sample2, breaks=cutpts, xlim=c(0,20))
hist(Sample3, breaks=cutpts, xlim=c(0,20))
hist(Sample4, breaks=cutpts, xlim=c(0,20))
par(mfrow=c(1,1))

boxplot(Sample1, Sample2, Sample3, Sample4)
mean(Sample1)-mean(Sample2)
t.test(Sample1, Sample2)

mean(Sample3)-mean(Sample4)
t.test(Sample3, Sample4)

mean(Sample1)-mean(Sample3)
t.test(Sample1, Sample3)

mean(Sample2)-mean(Sample4)
t.test(Sample2, Sample4)

detach(foursamples)

