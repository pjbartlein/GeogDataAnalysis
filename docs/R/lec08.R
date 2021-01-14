# purled from lec08.Rmd

# read the .csv file conventionally
csv_file <- "/Users/bartlein/Documents/geog495/data/csv/EugeneClim-short.csv"
eugclim_df <- read.csv(csv_file) 

class(eugclim_df)
str(eugclim_df)
eugclim_df

# load library
library(tidyverse)

## median(eugclim_df$tavg)
## stats::median(eugclim_df$tavg)

# reading using `readr` package
eugclim <- read_csv(csv_file)

class(eugclim)
eugclim

plot(eugclim$tavg ~ eugclim$yrmn, type="o", pch=16, xaxp=c(2013, 2016, 3))

# alternative layout
csv_file <- "/Users/bartlein/Documents/geog495/data/csv/EugeneClim-short-alt-tvars.csv"
eugclim_alt <- read_csv(csv_file)
eugclim_alt

# get just the tavg data
eugclim_alt_tavg <- eugclim_alt[eugclim_alt$param == "tavg", ]
eugclim_alt_tavg

# reshape by gathering
eugclim_alt_tavg2 <- gather(eugclim_alt_tavg, `1`:`12`, key="month", value="cases")
eugclim_alt_tavg2

# rearrange (sort)
eugclim_alt_tavg3 <- arrange(eugclim_alt_tavg2, year)
eugclim_alt_tavg3

# add decimal year value
eugclim_alt_tavg3$yrmn <- eugclim_alt_tavg3$year + (as.integer(eugclim_alt_tavg3$month)-1)/12
plot(eugclim_alt_tavg3$cases ~ eugclim_alt_tavg3$yrmn, type="o", pch=16, col="blue", xaxp=c(2013, 2016, 3))

# alternative layout -- gather, then spread
eugclim_alt2 <- gather(eugclim_alt, `1`:`12`, key="month", value="cases")
eugclim_alt2

# convert integer to month
eugclim_alt2$month <- as.integer(eugclim_alt2$month)

# spread
eugclim_alt3 <- spread(eugclim_alt2, key="param", value=cases)
eugclim_alt3

# plot the reshapted data
eugclim_alt3$yrmn <- eugclim_alt3$year + (as.integer(eugclim_alt3$month)-1)/12
plot(eugclim_alt3$tavg ~ eugclim_alt3$yrmn, type="o", pch=16, col="red", xaxp=c(2013, 2016, 3))

# summarize
eugclim_ltm <- summarize_all(eugclim, "mean")
eugclim_ltm

# filter
eugclim_jan <- filter(eugclim, mon==1)
eugclim_jan
eugclim_jan_ltm <- summarize_all(eugclim_jan, "mean")
eugclim_jan_ltm

# summarize by groups -- define groups
eugclim_group <- group_by(eugclim, mon)
eugclim_group

# summarize groups
eugclim_summary <- summarize_all(eugclim_group, funs(mean))
eugclim_summary

# aggregate
eugclim_ann <- aggregate(eugclim, by=list(eugclim$year), FUN="mean")
eugclim_ann

# the pipe
eugclim_summary <- eugclim %>% group_by(mon) %>% summarize_all(funs("mean"))
eugclim_summary

# anomalies
eugclim$tavg_anm <- eugclim$tavg - eugclim_summary$tavg
eugclim$tavg_anm

# plot anomalies
plot(eugclim$tavg_anm ~ eugclim$yrmn, type="o", pch=16, col="green", xaxp=c(2013, 2016, 3))

# create a matrix
# default fill method: byrow = FALSE
A <- matrix(c(6, 9, 12, 13, 21, 5), nrow=3, ncol=2)
A
class(A)

# same elements, but byrow = TRUE
B <-  matrix(c(6, 9, 12, 13, 21, 5), nrow=3, ncol=2, byrow=TRUE)
B

# referencing matrix elements
A[1,2] # row 1, col 2
A[2,1] # row 2, col 1
A[2, ] # all elements in row 2
A[, 2] # all elements in column 2 ] 

# create a vector
c <- c(1,2,3,4,5,6,7,8,9)
c
class(c)

c <- as.matrix(c)
class(c)
dim(c)

# reshape the vector into a 3x3 matrix
C <- matrix(c, nrow=3, ncol=3)
C

# create a vector from a column or row of a matrix
a1 <- as.matrix(A[, 1]) # vector from column 1
a1
dim(a1)

# transposition
A
t(A)

C
t(C)

a1t <- t(a1)
a1t
dim(a1t)

# addition
F <- A + B
F

dim(C)
dim(A)

## # A and C not same shape
## G <- A + C

# scalar multiplication
H <- 0.5*A
H

# element-by-element multipliction
P <- A*B
P

# matrix multiplication
Q <- C %*% A
Q
dim(C); dim(A)

## T <- A %*% B # not conformable
dim(A); dim(B)

# diagonal matrix
D <- diag(c(6,2,1,3), nrow=4, ncol=4)
D

# identity matrix
I <- diag(1, nrow=4, ncol=4)
I

# Euclidean norm of a vector
anorm <- sqrt(t(a1) %*% a1)
anorm

# a realistic matrix, orstationc temperature-variable correlation matrix
R <- cor(cbind(orstationc$tjan, orstationc$tjul, orstationc$tann))
R

# matrix inversion
Rinv <- solve(R)
Rinv

# check inverse
D <- R %*% Rinv
D

zapsmall(D)

# eigenvectors
E <- eigen(R)
E

