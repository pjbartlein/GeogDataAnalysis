# purled from ex02.Rmd

# list files
ls()

# get the working directory
getwd()

# attach the sumcr dataframe
attach(sumcr)

# "index plot"
plot(Length)

# stripchart
stripchart(Length)

# stacked stripchart
stripchart(Length, method="stack")

dotchart(WidthWS)

# "Clevland" dot plot/chart
dotchart(WidthWS, labels=as.character(Location), cex=0.5)

# stacked dotplot
index <- order(WidthWS)
dotchart(WidthWS[index], labels=as.character(Location[index]), cex=0.5)

# boxplot
boxplot(Length)

# boxplot, different whiskers
boxplot(Length, range=0)

# detach sumcr dataframe
detach(sumcr)

# read the scanvote data set
scanvote <- read.csv("scanvote.csv", as.is=1)

# alternative read
scanvote <- read.csv(file.choose(), as.is=1)

# look at the structure of the scanvote data
str(scanvote)

# attach the scanvote dataframe
attach(scanvote)

# histogram
hist(Yes)

# histogram, specific number of breaks
hist(Yes, breaks=20)

# density plot
Yes.density <- density(Yes)
plot(Yes.density)

# composite plot
Yes.density <- density(Yes)
hist(Yes, breaks=20, probability=TRUE)
lines(Yes.density)
rug(Yes)