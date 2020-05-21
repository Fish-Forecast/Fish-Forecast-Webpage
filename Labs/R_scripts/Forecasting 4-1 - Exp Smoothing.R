## ----setup, include=FALSE, message=FALSE--------------------------------------
options(htmltools.dir.version = FALSE, servr.daemon = TRUE)
knitr::opts_chunk$set(fig.height=5, fig.align="center")
library(huxtable)


## ----echo=FALSE---------------------------------------------------------------
plot(1987:1964, c(1,rep(0,23)), lwd=2, ylab="weight", xlab="", type="l")
title("weight put on past values for 1988 forecast")


## ----echo=FALSE---------------------------------------------------------------
alpha <- 0.8
plot(1987:1964, alpha^(1:24), lwd=2, ylab="weight", xlab="", type="l")
title("more weight put on more recent values\nfor 1988 forecast")


## ----echo=FALSE---------------------------------------------------------------
alpha <- 1
wts <- alpha*(1-alpha)^(0:23)
plot(1987:1964, wts/sum(wts), lwd=2, ylab="weight", xlab="", type="l")
alpha <- 0.5
wts <- alpha*(1-alpha)^(0:23)
lines(1987:1964, wts/sum(wts), lwd=2, col="blue")
alpha <- 0.05
wts <- alpha*(1-alpha)^(0:23)
lines(1987:1964, wts/sum(wts), lwd=2, col="red")
legend("topleft", c("alpha=1 like naive","alpha=0.5","alpha=0.05 like mean"),lwd=2, col=c("black","blue","red"))
title("more weight put on more recent values\nfor 1988 forecast")


## ----load_data_exp_smoothing--------------------------------------------------
data(greeklandings, package="FishForecast")
anchovy <- subset(greeklandings, 
                  Species=="Anchovy" & Year<=1987)$log.metric.tons
anchovy <- ts(anchovy, start=1964)
library(forecast)


## ----fit.ann------------------------------------------------------------------
fit <- ets(anchovy, model="ANN")
fr <- forecast(fit, h=5)


## -----------------------------------------------------------------------------
plot(fr)


## -----------------------------------------------------------------------------
fit


## ----ann.weighting, echo=FALSE------------------------------------------------
alpha <- coef(fit)[1]
wts <- alpha*(1-alpha)^(0:23)
plot(1987:1964, wts/sum(wts), lwd=2, ylab="weight", xlab="", type="l")
title("Weighting for simple exp. smooth of anchovy")


## -----------------------------------------------------------------------------
fit1 <- ets(anchovy, model="ANN")


## ----fit.new.ann--------------------------------------------------------------
dat <- subset(landings, Species=="Anchovy" & Year>=2000 & Year<=2007)
dat <- ts(dat$log.metric.tons, start=2000)
fit2 <- ets(dat, model=fit1)
fr2 <- forecast(fit2, h=5)


## -----------------------------------------------------------------------------
plot(fr2)


## ----fig.height=4.5-----------------------------------------------------------
fit.rwf <- Arima(anchovy, order=c(0,1,0), include.drift=TRUE)
fr.rwf <- forecast(fit.rwf, h=5)
plot(fr.rwf)


## -----------------------------------------------------------------------------
coef(fit.rwf)


## -----------------------------------------------------------------------------
mean(diff(anchovy))


## -----------------------------------------------------------------------------
plot(diff(anchovy),ylim=c(-0.3,.3))
abline(h=0, col="blue")
abline(h=mean(diff(anchovy)),col="red")
title("0 means no change")


## ----echo=FALSE---------------------------------------------------------------
alpha <- 1
wts <- alpha*(1-alpha)^(0:23)
plot(1987:1964, wts/sum(wts), lwd=2, ylab="weight", xlab="", type="l")
alpha <- 0.5
wts <- alpha*(1-alpha)^(0:23)
lines(1987:1964, wts/sum(wts), lwd=2, col="blue")
alpha <- 0.05
wts <- alpha*(1-alpha)^(0:23)
lines(1987:1964, wts/sum(wts), lwd=2, col="red")
legend("topleft", c("beta=1","beta=0.5","beta=0.05 like naive"),lwd=2, col=c("black","blue","red"))
title("more weight put on more recent values\nfor 1988 forecast")


## -----------------------------------------------------------------------------
fit <- ets(anchovy, model="AAN")
fr <- forecast(fit, h=5)
plot(fr)


## ----fig.height=4-------------------------------------------------------------
autoplot(fit)


## ----echo=FALSE---------------------------------------------------------------
spp <- "Anchovy"
training = subset(greeklandings, Year <= 1987)
test = subset(greeklandings, Year >= 1988 & Year <= 1989)

traindat <- ts(subset(training, Species==spp)$log.metric.tons, start=1964)
testdat <- ts(subset(test, Species==spp)$log.metric.tons, start=1988)


## ----fig.height=4-------------------------------------------------------------
fit1 <- ets(traindat, model="AAN")
h=length(testdat)
fr <- forecast(fit1, h=h)
plot(fr)
points(end(traindat)[1]+1:h, testdat, pch=2, col="red")
legend("topleft", c("forecast","actual"), pch=c(20,2), col=c("blue","red"))


## -----------------------------------------------------------------------------
accuracy(fr, testdat)


## ----subset.anch, echo=FALSE--------------------------------------------------
spp <- "Anchovy"
training = subset(landings, Year <= 1989)
traindat <- subset(training, Species==spp)$log.metric.tons


## ----def.far2-----------------------------------------------------------------
far2 <- function(x, h, model){
  fit <- ets(x, model=model)
  forecast(fit, h=h)
  }


## -----------------------------------------------------------------------------
e <- tsCV(traindat, far2, h=1, model="AAN")
e


## -----------------------------------------------------------------------------
e[2]


## -----------------------------------------------------------------------------
TT <- 2 # end of the temp training data
temp <- traindat[1:TT]
fit.temp <- ets(temp, model="AAN")
fr.temp <- forecast(fit.temp, h=1)
traindat[TT+1] - fr.temp$mean


## -----------------------------------------------------------------------------
e[3]


## -----------------------------------------------------------------------------
TT <- 3 # end of the temp training data
temp <- traindat[1:TT]
fit.temp <- ets(temp, model="AAN")
fr.temp <- forecast(fit.temp, h=1)
traindat[TT+1] - fr.temp$mean


## ---- message=FALSE, warning=FALSE--------------------------------------------
fit1 <- ets(traindat, model="AAN")
e <- tsCV(traindat, far2, h=1, model=fit1)
e


## ----rmse---------------------------------------------------------------------
rmse <- sqrt(mean(e^2, na.rm=TRUE))


## ----mae----------------------------------------------------------------------
mae <- mean(abs(e), na.rm=TRUE)

