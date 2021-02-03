### This is my first script. I am learning how to import data
### Created by: Anthony Gutierrez
### Created on: 2021-02-03
##########################################


### load libraries #####
library(tidyverse)
library(here)

### Read in data #####
WeightData<- read_csv(here("week_2","Data","weightdata.csv"))

### Data analysis #####
head(WeightData)
tail(WeightData)
view(WeightData)
