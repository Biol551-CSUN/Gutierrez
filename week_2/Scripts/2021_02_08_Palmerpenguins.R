### This is my second script. I am learning how to ggplot
### Created by: Anthony Gutierrez
### Created on: 2021-02-08 because I did not folow in class
##########################################


### load libraries #####
library(tidyverse)
library(palmerpenguins)


### plotting ###
ggplot(data=penguins,
  mapping = aes(x = bill_depth_mm,
                y = bill_length_mm,
                color = species,
                shape = island,
                size = body_mass_g,
                alpha = flipper_length_mm)) +
geom_point() +
  labs(title = "Bill depth and length",
       subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
       x = "Bill depth (mm)", y = "Bill length (mm)",
       color = "Species",
       caption = "Source: Palmer Station LTER / palmerpenguins package") +
scale_color_viridis_d()


### Facets ###
ggplot(data=penguins,
       aes(x = bill_depth_mm,
           y = bill_length_mm,
           color = species)) +
  geom_point() +
  scale_color_viridis_d() +
  facet_grid(species~sex) +
  guides(color = FALSE)


ggplot(data=penguins,
  mapping = aes(x = bill_depth_mm,
           y = bill_length_mm,
           color = species)) +
  geom_point() +
  facet_wrap(~ species, ncol=2)