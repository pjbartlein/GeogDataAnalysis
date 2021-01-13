# purled from lec03.Rmd

load(".Rdata")

# use Oregon climate-station data 
attach(orstationc)
plot(elev,tann)

# detach orstationc dataframe
detach(orstationc)

# use Scandinavian EU vote data [scanvote.csv]
attach(scanvote)
plot(Pop, Yes)         # arithmetic axis

# logrithmic axis
plot(log10(Pop), Yes)  # logrithmic axis

detach(scanvote)

# use Oregon climate-station data [orstationc.csv]
attach(orstationc)
opar <- par(mar=c(5,4,4,5)+0.1) # space for second axis
plot(elev, tann)                # first plot
par(new=TRUE)                   # second plot is going to get added to first
plot(elev, pann, pch=3, axes=FALSE, ylab="")  # don't overwrite
axis(side=4)                    # add axis
mtext(side=4,line=3.8,"pann")   # add label
legend("topright", legend=c("tann","pann"), pch=c(1,3))

par(opar)  # restore plot par
detach(orstationc)

# use Specmap oxygen-isotope data
attach(specmap)
plot(Age, O18)

# points and line plot
plot(Age, O18, type="l")

plot(O18, Insol, type="o")

# detach the specmap dataframe
detach(specmap)

# use Oregon climate-station data 
attach(orstationc)
plot(elev, tann, type="l") # does this make sense?
detach(orstationc)

attach(scanvote)
plot(log10(Pop),Yes, pch=unclass(Country))  # different symbol
legend("bottomright", legend=levels(Country), pch=c(1:3))

# text plot
plot(log10(Pop),Yes, type="n")
text(log10(Pop),Yes, labels=as.character(Country)) # text

attach(scanvote)
# text plot
plot(log10(Pop), Yes, type="n")
text(log10(Pop), Yes, labels=as.character(District))
detach(scanvote)

# use Summit Cr. geomorph data 
attach(sumcr)
plot(unclass(Reach), unclass(HU))  # an extreme case

# jittered points
plot(jitter(unclass(Reach)), jitter(unclass(HU)))
detach(sumcr)

# use Florida 2000 presidential election data [florida.csv]
attach(florida)
plot(BUSH, GORE)
plot(BUSH, jitter(GORE, factor=500))
detach(florida)

# use Sierra Nevada annual climate reconstructions
attach(sierra)
plot(PWin, TSum)  # scatter diagram

# sliced scatter diagram
PWin_classes <- c(0.0, 25., 50., 75., 100., 125., 150., 175.)
PWin_group <- cut(PWin, PWin_classes)
plot(TSum ~ PWin_group) # note formula in plot function call
detach(sierra)

# use Oregon climate station annual temperature data 
attach(ortann)
plot(elevation,tann)
lines(lowess(elevation,tann))
detach(ortann)

attach(florida)
plot(GORE, BUCHANAN)
identify(GORE, BUCHANAN, labels=County)
detach(florida)

# use large-cities data
attach(cities)
plot(cities[,2:12], pch=16, cex=0.6) # scatter plot matrix, omit city name
detach(cities)

attach(sumcr)
# "contingency table"
ReachHU_table <- table(Reach, HU)   # tabluate Reach and HU data
ReachHU_table

dotchart(ReachHU_table)
barplot(ReachHU_table)

# mosaic plot
mosaicplot(ReachHU_table, color=T)

## detach(sumcr)

