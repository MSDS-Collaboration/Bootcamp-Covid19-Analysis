setwd("~/Desktop/covid-analysis-bootcamp")
covid <- read.csv('covid.csv')
library(ggplot2)
library(plotly)
library(gganimate)
library(lubridate)
library(tidyverse)
summary(covid)
head(covid$date)
covid$date <- as.Date(covid$date)
g <- covid %>% 
  filter(location%in%c('China', 'United States', 'South Korea',  
                               'United Kingdom', 'World')) %>%
  select(date, total_cases, location, total_cases_per_million) %>%
  mutate(log_cases=log10(total_cases_per_million),
         location=ifelse(location=='United States','US',ifelse(location=='United Kingdom','UK',ifelse(location=='South Korea','Korea',ifelse(location=='China','China',ifelse(location=='World','World',0)))))
         ) %>%
  ggplot(aes(x=date, 
             y=log_cases, group=location)) + 
  geom_line(aes(color=location), alpha = 1, size=1.5) + 
  transition_reveal(date) + 
  view_follow(fixed_y = TRUE)+
  coord_cartesian(clip = 'off') + 
  enter_drift(x_mod = -1) + exit_drift(x_mod = 1) +
  geom_segment(aes(xend=max(date), 
                   yend = log_cases, color=location), 
               linetype=2) +
  geom_point(aes(color=location), size = 2) +
  geom_text(aes(x = max(date)+.1, 
                label = location), 
            hjust=0, size=3) + 
  theme_minimal() + 
  labs(y = "LOG",
       x = "Date",
       title = "Total confirmed COVID-19 cases per million people",
       subtitle = 'The number of confirmed cases is lower than the number of total cases. \nThe main reason for this is limited testing.') + 
  guides(fill=guide_legend(title="Country")) + 
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.y = element_blank(),
        panel.grid.minor.x = element_blank(),
        text = element_text(size = 16),
        legend.position = "none", 
        plot.title = element_text(hjust = 0.5, face='bold', size=12), 
        plot.subtitle = element_text(hjust=0.5, face='italic', size=10)) + 
  scale_color_discrete(name="Country")
  
animate(g, fps=7, renderer = gifski_renderer(loop=F)) 

anim_save('covid.gif', g)











