dat <- read.csv("Data/Chinook_WA_Monthly.csv", stringsAsFactors = FALSE)
dat2 <- data.frame(Year=rep(1990:2015,each=12),Month=rep(month.abb,26),Species="Chinook",log.metric.tons=NA, metric.tons=NA)

for(yr in 1990:2015){
  for(i in month.abb){
    if(any(dat$Year==yr & dat$Month==i))
    dat2$metric.tons[dat2$Year==yr & dat2$Month==i] = dat$Metric.Tons[dat$Year==yr & dat$Month==i]
  }
}
dat2$metric.tons=as.numeric(dat2$metric.tons)
dat2$log.metric.tons = log(dat2$metric.tons)
chinook = dat2
save(chinook, file="Data/chinook.RData")
write.csv(chinook, file="Data/SalmonWAMonthly.csv", row.names=FALSE, quote=FALSE)
