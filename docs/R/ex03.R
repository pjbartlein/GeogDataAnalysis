# purled from ex03.Rmd

ls()

names(sumcr)
attach(sumcr)

plot(CumLen, DepthWS)   # X-axis variable first, Y-axis variable second

detach(sumcr)

orstationc <- read.csv("../data/orstationc.csv", as.is=T)

orstationc <- read.csv(file.choose(), as.is=T)

attach(orstationc)
plot(lon, lat)

text(lon, lat, labels=station)

plot(elev, pann)

identify(elev, pann, labels=station)

attach(sumcr)
summary(WidthWS)

tapply(WidthWS, Reach, summary)

cor(elev, pann)

plot(orstationc[,2:10])
cor(orstationc[,2:10])

detach(orstationc)

attach(sumcr)
plot(WidthWS ~ CumLen)

loess.model <- loess(WidthWS ~ CumLen)
loess.model
hat <- predict(loess.model)
lines(CumLen[order(CumLen)], hat[order(CumLen)], col="red")
