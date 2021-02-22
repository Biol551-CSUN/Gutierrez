### I am using the palmerpenguins dataset for the third time 
### We are learning how to wrangle data today. 
### Created by: Anthony Gutierrez
### Created on: 2021-02-15
##########################################


### load libraries #####
library(tidyverse)
library(palmerpenguins)
library(here)
glimpse(penguins)

###filter for sex, F ###
filter(.data = penguins, sex ==  "female")
###filter for year 2008 ###
filter(.data = penguins, year == "2008")
###filter for body_mass_g ###
filter(.data = penguins, body_mass_g > "5000")

###multiple filters ###
filter(.data = penguins, sex == "female", body_mass_g > "4000")

filter(.data = penguins, year == "2008" | year== "2009")
filter(.data = penguins, island != "dream")
filter(.data = penguins, species == "adelie" | species == "gentoo")


### Mutation ###
data2<- mutate(.data = penguins, 
               body_mass_kg = body_mass_g/1000,
               bill_length_depth_ratio = bill_length_mm/bill_depth_mm)
#convert body mass from g to kg
#Find ratio of bill length to bill depth
View(data2)

data3<- mutate(.data = penguins,
               after_2008 = ifelse(year>=2008, "After 2008", "Before 2008"))
view(data3)
#produce column for data before and after 2008

data4<- mutate(.data = penguins, 
               lengthmass = (flipper_length_mm + body_mass_g)) 

data5<- mutate(.data = penguins,
               sex_cap = ifelse(sex == "male", "Male", "Female"))
#Capatalize sexes
view(data5)

### Practice Pipe ###
penguins %>% #use penguin dataframe
  filter(sex == "female") %>% #select females
  mutate(log_mass = log(body_mass_g))%>% #calculate log biomass
  select(Species = species, Island = island, Sex = sex, log_mass)
view()

penguins %>% 
  group_by(island, sex) %>%
  summarise(mean_flipper = mean(flipper_length_mm, na.rm=TRUE),#drops all NAs
            min_flipper = min(flipper_length_mm, na.rm=TRUE),
            max_bill_length = max(bill_length_mm, na.rm=TRUE))

penguins %>%
  drop_na(sex) %>% #drops rows with NAs from specific column 
  group_by(island, sex) %>%
  summarize(mean_bill_length = mean(bill_length_mm, na.rm =TRUE))

#You can pipe directly into a plot
penguins %>%
  drop_na(sex) %>%
  ggplot(aes(x = sex, y = flipper_length_mm))+ #plots have a plus
  geom_boxplot()

