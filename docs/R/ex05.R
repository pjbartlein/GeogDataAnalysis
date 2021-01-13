# purled from ex05.Rmd

# install the "tidyverse" suite of packages
install.packages("tidyverse")
# library
library(tidyverse)

# read a .csv file using the `readr` package
csv_file <- "/Users/bartlein/Documents/geog495/data/csv/EugeneClim-short.csv"
eugclim <- read_csv(csv_file)
eugclim

# time-series plot
plot(eugclim$tavg ~ eugclim$yrmn, type="o", pch=16, xaxp=c(2013, 2016, 3))
# by month
plot(eugclim$mon, eugclim$tavg, pch=16, xaxp=c(1, 12, 1))

# alternative layout of precipitation data
csv_file <- "/Users/bartlein/Documents/geog495/data/csv/EugeneClim-short-alt-pvars.csv"
eugclim_alt <- read_csv(csv_file)
eugclim_alt

# reshape by gathering and spreading
# 1) gather
eugclim_alt2 <- gather(eugclim_alt, `1`:`12`, key="month", value="cases")
eugclim_alt2$month <- as.integer(eugclim_alt2$month)
eugclim_alt2
# 2) spread
eugclim_alt3 <- spread(eugclim_alt2, key="param", value=cases)
eugclim_alt3

# plot the reshaped data
eugclim_alt3$yrmn <- eugclim_alt3$year + (as.integer(eugclim_alt3$month)-1)/12
plot(eugclim_alt3$prcp ~ eugclim_alt3$yrmn, type="o", pch=16, col="blue", xaxp=c(2013, 2016, 3))

# create three matrices
# default fill method: byrow = FALSE
A <- matrix(c(6, 9, 12, 13, 21, 5), nrow=3, ncol=2)
A
# same elements, but byrow = TRUE
B <-  matrix(c(6, 9, 12, 13, 21, 5), nrow=3, ncol=2, byrow=TRUE)
B
# a third matrix
C <- matrix(c(1,2,3,4,5,6,7,8,9), nrow=3, ncol=3)
C

# matrix addition
F <- A + B
F

G <- A + C

# matrix multiplication
Q <- C %*% A
Q

# a realistic matrix, orstationc temperature-variable correlation matrix
R <- cor(cbind(orstationc$tjan, orstationc$tjul, orstationc$tann))
R

# matrix inversion
Rinv <- solve(R)
Rinv

