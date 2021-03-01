### I will be learning how to manage dates and times
### Using Lubridate package
### Created by: Anthony Gutierrez 
### Created on: 2021_02_24
### Updated on: 2021_02_28

### ### Load libraries #####
library(tidyverse)
library(here)
library(lubridate)

### What Time is it? #####
now(tzone = "EST") #what time is it now
am(now()) # is it morning?
today(tzone = "GMT")
leap_year(now()) # is it a leap year? 
today() # if you want the date and not the time 

### Date Formatting #####
ymd() #format year, month, day
mdy() #format month, day, year

ymd_hms("2021-02-24 10:22:20 PM")


# make a character string 
datetimes<- c("02/24/2021 22:22:20",
              "02/25/2021 11:21:10",
              "02/26/2021 8:01:52")

### extract from datetimes #####
datetimes<- mdy_hms(datetimes)
month(datetimes, label - TRUE, abbr = FALSE)#spell it out
day(datetimes) #extract day
wday(datetimes, label = TRUE) #extract by day of week

hour(datetimes)
minute(datetimes)
second(datetimes)


### Adding dates and times #####
datetimes + hours(4) # This adds 4 hours 
datetimes + days(2) # This adds 2 days


### Rounding dates ####
round_date(datetimes, "minute") # round to nearest minute
round_date(datetimes, "5 mins") # round to nearest 5 minutes

### Think, Pair, Share #####
Condata <- read_csv(here("week_5", "data", "CondData.csv"))
View(Condata)

Condata <- Condata %>%
  
  