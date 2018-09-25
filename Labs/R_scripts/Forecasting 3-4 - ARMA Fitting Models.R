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
landings = subset(landings, Year <= 1987)
anchovy = subset(landings, Species=="Anchovy")$log.metric.tons
sardine = subset(landings, Species=="Sardine")$log.metric.tons

## ----fit.anchovy---------------------------------------------------------
library(forecast)
fit <- auto.arima(anchovy)

## ----echo=FALSE----------------------------------------------------------
res <- resid(fit)
LB <- Box.test(res, type="Ljung-Box", lag=12, fitdf=2)$statistic
meany <- mean(anchovy, na.rm=TRUE)
r2 <- 1- sum(resid(fit)^2,na.rm=TRUE)/sum((anchovy-meany)^2,na.rm=TRUE)

df <- data.frame(Model="(0,1,1)", theta1=-1*coef(fit)[1], drift=coef(fit)[2], R2 = r2, BIC=fit$bic, LB=LB)

## ----echo=FALSE, results = 'asis'----------------------------------------
knitr::kable(df, row.names=FALSE, format='html')

## ------------------------------------------------------------------------
coef(fit)

## ------------------------------------------------------------------------
res <- resid(fit)
meany <- mean(anchovy, na.rm=TRUE)
r2 <- 1- sum(res^2,na.rm=TRUE)/sum((anchovy-meany)^2,na.rm=TRUE)

## ------------------------------------------------------------------------
LB <- Box.test(res, type="Ljung-Box", lag=12, fitdf=2)$statistic

## ----fit.anchovy.trace---------------------------------------------------
auto.arima(anchovy, trace=TRUE)

## ------------------------------------------------------------------------
auto.arima(sardine)

## ------------------------------------------------------------------------
fit <- auto.arima(sardine, test="adf")
fit

## ----echo=FALSE----------------------------------------------------------
res <- resid(fit)
LB <- Box.test(res, type="Ljung-Box", lag=12, fitdf=0)$statistic
meany <- mean(sardine, na.rm=TRUE)
r2 <- 1- sum(resid(fit)^2,na.rm=TRUE)/sum((sardine-meany)^2,na.rm=TRUE)

df <- data.frame(Model="(0,1,0)", theta1=-1*coef(fit)[1], drift=coef(fit)[2], R2 = r2, BIC=fit$bic, LB=LB)

## ----echo=FALSE, results = 'asis'----------------------------------------
knitr::kable(df, row.names=FALSE, format='html')

## ------------------------------------------------------------------------
anchovy.miss <- anchovy
anchovy.miss[10:14] <- NA
fit <- auto.arima(anchovy.miss)
fit

## ------------------------------------------------------------------------
fit.AR2 <- Arima(anchovy, order=c(2,0,0))
fit.AR2

## ----fig.width=10, echo=FALSE, fig.align="center"------------------------
par(mfrow=c(1,2))
hist(subset(landings, Species=="Anchovy")$metric.tons, main="metric.tons", xlab="anchovy")
hist(anchovy, main="log.metric.tons",xlab="log anchovy")

## ----fig.align="center"--------------------------------------------------
fit <- auto.arima(anchovy)
checkresiduals(fit)

## ----fit.anchovy2--------------------------------------------------------
auto.arima(anchovy, stepwise=FALSE, approximation=FALSE)

