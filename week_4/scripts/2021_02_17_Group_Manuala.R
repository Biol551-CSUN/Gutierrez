### I am going to practice tidy with biogeochemistry data from Hawaii
### We are learning how clean and pivot plot data today. 
### Created by: Anthony Gutierrez and Group
### Created on: 2021_02_17
### Updated on: 2021_02_21

### Load libraries #####
library(tidyverse)
library(here)
library(grid)
library(gridExtra)
library(gtable)


# Load Data ----
ChemData<-read_csv(here("Week_4","Data", "chemicaldata_maunalua.csv"))
View(ChemData)
glimpse(ChemData)

# Remove all the NA and separate Tide_time ----
ChemData_clean<-ChemData %>%
  filter(complete.cases(.)) %>% 
  separate(col = Tide_time, 
           into = c("Tide","Time"), 
           sep = "_")

# Subset data ----
# Filter out Night, keep only Day
ChemData_Day <- ChemData_clean %>% 
  filter(Time == "Day") %>% 
  select(-c("Time", "percent_sgd")) %>% 
  rename("Temp (C)" = Temp_in, 
         "Nitrate+Nitrite" = NN, 
         "Total Alkalinity" = TA)

# pivot_longer
ChemData_Day_long <-ChemData_Day %>%
  pivot_longer(cols = c(8:14), 
               names_to = "Variables",
               values_to = "Values")

# summary by Site, Season, Tide ----
ChemData_Day_long$Season <- as.factor(ChemData_Day_long$Season)

ChemData_Day_Summary <- ChemData_Day_long %>% 
  mutate(Season = fct_recode(Season, Spring = "SPRING", Fall = "FALL")) %>%
  group_by(Season, Tide, Variables) %>% 
  summarize(means=mean(Values, na.rm = TRUE), 
            variations=var(Values, na.rm = TRUE), 
            SEs=sd(Values, na.rm=TRUE)/sqrt(length(na.omit(Values))))


# plot ----
plot <- ggplot(ChemData_Day_Summary, aes(fill=Tide, x = Season, y = means))+
  geom_bar(stat='identity', position="dodge") +
  facet_wrap(~Variables, scales = "free") + 
  labs(y="Means", title="Hawai'i Water Chemistry by Season and Tide Level") + 
  theme_bw() + 
  theme(strip.background = element_rect(fill="white", color="white"), 
        strip.text = element_text(face="bold"), 
        axis.title = element_text(face = "bold"),
        legend.position = c(1, 0), legend.justification = c(1, 0)) 

print(plot)+ 
# save plot ----
ggsave(here("week_4", "outputs","Hawaii_WaterChemistry.png"),
       width = 7, height = 5)

# turn plot to a grob
#plot <- ggplotGrob(plot)

# check boundaries of empty space
#gtable_show_layout(plot)

# write text ----
#text1 <- text_grob(label="Nitrate+Nitrite, Silicate, Phosphate, are in umol/L.\n Total alkalinity is in umol/Kg", 
                  # x=0.1, y=0.15, just = "left", size=8)

# add text to plot ----
#plot2 <- gtable_add_grob(plot, text1, 
                         #t = 18, l=7, r=13)
#grid.draw(plot2)



### My Attempt to do it myself #####

ChemData_group<- ChemData %>%
  filter(complete.cases(.)) %>%
  separate(col = Tide_time, #choose the tide time col
           into = c("Tide", "Time"), #separate it into two columns Tode and time
           sep = "_" , #separate by_
           remove = FALSE) %>% #keep the original tide_time column
  filter(Time == "Day") %>% #"filter out subset of your choice"
  select(-c("Time", "percent_sgd")) %>%
  rename("Temp (C)" = Temp_in,
         "Nitrate+Nitrate" = NN,
         "Total Alkalinity" = TA) %>%
  pivot_longer(cols = c(8:14),
               names_to = "Variables",
               values_to = "Values")
glimpse(ChemData_group)
  

View(ChemData_group)
  