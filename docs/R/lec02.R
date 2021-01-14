purled from lec02.Rmd

## # install the sp and raster packages
## install.packages("sp", repos = "http://cran.r-project.org")
## install.packages("raster", repos = "http://cran.r-project.org")

## # clear the current workspace
## rm(list=ls(all=TRUE))

## # connect to a saved workspace name geog495.RData and load it
## con <- url("https://pjbartlein.github.io/GeogDataAnalysis/data/Rdata/geog495.RData")
## load(file=con)
## close(con)

load(".Rdata")

# read a .csv file
csvfile <- "/Users/bartlein/Documents/geog495/data/csv/cities.csv"
cities <- read.csv(csvfile)

# get the names of the variables
names(cities)

str(cities)

head(cities); tail(cities)

# use large cities data [cities.csv], get an index plot
attach(cities)
plot(Pop.2000)

# another univariate plot
plot(Pop.2000, type="h")

# detach the cities dataframe
detach(cities)

# use Specmap delta-O18 data
csvfile <- "/Users/bartlein/Documents/geog495/data/csv/specmap.csv"
specmap <- read.csv(csvfile)

# attach specmap and plot
attach(specmap)
plot(O18)

# inverted y-axis 
plot(O18, ylim=c(2.5,-2.5))   #  invert y-axis

# stripchart
stripchart(O18)
stripchart(O18, method="stack")   # stack points to reduce overlap

# detach the specmap dataframe
detach(specmap)                   

# dotchart 
attach(cities)
dotchart(Pop.2000, labels=City)

# indexed (sorted) dotchart
index <- order(Pop.2000)
dotchart(Pop.2000[index], labels=City[index])

## # detach the cites dataframe
## detach(cities)

# adjust the paths to reflect the local environment
csvfile <- "/Users/bartlein/Documents/geog495/data/csv/specmap.csv"
specmap <- read.csv(csvfile)
csvfile <- "/Users/bartlein/Documents/geog495/data/csv/scanvote.csv"
scanvote <- read.csv(csvfile)

# use Specmap O-18 data [specmap.csv]
attach(specmap)
# histogram
hist(O18)

# second histogram
hist(O18, breaks=20)

# density plot
O18_density <- density(O18)
plot(O18_density)

# histogram plus density plot
O18_density <- density(O18)
hist(O18, breaks=40, probability=TRUE)
lines(O18_density)
rug(O18)

# detach the specmap dataframe
detach(specmap)

# use Scandinavian EU-preference vote data
attach(scanvote)
# get a boxplot
boxplot(Pop)

# second boxplot
boxplot(log10(Pop))

# display the "normal" theoretical reference distribution
z <- seq(-3.0,3.0,.05)
pdf_z <- dnorm(z)   # get probability density function
plot(z, pdf_z)
cdf_z <- pnorm(z)   # get cumulative distribution function
plot(z, cdf_z)

# inverse cdf
p <- seq(0,1,.01)
invcdf_z <- qnorm(p)  
plot(p,invcdf_z)

# QQ plots
qqnorm(Pop)
qqline(Pop)
qqnorm(log10(Pop))
qqline(log10(Pop))

detach(scanvote)
