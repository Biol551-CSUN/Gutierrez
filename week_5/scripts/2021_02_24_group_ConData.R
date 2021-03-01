### I will be learning how to manage dates and times
### Using Lubridate package
### Created by: Anthony Gutierrez and Group 
### Created on: 2021_02_24
### Updated on: 2021_03_01


### ### Load libraries #####
library(tidyverse)
library(here)
library(lubridate)
library(ggplot2)
library(scales)

### Glimpse and View into data ###
glimpse(Condata)
view(Condata)
View(DepthData)
view(Condata_join)


#Open the data
Condata <- read_csv(here("week_5", "data", "CondData.csv"))
DepthData <- read_csv(here("week_5", "data", "DepthData.csv"))

### Covert columns and join #####
Condata <- Condata %>%
  mutate(date = ymd_hms(date),
         date = round_date(date, "10 secs"))

DepthData <- DepthData %>%
  mutate(date = ymd_hms(date))


### Join the Data #####
Condata_join <- inner_join(Condata, DepthData)# join in a way where only exact matches between the two dataframes are kept)


### Data manipulation #####
means <- Condata_join %>%
  mutate(Hour = hour(date), 
         Minute = minute(date)) %>%
  group_by(Hour, Minute) %>% 
  summarize(mean_date=mean(date), 
            mean_Depth=mean(Depth), 
            mean_Temp=mean(TempInSitu),
            mean_Salinity=mean(SalinityInSitu_1pCal)) %>%
  pivot_longer(cols = c(4:6), 
               names_to = "variables", 
               values_to = "means") %>%
  mutate(Minute = sprintf("%02d", Minute)) %>%
  unite(col = "Hr_Min", 
        c(Hour,Minute), 
        sep = ".",
        remove = FALSE)

means$Hr_Min <- as.numeric(means$Hr_Min)


### Plotting #####
ggplot(means, aes(x=mean_date, y=means, color=factor(variables))) +
  geom_point() +
  facet_wrap(variables~., nrow=3, ncol=1, scales="free", 
             labeller = labeller(variables = 
                                   c("mean_Depth" = "Depth",
                                     "mean_Temp" = "Temperature",
                                     "mean_Salinity" = "Salinity in situ 1pCal"))) +
  theme_bw() +
  theme(legend.position = "none", legend.text = element_text(size=9), 
        legend.title = element_text(size=9), legend.margin = margin(0),
        strip.background = element_rect(fill = "white", color = "white"),
        strip.text.x = element_text(size=10, hjust=0, face="bold")) +
  labs(y="Mean per Minute", x="Time", title="") +
  ggsave(here("week_5", "outputs", "Ground_Water_Depth_and_Cond.png"))

