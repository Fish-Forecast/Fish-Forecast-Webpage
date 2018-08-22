## ----setup, include=FALSE, message=FALSE---------------------------------
options(htmltools.dir.version = FALSE, servr.daemon = TRUE)
library(huxtable)

## ----load_data, fig.align = "center", fig.height = 4, fig.width = 8------
load("Data/landings.RData")
landings$log.metric.tons = log(landings$metric.tons)
landings = subset(landings, Year <= 1989)
landings = subset(landings, Species %in% c("Anchovy","Sardine"))
library(ggplot2)
ggplot(landings, aes(x=Year, y=log.metric.tons)) +
  geom_line() + facet_wrap(~Species)

