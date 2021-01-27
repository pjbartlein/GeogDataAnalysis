# purled from loc04.Rmd

# load(".Rdata")

# dataframe summary
summary(scanvote) 

# attach dataframe
attach(scanvote)

# mean of Yes by Country
tapply(Yes, Country, mean)

# summary by Country
tapply(Yes, Country, summary)

## # detach the scanvote dataframe
## detach(scanvote)

tapply(sumcr$WidthWS, sumcr$Reach, mean)

# bivariate descriptive statistics with the cities dataframe
attach(cities)
plot(cities[,2:12], pch=16, cex=0.6)  # scatter plot matrix, omit city name
cov(cities[,2:12])   # covariance matrix
cor(cities[,2:12])   # correlation matrix
detach(cities)

# scatter plot with smooth
attach(sumcr)
plot(CumLen, WidthWS)
lines(lowess(CumLen, WidthWS), col="blue", lwd=2)

cor(CumLen, WidthWS)

# attach the sumcr dataframe
detach(sumcr)

# descriptive plots for categorical data
ReachHU_table <- table(Reach, HU)   # tabluate Reach and HU data
ReachHU_table

dotchart(ReachHU_table)
barplot(ReachHU_table)
mosaicplot(ReachHU_table, color=T)

# Chi-squared statistic
ReachHU_table <- table(Reach,HU)
ReachHU_table
chisq.test(ReachHU_table)

detach(sumcr)

# crosstab & Chi-square -- Sierra Nevada TSum and PWin groups
attach(sierra)
plot(PWin, TSum)
PWin_group <- cut(PWin, 3) 
TSum_group <- cut(TSum, 3)
TSumPWin_table <- table(TSum_group, PWin_group)
TSumPWin_table
chisq.test(TSumPWin_table)
detach(sierra)

# crosstab & Chi-square -- Oregon station elevation and tann
attach(orstationc)
plot(elev, tann)
elev_group <- cut(elev, 3)
tann_group <- cut(tann, 3)
elevtann_table <- table(elev_group, tann_group)
elevtann_table
chisq.test(elevtann_table)

x <- seq(0, 25, by = .1)
pdf <- dchisq(x, 4)
plot(pdf ~ x, type="l")

