# purled from lec11.Rmd

anovadat[,'Group1']<-as.factor(anovadat[,'Group1'])
anovadat[,'Group2']<-as.factor(anovadat[,'Group2'])
anovadat[,'Group3']<-as.factor(anovadat[,'Group3'])
anovadat[,'Group4']<-as.factor(anovadat[,'Group4'])

str(anovadat)

k <- 3         # number of groups
n <- 750       # number of observations
x <- seq(0,10,by=0.1)
df1 <- k-1
df2 <- n-k
pdf_f <- df(x,df1,df2)
plot(pdf_f ~ x, type="l")

attach(anovadat)
boxplot(Data1 ~ Group1, ylim=c(-10,50), main="ANOVA Example 1")
tapply(Data1, Group1, mean)
tapply(Data1, Group1, sd)

boxplot(Data1 ~ Group1, ylim=c(0,20), main="ANOVA Example 1")

aov1 <- aov(Data1 ~ Group1)
aov1
summary(aov1)
hov1 <- bartlett.test(Data1 ~ Group1)
hov1

par(mfrow=c(2,2))
plot(aov1)
par(mfrow=c(1,1))

boxplot(Data2 ~ Group2, ylim=c(-10,50), main="ANOVA Example 2")
tapply(Data2, Group2, mean)
tapply(Data2, Group2, sd)

aov2 <- aov(Data2 ~ Group2)
aov2
summary(aov2)
hov2 <- bartlett.test(Data2 ~ Group2)
hov2

boxplot(Data3 ~ Group3, ylim=c(-10,50), main="ANOVA Example 3")
tapply(Data3, Group3, mean)
tapply(Data3, Group3, sd)

aov3 <- aov(Data3 ~ Group3)
aov3
summary(aov3)
hov3 <- bartlett.test(Data3 ~ Group3)
hov3

boxplot(Data4 ~ Group4, ylim=c(-10,50), main="ANOVA Example 4")
tapply(Data4, Group4, mean)
tapply(Data4, Group4, sd)

aov4 <- aov(Data4 ~ Group4)
aov4
summary(aov4)
hov4 <- bartlett.test(Data4 ~ Group4)
hov4

boxplot(Data5 ~ Group5, ylim=c(-10,50), main="ANOVA Example 5")
tapply(Data5, Group5, mean)
tapply(Data5, Group5, sd)

aov5 <- aov(Data5 ~ Group5)
aov5
summary(aov5)
hov5 <- bartlett.test(Data5 ~ Group5)
hov5
