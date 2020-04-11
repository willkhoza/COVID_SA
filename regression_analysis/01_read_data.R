# reading data into enviroment
library(tidyverse)
dat <- read_csv("https://raw.githubusercontent.com/willkhoza/COVID_SA/master/machinery/timeline.csv")
dat <- dat %>%
  mutate(Median_Age = as.numeric(Median_Age), 
         Urban_Population = as.numeric(Urban_Population),
         migration_index = sign(Migrants)*log(abs(Migrants)),
         country = as.factor(country),
         lnPopulation = log(Population),
         lnPassengers = log(Passengers))
# remove countries with confirmed cases outside of the investigation period
dat <- dat %>%
  filter(t1 > 66)
         
dat %>%
  summary()
