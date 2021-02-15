### I am using the palmerpenguins dataset for the second time 
### Created by: Anthony Gutierrez
### Created on: 2021-02-09
##########################################


### load libraries #####
library(tidyverse)
library(palmerpenguins)
library(here)
glimpse(penguins)


### plotting #####
plot1<- ggplot(data=penguins,
  mapping = aes(x = bill_depth_mm,
                y = bill_length_mm,
                group = species,
                color = species)) +
  geom_point()+
  geom_smooth(method = "lm")+
    labs(x = "Bill depth (mm)", 
         y = "Bill length (mm)"
         )+
  scale_color_ghibli_d("MononokeMedium")+
  
  #coord_flip() flip x and y axes
  #coord_fixed()
  #coord_polar("x") #makes it circular
  
  #theme_classic()
  theme_bw()+
  theme(axis.title = element_text(size = 20,
                                  color = "red"),
        panel.background = element_rect(fill = "linen"))+
  ggsave(here("week_3", "output", "penguin.png"),
         width = 7, height = 5)
#can download and use any color theme  

###Second plot#####
ggplot(diamonds, aes(carat, price))+
  geom_point()