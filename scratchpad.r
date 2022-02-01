######## 
##### https://davetang.org/muse/2013/05/09/on-curve-fitting/
#########

yAg <- c(6,7,8)
xAg <- c(1875000, 1900000, 2225000)
plot (xAg,yAg, pch = 20)

#fit first degree polynomial equation:
fitAg  <- lm(yAg~xAg)
#second degree
fit2Ag <- lm(yAg~poly(xAg,2,raw=TRUE))

#generate range of 50 numbers starting from 30 and ending at 160
xx <- seq(0,10000000, length=50)
plot(xAg,yAg,pch=19,ylim=c(0,30))
lines(xx, predict(fitAg, data.frame(xAg=xx)), col="red")
lines(xx, predict(fit2Ag, data.frame(xAg=xx)), col="green")

summary (fitAg)
summary(fit2Ag)
anova(fitAg, fit2Ag)

#y=ax + b
coef(fitAg)

curve((4.265e-06*x) - 1.566, from = 0, to = 3500000)

#####

yTo <- c(6,7,8)
xTo <- c(3100000, 3450000, 6950000)
plot (xTo,yTo, pch = 20)

#fit first degree polynomial equation:
fitTo  <- lm(yTo~xTo)
#second degree
fit2To <- lm(yTo~poly(xTo,2,raw=TRUE))

#generate range of 50 numbers starting from 30 and ending at 160
xx <- seq(0,10000000, length=50)
plot(xTo,yTo,pch=19,ylim=c(0,30))
lines(xx, predict(fitTo, data.frame(xTo=xx)), col="red")
lines(xx, predict(fit2To, data.frame(xTo=xx)), col="green")

summary (fitTo)
summary(fit2To)
anova(fitTo, fit2To)

#y=ax + b
coef(fitTo)

#####


yOt <- c(8,12,13)
xOt <- c(1975000, 2525000, 2825000)
plot (xOt,yOt, pch = 20)

#fit first degree polynomial equation:
fitOt  <- lm(yOt~xOt)
#second degree
fit2Ot <- lm(yOt~poly(xOt,2,raw=TRUE))

#generate range of 50 numbers starting from 30 and ending at 160
xx <- seq(0,10000000, length=50)
plot(xOt,yOt,pch=19,ylim=c(0,30))
lines(xx, predict(fitOt, data.frame(xOt=xx)), col="red")
lines(xx, predict(fit2Ot, data.frame(xOt=xx)), col="green")

summary (fitOt)
summary(fit2Ot)
anova(fitOt, fit2Ot)

#y=ax + b
coef(fitOt)

# y = -9.9x + 201110

curve((4.265e-06*x) - 1.566, from = 0, to = 3500000)
