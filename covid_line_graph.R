# Line Plot Imitation in R 

rm(list=ls())
getwd()
setwd("~/Desktop/covid-analysis-bootcamp")

covid <- read.csv("covid.csv")
attach(covid)

# filter countries & dates of interest
covid <- covid %>% 
  filter(date >= "2020-02-02", date <= "2020-05-08",
  location%in%c('China',
                'United States',
                'United Kingdom',
                'South Korea', 
                'China', 
                'World'))

library(plotly)

# add a log variable column for total cases per million
covid$log_total_cases_per_million <- log(covid$total_cases_per_million)

# plot 
plot <- plot_ly(covid, x = ~date, y = ~log_total_cases_per_million, 
                color = covid$location,
                type = 'scatter', mode = 'lines',
                line = list(width = 3)) %>%
  layout(title = "Total Confirmed COVID-19 Cases",
         xaxis = list(title = "Date"),
         yaxis = list (title = "Number Cases Confirmed (LOG)")) 

plot

# TO DO: fix x and y-axis with this:  
# https://plotly.com/r/axes/
  

