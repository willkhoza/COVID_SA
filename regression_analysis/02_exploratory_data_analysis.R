# exploratory data analysis
library(Hmisc)
library(corrplot)

dat.corr <- dat %>%
  na.omit() %>%
  select(t1,
         t2,
         Population, 
         Annual_Change, 
         Annual_Change_Absolute,
         Density,
         Land_Area,
         Migrants,
         Fert_Rate,
         Median_Age,
         Urban_Population,
         World_Share,
         Passengers,
         migration_index,
         lnPopulation,
         lnPassengers) %>%
  as.matrix() %>%
  rcorr()

dat.corr$r %>%
  corrplot()

dat %>%
  ggplot()+
  aes(x = Median_Age, y = t1, size = Passengers)+
  geom_point() +
  ggtitle("Median Age vs t1 per country", "Weighted by air traffic passengers per year")

dat %>%
  ggplot()+
  aes(x = lnPassengers, y = t1, size = Fert_Rate)+
  geom_point() +
  ggtitle("lnPassengers vs t1 per country", "Weighted by fertility rate")

dat %>%
  ggplot()+
  aes(x = t1, y = t2, size = Median_Age)+
  geom_point() +
  ggtitle("t1 vs t2 per country", "Weighted by population median age")
