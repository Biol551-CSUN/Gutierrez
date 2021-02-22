### I am going to practice tidy with biogeochemistry data from Hawaii 
### We are learning how clean and pivot plot data today. 
### Created by: Anthony Gutierrez

### Load libraries #####
library(tidyverse)
library(here)

### Load data #####
ChemData<- read_csv(here("week_4", "data", "chemicaldata_maunalua.csv"))

ChemData_clean<- ChemData %>%
  filter(complete.cases(.)) %>% #filters out everything that is not a complete row
  separate(col = Tide_time, #choose the tide time col
           into = c("Tide", "Time"), #separate it into two columns Tode and time
           sep = "_" , #separate by_
           remove = FALSE) %>% #keep the original tide_time column
  unite(col = "Site_Zone", #the name of the NEW col
  c(Site,Zone), #the columns to unite 
  sep = ".", # lets put a . in the middle 
  remove = FALSE) #keep the original

### Pivot_longer #####
ChemData_long<- ChemData %>%
  pivot_longer(cols = Temp_in:percent_sgd, # the cols you want to pivot. #select the temp to percent SGD
               names_to = "Variables", # the names of the new cols with all the column names
               values_to = "Values") #names of the new column with all the values

ChemData_long %>%
  filter(complete.cases(.)) %>%
  separate(col = Tide_time, #choose the tide time col
           into = c("Tide", "Time"), #separate it into two columns Tode and time
           sep = "_" , #separate by_
           remove = FALSE) %>% #keep the original tide_time column
  group_by(Variables, Site, Zone, Tide) %>% #group by everything we want
  summarize(Param_means = mean(Values, na.rm = TRUE), #get mean
            Param_Vars = var(Values, na.rm =TRUE)) #get variance

### Wide v. Long
ChemData_long %>%
  ggplot(aes(x= Site, y= Values))+
  geom_boxplot()+
  facet_wrap(~Variables, scales ="free")

ChemData_wide<- ChemData_long %>%
  pivot_wider(names_from = Variables, 
              values_from = Values)


ChemData_clean<- ChemData %>%
  filter(complete.cases(.)) %>% 
  separate(col = Tide_time, 
           into = c("Tide", "Time"), 
           sep = "_" , 
           remove = FALSE)%>%
  pivot_longer(cols = Temp_in:percent_sgd,
               names_to = "Variables",
               values_to = "Values") %>%
  group_by(Variables, Site, Time) %>%
  summarize(mean_vals = mean(Values, na.rm = TRUE))%>%
  pivot_wider(names_from = Variables,
              values_from = mean_vals) %>% #notice it is mean_vals as the column
  write_csv(here("week_4", "outputs", "summary.csv")) #export as a csv to the correct folder


View(ChemData_clean)
View(ChemData_long)


### VERY IMPORTANT #####
library(ggbernie)
ggplot(ChemData) + 
  geom_bernie(aes(x = Salinity, y = NN), bernie = "sitting")
