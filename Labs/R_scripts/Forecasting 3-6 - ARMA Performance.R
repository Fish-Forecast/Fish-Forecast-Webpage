## ----setup, include=FALSE, message=FALSE---------------------------------
options(htmltools.dir.version = FALSE, servr.daemon = TRUE)
knitr::opts_chunk$set(fig.height=5, fig.align="center")
library(huxtable)

## ----load_data, echo=FALSE, message=FALSE, warning=FALSE-----------------
library(ggplot2)
library(gridExtra)
library(reshape2)
library(tseries)
library(forecast)

## ----load_data2, message=FALSE, warning=FALSE----------------------------
load("landings.RData")
landings$log.metric.tons = log(landings$metric.tons)

## ------------------------------------------------------------------------
spp <- "Anchovy"
training = subset(landings, Year <= 1987)
test = subset(landings, Year >= 1988 & Year <= 1989)

traindat <- subset(training, Species==spp)$log.metric.tons
testdat <- subset(test, Species==spp)$log.metric.tons
plot(1964:1987, traindat, xlim=c(1964,1989))
points(1988:1989, testdat, pch=2)

## ------------------------------------------------------------------------
far2 <- function(x, h){
  forecast(Arima(x, order=c(2,1,0)), h=h)
  }
e <- tsCV(anchovy, far2, h=1)
#RMSE
sqrt(mean(e^2, na.rm=TRUE))

