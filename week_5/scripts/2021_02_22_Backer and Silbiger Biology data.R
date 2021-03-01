### I am using the Backer and Silbiger Biology data for the first time
### We are learning how to join data today. 
### Created by: Anthony Gutierrez
### Created on: 2021-02-22
### Most recent update: 2021_02_28


### Load Libraries #####
library(tidyverse)
library(here)

### Load data #####
# Environmental data from each site
EnviroData <- read_csv(here("week_5", "data", "site.characteristics.data.csv"))
# Thermal performance data
TPCData<- read_csv(here("week_5","data", "Topt_data.csv"))

### View Data #####
View(EnviroData)
View(TPCData)

### Data Manipulation #####
EnviroData_wide<- EnviroData %>%
  pivot_wider(names_from = parameter.measured,
              values_from = values) %>%
  arrange(site.letter) # arrange dataframe by site

View(EnviroData_wide)

### Left Join###
#Description: need a key that is identical in both dataframes
             #(spelling, capitalization, everything).

FullData_left<- left_join(TPCData, EnviroData_wide)%>%  ## joining by = site.letter
  relocate(where(is.numeric), .after = where(is.character)) %>% #relocate all numeric data after the character data
  group_by(site.letter) %>% 
  summarize(means=mean(Values, na.rm = TRUE))

View(FullData_left)


Data_pivot_longer <-FullData_left %>%
  pivot_longer(cols = c(substrate.cover), 
               names_to = "measurements",
               values_to = "values") %>%
  group_by(site.letter, variables)
View(Data_pivot_longer)



### Creating your own Tibble ####
T1<- tibble(Site.ID = c("A", "B", "C", "D"),
           Temperature = c(14.1, 16.7, 15.3, 12.8))
T1

T2<- tibble(Site.ID = c("A", "B", "D", "E"),
           pH = c(7.3, 7.8, 8.1, 7.9))
T2

### left join vs right join #####
#The only difference is which dataframe is being used as the base.
left_join(T1, T2) #joins to T1
right_join(T1, T2) #jons to T2

### inner join v. full join #####
inner_join(T1, T2) #only keeps the data that is complete in both data sets
full_join(T1, T2) #keeps everything.

### Semi join and anti join #####
semi_join(T1, T2) #keeps all rows from the first data set where there are matching values in the second data set,
                  #keeping just columns from the first data set. 


anti_join(T1, T2) #only shows missing data
                  #This can help you find possible missing data across datasets.


### Awesome R package of the day #####
library(cowsay)
say("hello", by = "shark")
say("I want pets", by = "cat")
