### I am using the palmerpenguins dataset
### This is today's group project
### Comparison of Adelie penguin body mass by island 
### Created by: Anthony Gutierrez, Richard, Alyssa, 
### Created on: 2021-02-09
##########################################

### load libraries #####
library(tidyverse)
library(palmerpenguins)
library(here)
library(hrbrthemes)
library(viridis)


###plotting#####
penguins <- penguins %>% mutate(sex = fct_recode(sex, 
                                                 "Male" = "male", 
                                                 "Female" = "female"))

penguins %>% filter(sex == "Male" | sex == "Female") %>% 
  filter(species == "Adelie") %>% 
  ggplot(aes(x=sex, y=body_mass_g, fill=sex)) +
  geom_boxplot() +
  scale_fill_viridis(discrete = TRUE, alpha=0.6) +
  geom_jitter(color="black", size=0.4, alpha=0.9) +
  theme_bw() +
  theme(strip.background = element_rect(fill = "white", color = "white"),
        legend.position="none",
        plot.title = element_text(size=20)
  ) +
  facet_grid(~island) + 
  labs(y="Body Mass (g)", x="Sex", 
       title="Adelie Penguins Body Mass by Island")+
ggsave(here("week_3", "output", "penguingroup.png"), 
       width = 7, height = 5)
