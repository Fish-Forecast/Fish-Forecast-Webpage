## ----load-packages, include=FALSE, message=FALSE------------------------------
require(ggplot2)


## ----load_data, fig.align = "center", fig.height = 4, fig.width = 8-----------
data(greeklandings, package="FishForecast")
landings = subset(greeklandings, Year <= 1989 & Species %in% c("Anchovy","Sardine"))
ggplot(landings, aes(x=Year, y=log.metric.tons)) +
  geom_line() + facet_wrap(~Species)

