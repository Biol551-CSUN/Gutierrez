### I am using the palmerpenguins dataset for the third time 
### We are learning how to wrangle data today. 
### Created by: Anthony Gutierrez and Group
### Created on: 2021-02-15
### Most recent update: 2021_02_17

### load libraries #####
library(tidyverse)
library(palmerpenguins)
library(here)
glimpse(penguins)

##### Homework Assignment #####
# 1. Calculate the mean and variance of body mass by species,
#    island, and sex without any NAs
# 2. filters out (i.e. excludes) male penguins, then calculate
#    the log body mass, then selects olny the column for species,
#    island, sex, and log body mass, then uise these data to make 
#    any plot. Make sure the plot has clean and clear labels and 
#    follows best practices. Save the plot in the correct output 
#    folder.

### part 1 ###
penguins %>% 
  drop_na(sex) %>%
  group_by(species, island, sex) %>%
  summarise(mean_mass = mean(body_mass_g, na.rm=TRUE),
            var_body_mass = var(body_mass_g, na.rm=TRUE))
  
### part 2 ###
penguins %>%
  filter(sex == "female") %>% #select female)
  mutate(log_mass = log(body_mass_g)) %>% #calculate log biomass
  select(species, island, sex, log_mass) %>%
  ggplot(aes(x = island, y = log_mass)) +
  geom_boxplot()+
  theme(strip.background = element_rect(fill = "white", color = "white"),
        strip.text = element_text(face="bold", size=10), 
        legend.position="none", plot.title = element_text(face = "bold")) +
  facet_grid(species~.) + 
  labs(y="log Body Mass (g)", x="Island", 
       title = "Female Penguins by Species and Island") +
  ggsave(here("week_4", "outputs", "Group_Data_Wrangle_HW7.png"))
  
  