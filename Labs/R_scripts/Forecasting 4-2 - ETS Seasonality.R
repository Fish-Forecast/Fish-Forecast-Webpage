## ----setup, include=FALSE, message=FALSE--------------------------------------
options(htmltools.dir.version = FALSE, servr.daemon = TRUE)
knitr::opts_chunk$set(fig.height=5, fig.align="center")
library(huxtable)


## -----------------------------------------------------------------------------
load("chinook.RData")
head(chinook)


## -----------------------------------------------------------------------------
chinookts <- ts(chinook$log.metric.tons, start=c(1990,1), frequency=12)


## -----------------------------------------------------------------------------
plot(chinookts)


## -----------------------------------------------------------------------------
library(forecast)
traindat <- window(chinookts, c(1990,1), c(1999,12))
fit <- ets(traindat, model="AAA")
fr <- forecast(fit, h=24)
plot(fr)
points(window(chinookts, c(1996,1), c(1996,12)))


## ----fig.height=4-------------------------------------------------------------
autoplot(fit)


## ----fig.height=4-------------------------------------------------------------
fit <- ets(traindat, model="AAA", gamma=0.4)
autoplot(fit)


## -----------------------------------------------------------------------------
no_miss_dat <- fit$x
fit <- auto.arima(no_miss_dat)
fr <- forecast(fit, h=12)
plot(fr)
points(window(chinookts, c(1996,1), c(1996,12)))


## -----------------------------------------------------------------------------
fit <- auto.arima(traindat)
fr <- forecast(fit, h=12)
plot(fr)


## -----------------------------------------------------------------------------
fit <- ets(traindat, model="AAA", gamma=0.4)
fr <- forecast(fit, h=12)


## -----------------------------------------------------------------------------
testdat <- window(traindat, c(1996,1), c(1996,12))


## -----------------------------------------------------------------------------
accuracy(fr, testdat)


## -----------------------------------------------------------------------------
no_miss_dat <- fit$x
fit <- auto.arima(no_miss_dat)
fr <- forecast(fit, h=12)
accuracy(fr, testdat)

