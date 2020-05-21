## ----setup, include=FALSE, message=FALSE--------------------------------------
options(htmltools.dir.version = FALSE, servr.daemon = TRUE)
knitr::opts_chunk$set(fig.height=5, fig.align="center")
library(huxtable)


## ----load_data, echo=FALSE, message=FALSE, warning=FALSE----------------------
library(ggplot2)
library(gridExtra)
library(reshape2)
library(tseries)
library(forecast)


## -----------------------------------------------------------------------------
load("chinook.RData")
head(chinook)


## -----------------------------------------------------------------------------
chinookts <- ts(chinook$log.metric.tons, start=c(1990,1), 
                frequency=12)


## -----------------------------------------------------------------------------
plot(chinookts)


## ---- echo=FALSE--------------------------------------------------------------
set.seed(123)
yr=10
s=12
sd=sqrt(.1)
mu=0.05
st=sin(pi*(1:(s*yr))/(s/2))
mt=mu*(1:(s*yr))
et=rnorm(s*yr,0,sd)
xt=mt+st+et
xt=ts(xt,start=1,frequency=12)
plot(xt)


## -----------------------------------------------------------------------------
plot(diff(xt,lag=12))


## -----------------------------------------------------------------------------
forecast::Arima(xt, seasonal=c(0,1,1), include.drift=TRUE)


## -----------------------------------------------------------------------------
forecast::auto.arima(xt, stepwise=FALSE)


## ---- echo=FALSE--------------------------------------------------------------
set.seed(123)
yr=10
s=12
sd=sqrt(.1)
mu=0.05
beta=.2
st=(1+beta*rep(1:yr, each=s))*sin(pi*(1:(s*yr))/(s/2))
st=beta*rep(1:yr, each=s)*sin(pi*(1:(s*yr))/(s/2))
mt=mu*(1:(s*yr))
et=rnorm(s*yr,0,sd)
xt=mt+st+et
xt=ts(xt,start=1,frequency=12)
plot(xt)


## -----------------------------------------------------------------------------
forecast::Arima(xt, seasonal=c(0,2,2))


## -----------------------------------------------------------------------------
forecast::auto.arima(xt, stepwise=FALSE)


## ---- echo=FALSE--------------------------------------------------------------
set.seed(100)
yr=10
s=12
sd=sqrt(.1)
mu=0.05
beta=.1*(rep(1:yr, each=s)^2-2*5*rep(1:yr, each=s)+30)
st=beta*sin(pi*(1:(s*yr))/(s/2))
mt=mu*(1:(s*yr))
et=rnorm(s*yr,0,sd)
xt=mt+st+et
xt=ts(xt,start=1,frequency=12)
plot(xt)


## -----------------------------------------------------------------------------
traindat <- window(chinookts, c(1990,10), c(1998,12))
testdat <- window(chinookts, c(1999,1), c(1999,12))
fit <- forecast::auto.arima(traindat)
fit


## -----------------------------------------------------------------------------
fr <- forecast::forecast(fit, h=12)
plot(fr)
points(testdat)


## ----echo=FALSE---------------------------------------------------------------
plot(fr)

