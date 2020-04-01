# regression model for t2
# saturated linear model
t2.mod0 <- lm(t2~ t1+ 
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
t2.mod1 <- stepAIC(t2.mod0, direction = "both", 
                   trace = FALSE)

summary(t2.mod0)
summary(t2.mod1)
