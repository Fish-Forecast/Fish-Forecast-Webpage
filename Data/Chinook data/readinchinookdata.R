yr1 = 1990; yr2 = 2016
dat <- read.csv("Data/Chinook data/WA_MONTHLY_LANDINGS.txt", stringsAsFactors = FALSE)
dat2 <- data.frame(Year=rep(yr1:yr2,each=12),Month=rep(month.abb,length(yr1:yr2)),Species="Chinook", State="WA", log.metric.tons=NA, metric.tons=NA, Value=NA)

for(yr in yr1:yr2){
  for(i in month.abb){
    if(any(dat$Year==yr & dat$Month==i)){
    dat2$metric.tons[dat2$Year==yr & dat2$Month==i] = dat$Metric.Tons[dat$Year==yr & dat$Month==i]
    dat2$Value[dat2$Year==yr & dat2$Month==i] = dat$X.[dat$Year==yr & dat$Month==i]
  }
  }
}
dat2$metric.tons=as.numeric(dat2$metric.tons)
dat2$Value=as.numeric(stringr::str_remove_all(dat2$Value,","))
dat2$log.metric.tons = log(dat2$metric.tons)
chinook.month = dat2

dat <- read.csv("Data/Chinook data/OR_MONTHLY_LANDINGS.txt", stringsAsFactors = FALSE)
dat2 <- data.frame(Year=rep(yr1:yr2,each=12),Month=rep(month.abb,length(yr1:yr2)),Species="Chinook", State="OR", log.metric.tons=NA, metric.tons=NA, Value=NA)

for(yr in yr1:yr2){
  for(i in month.abb){
    if(any(dat$Year==yr & dat$Month==i)){
      dat2$metric.tons[dat2$Year==yr & dat2$Month==i] = dat$Metric.Tons[dat$Year==yr & dat$Month==i]
      dat2$Value[dat2$Year==yr & dat2$Month==i] = dat$X.[dat$Year==yr & dat$Month==i]
    }
  }
}
dat2$metric.tons=as.numeric(dat2$metric.tons)
dat2$Value=as.numeric(stringr::str_remove_all(dat2$Value,","))
dat2$log.metric.tons = log(dat2$metric.tons)
chinook.month = rbind(chinook.month, dat2)
write.csv(chinook.month, file="Data/SalmonMonthly.csv", row.names=FALSE, quote=FALSE)

yr1 = 1950; yr2 = 2016
dat <- read.csv("Data/Chinook data/Chinook_ANNUAL_LANDINGS.txt", stringsAsFactors = FALSE)
states <- unique(dat$State)
dat2 <- data.frame(Year=rep(yr1:yr2, length(states)), 
                   Species="Chinook", State=rep(states, each=length(yr1:yr2)), 
                   log.metric.tons=NA, metric.tons=NA, Value=NA)
for(yr in yr1:yr2){
  for(state in states){
    if(any(dat$Year==yr & dat$State==state)){
      dat2$metric.tons[dat2$Year==yr & dat2$State==state] = dat$Metric.Tons[dat$Year==yr & dat$State==state]
      dat2$Value[dat2$Year==yr & dat2$State==state] = dat$X.[dat$Year==yr & dat$State==state]
    }
  }
}
dat2$metric.tons=as.numeric(stringr::str_remove_all(dat2$metric.tons,","))
dat2$Value=as.numeric(stringr::str_remove_all(dat2$Value,","))
dat2$log.metric.tons = log(dat2$metric.tons)
chinook.year = dat2
save(chinook.month, chinook.year, file="Data/chinook.RData")
write.csv(chinook.year, file="Data/SalmonYearly.csv", row.names=FALSE, quote=FALSE)
