# fit regression models
library(MASS)
# saturated linear model
t1.mod0 <- lm(t1~ Population +
                        Annual_Change +
                        Annual_Change_Absolute +
                        Density +
                        Land_Area +
                        Migrants +
                        Fert_Rate +
                        Median_Age +
                        Urban_Population +
                        World_Share +
                        Passengers +
                        migration_index +
                        lnPopulation, 
                        data = na.omit(dat))
# Stepwise regression model
t1.mod1 <- stepAIC(t1.mod0, direction = "both", 
                      trace = FALSE)

summary(t1.mod0)
summary(t1.mod1)
