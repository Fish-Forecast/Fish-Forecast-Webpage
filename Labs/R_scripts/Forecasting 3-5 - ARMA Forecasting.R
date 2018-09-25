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

## ----load_data2, message=FALSE, warning=FALSE, echo=FALSE----------------
load("landings.RData")
landings$log.metric.tons = log(landings$metric.tons)
landings = subset(landings, Year <= 1987)
anchovy = subset(landings, Species=="Anchovy")$log.metric.tons
sardine = subset(landings, Species=="Sardine")$log.metric.tons

## ------------------------------------------------------------------------
fit <- Arima(anchovy, order=c(2,1,0))
coef(fit)

## ------------------------------------------------------------------------
anchovy[24]+coef(fit)[1]*(anchovy[24]-anchovy[23])+
  coef(fit)[2]*(anchovy[23]-anchovy[22])

## ------------------------------------------------------------------------
forecast(fit, h=1)

## ------------------------------------------------------------------------
fit <- auto.arima(sardine, test="adf")
fr <- forecast(fit, h=5)
fr

## ------------------------------------------------------------------------
plot(fr, xlab="Year")

## ------------------------------------------------------------------------
fit <- auto.arima(anchovy)
fr <- forecast(fit, h=5)
plot(fr)

## ------------------------------------------------------------------------
anchovy.miss <- anchovy
anchovy.miss[10:14] <- NA
fit <- auto.arima(anchovy.miss)
fr <- forecast(fit, h=5)
plot(fr)

## ------------------------------------------------------------------------
dat <- subset(landings, Species=="Chub.mackerel")$log.metric.tons
fit <- auto.arima(dat)
fr <- forecast(fit, h=5)
plot(fr, ylim=c(6,10))

## ------------------------------------------------------------------------
fit.naive <- naive(anchovy)
fr.naive <- forecast(fit.naive, h=5)
plot(fr.naive)

## ------------------------------------------------------------------------
fit.rwf <- rwf(anchovy, drift=TRUE)
fr.rwf <- forecast(fit.rwf, h=5)
plot(fr.rwf)

## ------------------------------------------------------------------------
fit.mean <- Arima(anchovy, order=c(0,0,0))
fr.mean <- forecast(fit.mean, h=5)
plot(fr.mean)

