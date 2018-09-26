## ----setup, include=FALSE, message=FALSE---------------------------------
options(htmltools.dir.version = FALSE, servr.daemon = TRUE)
knitr::opts_chunk$set(fig.height=5, fig.align="center")
library(huxtable)

## ----load_packages, echo=FALSE, message=FALSE, warning=FALSE-------------
library(ggplot2)
library(gridExtra)
library(reshape2)
library(tseries)
library(forecast)

## ----load_data2, message=FALSE, warning=FALSE, echo=FALSE----------------
load("landings.RData")
landings$log.metric.tons = log(landings$metric.tons)

## ----echo=FALSE----------------------------------------------------------
spp <- "Anchovy"
training = subset(landings, Year <= 1987)
test = subset(landings, Year >= 1988 & Year <= 1989)

traindat <- subset(training, Species==spp)$log.metric.tons
testdat <- subset(test, Species==spp)$log.metric.tons
plot(1964:1987, traindat, xlim=c(1964,1989))
points(1988:1989, testdat, pch=2, col="red")
legend("topleft", c("Training data","Test data"), pch=c(1,2), col=c("black", "red"))

## ------------------------------------------------------------------------
fit1 <- auto.arima(traindat)
fr <- forecast(fit1, h=2)
fr

## ----echo=FALSE----------------------------------------------------------
plot(fr)
points(25:26, testdat, pch=2, col="red")
legend("topleft", c("forecast","actual"), pch=c(20,2), col=c("blue","red"))

## ------------------------------------------------------------------------
fr.err <- testdat - fr$mean
fr.err

## ------------------------------------------------------------------------
me <- mean(fr.err)
me

## ------------------------------------------------------------------------
rmse <- sqrt(mean(fr.err^2))
rmse

## ------------------------------------------------------------------------
mae <- mean(abs(fr.err))
mae

## ------------------------------------------------------------------------
fr.pe <- 100*fr.err/testdat
mpe <- mean(fr.pe)
mpe

## ------------------------------------------------------------------------
mape <- mean(abs(fr.pe))
mape

## ------------------------------------------------------------------------
accuracy(fr, testdat)[,1:5]

## ------------------------------------------------------------------------
c(me, rmse, mae, mpe, mape)

## ------------------------------------------------------------------------
# The model picked by auto.arima
fit1 <- Arima(traindat, order=c(0,1,1))
fr1 <- forecast(fit1, h=2)
test1 <- accuracy(fr1, testdat)[2,1:5]

# AR-1
fit2 <- Arima(traindat, order=c(1,1,0))
fr2 <- forecast(fit2, h=2)
test2 <- accuracy(fr2, testdat)[2,1:5]

# Naive model with drift
fit3 <- rwf(traindat, drift=TRUE)
fr3 <- forecast(fit3, h=2)
test3 <- accuracy(fr3, testdat)[2,1:5]

## ----results='asis', echo=FALSE------------------------------------------
sum.tests <- rbind(test1, test2, test3)
row.names(sum.tests) <- c("(0,1,1)","(1,1,0)","Naive")
sum.tests <- format(sum.tests, digits=3)
knitr::kable(sum.tests, format="html")

## ------------------------------------------------------------------------
far2 <- function(x, h, order){
  forecast(Arima(x, order=order), h=h)
  }
e <- tsCV(traindat, far2, h=1, order=c(0,1,1))
#RMSE
tsrmse1 <- sqrt(mean(e^2, na.rm=TRUE))
tsrmse1

## ------------------------------------------------------------------------
test1

## ------------------------------------------------------------------------
e <- tsCV(traindat, far2, h=4, order=c(0,1,1))
#RMSE
tsrmse4 <- sqrt(mean(e^2, na.rm=TRUE))
c(tsrmse1, tsrmse4)

