# purled from lec15.Rmd

# Gottfried MS Thesis data (UO Dept. Geography)
attach(burn)
names(burn)

# examine variables
pairs(cbind(hotp,tmin,tmax,degday,trange,precip,dewpt,wind,api,adv))

plot(hotp ~ dewpt)

# linear model
burn_lm1 <- lm(hotp ~ dewpt)
burn_lm1
summary(burn_lm1)

# diagnostic plots
opar <- par(mfrow = c(2,2))
plot(burn_lm1, which=c(1,2,4))
hist(burn_lm1$residuals, breaks=20)
par <- opar

# plot regression line
opar <- par(mfrow = c(1,2))
plot(hotp ~ dewpt, ylim=c(0,1))
abline(burn_lm1)

# plot regression line again -- larger range
plot(hotp ~ dewpt, ylim=c(0,1), xlim=c(-40,40))
abline(burn_lm1)
par <- opar

# generalized linear model
burn_glm1 <- glm(hotp ~ dewpt, binomial(link = "logit"), weights=total)
burn_glm1
summary(burn_glm1)

# diagnostic plots
opar <- par(mfrow = c(2,2))
plot(burn_glm1, which=c(1,2,4))
hist(burn_glm1$residuals, breaks=20)
par <- opar

# evaluate predicted values
new_dewpt <- seq(-40,40,.2)
newdata <- data.frame(dewpt=new_dewpt)
hotp_pred1 <- predict(burn_glm1,newdata,type="resp")

# plot regression line
opar <- par(mfrow = c(1,2))
plot(hotp ~ dewpt, ylim=c(0,1))
lines(hotp_pred1 ~ new_dewpt, col="blue")

# plot regression line again
plot(hotp ~ dewpt, ylim=c(0,1), xlim=c(-40,40))
lines(hotp_pred1 ~ new_dewpt, col="blue")

# generalized linear model -- two predictors
burn_glm2 <- glm(hotp ~ dewpt*adv, binomial(link = "logit"), weights=total)
burn_glm2
summary(burn_glm2)

# compare models
anova(burn_glm1,burn_glm2,test="Chi")

# evaluate predicted values
new_dewpt <- seq(-40,40,.2)
new_adv0 <- rep(0,length(new_dewpt))
newdata_adv0 <- data.frame(dewpt=new_dewpt, adv=new_adv0)
hotp_pred2_adv0 <- predict(burn_glm2, newdata_adv0, type="resp")

new_adv1 <- rep(1,length(new_dewpt))
newdata_adv1 <- data.frame(dewpt=new_dewpt, adv=new_adv1)
hotp_pred2_adv1 <- predict(burn_glm2, newdata_adv1, type="resp")

opar <- par(mfrow = c(1,2))
# plot regression lines
plot(hotp ~ dewpt, ylim=c(0,1))
lines(hotp_pred2_adv0 ~ new_dewpt, col="green")
lines(hotp_pred2_adv1 ~ new_dewpt, col="magenta")
legend("topright", legend = c("no advisory", "advisory"), lty = c(1, 1), lwd = 2, 
    cex = 1, col = c("green", "magenta"))

# plot regression lines again
plot(hotp ~ dewpt, ylim=c(0,1), xlim=c(-40,40))
lines(hotp_pred2_adv0 ~ new_dewpt, col="green")
lines(hotp_pred2_adv1 ~ new_dewpt, col="magenta")
legend("topright", legend = c("no advisory", "advisory"), lty = c(1, 1), lwd = 2, 
    cex = 1, col = c("green", "magenta"))

# plot all
plot(hotp ~ dewpt, ylim=c(0,1), xlim=c(-40,40))
abline(burn_lm1)
lines(hotp_pred1 ~ new_dewpt, col="blue")
lines(hotp_pred2_adv0 ~ new_dewpt, col="green")
lines(hotp_pred2_adv1 ~ new_dewpt, col="magenta")
legend("topright", legend = c("OLS", "GLM", "GLM no advisory", "GLM advisory"), lty = c(1,1,1,1), lwd = 2, 
    cex = 1, col = c("black", "blue", "green", "magenta"))
detach(burn)

# examine variables
attach(island)
pairs(cbind(incidence,area,isolation,quality,enemy,competitors))

# simple model
island_glm1<-glm(incidence~area+isolation, binomial)
summary(island_glm1)

