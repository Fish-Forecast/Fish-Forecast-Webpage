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

## ---- echo=FALSE, eval=FALSE---------------------------------------------
## library(RCurl)
## library(XML)
## library(stringr)
## lat <- c(39,39,40)
## lon <- c(24,25,25)
## covs <- list()
## for(i in 1:3){
##   loc <- paste0("[(",lat[i],".5):1:(",lat[i],".5)][(",lon[i],".5):1:(",lon[i],".5)]")
##   url <- paste0("https://coastwatch.pfeg.noaa.gov/erddap/griddap/esrlIcoads1ge.htmlTable?air[(1964-01-01):1:(2018-08-01T00:00:00Z)]",loc,",slp[(1964-01-01):1:(2018-08-01T00:00:00Z)]",loc,",sst[(1964-01-01):1:(2018-08-01T00:00:00Z)]",loc,",vwnd[(1964-01-01):1:(2018-08-01T00:00:00Z)]",loc,",wspd3[(1964-01-01):1:(2018-08-01T00:00:00Z)]",loc)
## doc <- getURL(url)
## cov <- readHTMLTable(doc, which=2, stringsAsFactors=FALSE)
## coln <- paste0(colnames(cov),".",cov[1,])
## coln <- str_replace(coln, "\n", "")
## coln <- str_replace_all(coln, "[*]", "")
## cov <- cov[-1,]
## colnames(cov) <- coln
## cov[,1] <- as.Date(cov[,1])
## for(j in 2:dim(cov)[2]) cov[,j] <- as.numeric(cov[,j])
## covs[[i]] <- cov
## }
## covsmean <- covs[[1]]
## for(j in 2:dim(cov)[2])
##   covsmean[,j] <- apply(cbind(covs[[1]][,j], covs[[2]][,j], covs[[3]][,j]),1,mean,na.rm=TRUE)
## covsmean <- covsmean[,c(-2,-3)]
## covsmean$Year <- as.factor(format(cov[,1],"%Y"))
## covsmean.mon <- covsmean
## covsmean.year <- data.frame(Year=unique(covsmean$Year))
## for(j in 2:(dim(covsmean)[2]-1)) covsmean.year <- cbind(covsmean.year, tapply(covsmean[,j], covsmean$Year, mean, na.rm=TRUE))
## colnames(covsmean.year) <- c("Year",colnames(covsmean)[2:(dim(covsmean)[2]-1)])
## save(landings, covs, covsmean.mon, covsmean.year, file="landings.RData")

## ----load_data2, message=FALSE, warning=FALSE, echo=FALSE----------------
load("landings.RData")

