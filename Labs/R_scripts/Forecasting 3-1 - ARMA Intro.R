## ----setup, include=FALSE, message=FALSE---------------------------------
options(htmltools.dir.version = FALSE, servr.daemon = TRUE)
knitr::opts_chunk$set(fig.height=4)
library(huxtable)

## ----load_data, echo=FALSE, message=FALSE, warning=FALSE-----------------
load("landings.RData")
landings$log.metric.tons = log(landings$metric.tons)
landings = subset(landings, Year <= 1989)
anchovy = subset(landings, Species=="Anchovy")$log.metric.tons
sardine = subset(landings, Species=="Sardine")$log.metric.tons

library(ggplot2)
library(gridExtra)
library(reshape2)
library(tseries)
library(urca)

## ----arima.sim, fig.align="center"---------------------------------------
dat = arima.sim(n=1000, model=list(ar=c(.5,.3)))
plot(dat)
abline(h=0, col="red")

## ----arimavsrn, fig.align="center", echo=FALSE---------------------------
par(mfrow=c(1,2))
plot(dat[1:500],type="l",ylab="dat")
abline(h=0, col="red")
title("ar(2)")
plot(rnorm(length(dat))[1:500],type="l",ylab="dat",xlab="Time")
abline(h=0, col="red")
title("random normal")

## ----arimavsrncorr, fig.align="center", echo=FALSE-----------------------
par(mfrow=c(1,2))
TT=length(dat)
plot(dat[2:TT],dat[1:(TT-1)],type="p")
title("ar(2)")
rn=rnorm(length(dat))
plot(rn[2:TT],rn[1:(TT-1)],type="p")
title("random normal")

## ----acf, fig.align="center"---------------------------------------------
acf(dat[1:50])

## ----corr----------------------------------------------------------------
cor(dat[2:TT], dat[1:(TT-1)])
cor(dat[11:TT], dat[1:(TT-10)])

## ----acf2, fig.align="center", echo=FALSE--------------------------------
par(mfrow=c(1,2))
plot(dat[1:50], type="b", pch="x")
title("dat[1:50]")
acf(dat,lag.max=25)

## ----acf.random, fig.align="center",echo=FALSE---------------------------
rn <- rnorm(TT)
par(mfrow=c(1,2))
plot(rn[1:50], type="b", pch="x")
title("random 1:50")
acf(rn,lag.max=25)

## ----pacf.ar2, fig.align="center"----------------------------------------
pacf(dat)

## ----pacf.ar3, fig.align="center"----------------------------------------
dat <- arima.sim(TT, model=list(ar=c(.5)))
pacf(dat)