new_area <- seq(from=0, to=10, len=40); new_isolation <- seq(from=-2, to=12, len=40)
new_x <- expand.grid(area=new_area, isolation=new_isolation)
island_glm1_sfc  <- matrix(predict(island_glm1, new_x, type="response"),40,40)
persp(new_area, new_isolation, island_glm1_sfc, theta=-150, phi=20, d=1.5, 
  col="gray", ticktype="detailed",  zlim=c(0,1), xlab="Area", 
  ylab="Isolation", zlab = "Species Incidence")

# interaction
island_glm2<-glm(incidence~area*isolation, binomial)
summary(island_glm2)

island_glm2_sfc  <- matrix(predict(island_glm2, new_x, type="response"),40,40)
persp(new_area, new_isolation, island_glm2_sfc, theta=-150, phi=20, d=1.5, 
  col="gray", ticktype="detailed",  zlim=c(0,1), xlab="Area", 
  ylab="Isolation", zlab = "Species Incidence")

# compare models
anova(island_glm1,island_glm2,test="Chi")

island_glma<-glm(incidence ~ area, binomial)
summary(island_glma)
island_glmi<-glm(incidence ~ isolation, binomial)
summary(island_glmi)

par(mfrow=c(1,2))
xv<-seq(0,9,0.01)
yv<-predict(island_glma,list(area=xv),type="response")
plot(area,incidence)
lines(xv,yv, lwd=2)
xv2<-seq(0,10,0.1)
yv2<-predict(island_glmi,list(isolation=xv2),type="response")
plot(isolation,incidence)
lines(xv2,yv2, lwd=2)
par(mfrow=c(1,1))

attach(ozone_data)
pairs(ozone_data, panel=function(x,y) {points(x,y); lines(lowess(x,y), lwd=2, col="red")})

# load Hastie & Tibshirani-style GAM package
library(gam)
ozone_gam1 <- gam(ozone ~ s(rad)+s(temp)+s(wind))
summary(ozone_gam1)

opar <- par(mfrow=c(2,2))
plot(ozone_gam1, resid=T, pch=16)
par <- opar

# check for interactions
wt<-wind*temp
ozone_gam2 <- gam(ozone~s(temp)+s(wind)+s(rad)+s(wt))
summary(ozone_gam2)
opar <- par(mfrow=c(2,2))
plot(ozone_gam2, resid=T, pch=16)
par <- opar

# compare models
anova(ozone_gam1,ozone_gam2,test="F")

library(tree)
ozone_tree1 <-tree(ozone~.,data=ozone_data)
plot(ozone_tree1,type="u")
text(ozone_tree1)

attach(Pollute)
pairs(Pollute, panel=function(x,y) {points(x,y); lines(lowess(x,y))})

SO2Conc_tree1 <- tree(SO2Conc ~ . , Pollute)
plot(SO2Conc_tree1)
text(SO2Conc_tree1)

print(SO2Conc_tree1)

xcut <- 748
plot(SO2Conc ~ Industry)
lines(c(xcut,xcut),c(min(SO2Conc),max(SO2Conc)), col="blue", lwd=2, lty="dashed")
m1 <- mean(SO2Conc[Industry < xcut])
m2 <- mean(SO2Conc[Industry >= xcut])
lines(c(0,xcut),c(m1,m1), col="blue", lwd=2)
lines(c(xcut,max(Industry)),c(m2,m2), col="blue", lwd=2)

library(maptree)
data(oregon.env.vars, oregon.grid, oregon.border)
names(oregon.env.vars)
attach(oregon.env.vars)

# regression tree of Oregon environmental variables
model_tree1 <- "bird.spp ~ jan.temp+jul.temp+rng.temp+ann.ppt+min.elev+rng.elev+max.slope"
bird_tree1 <- rpart(model_tree1)
plot(bird_tree1)
text(bird_tree1)

# prune the tree
group <- group.tree(clip.rpart(rpart(model_tree1), best=7))
plot(clip.rpart(rpart(model_tree1), best=7))
text(clip.rpart(rpart(model_tree1), best=7))

# plot the regression tree
names(group) <- row.names(oregon.env.vars)
map.groups(oregon.grid, group=group)
map.key (0.05, 0.6, labels=as.character(seq(6)),pch=19, head="node")
lines(oregon.border)

draw.tree (clip.rpart(rpart(model_tree1), best=7), nodeinfo=TRUE, 
     units="species", cases="cells", cex=.7, pch=16, digits=0)

