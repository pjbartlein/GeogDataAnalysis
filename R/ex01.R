# ex01.R

setwd("/Users/bartlein/Documents/geog495/") # macOS
dir()

#setwd("c:\\Users\\bartlein\\Documents\\geog495\\data") # Windows
setwd("/Users/bartlein/Documents/geog495/data")  # Mac

sumcr <- read.csv("/Users/bartlein/Documents/geog495/data/sumcr.csv")

names(sumcr)

sumcr$WidthWS   # (works ok)
WidthWS   # (produces the error message 'Object "WidthWS" not found')

summary(sumcr)
