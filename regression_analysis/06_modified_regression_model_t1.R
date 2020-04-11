# fit regression models after tree modification

# saturated linear model
t1.mod3 <- lm(t1~ Population +
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
                lnPopulation +
                lnPassengers + 
                tree,
              data = na.omit(dat))
# Stepwise regression model
t1.mod4 <- stepAIC(t1.mod3, direction = "both", 
                   trace = FALSE)

summary(t1.mod3)
summary(t1.mod4)

#Model Evaluation

t1.pred = predict(t1.mod4, dat)
plot(dat$t1, t1.pred, main = "t1: Model Performance Plot")

t1.res <- dat$t1-t1.pred
plot(t1.res, main = "t1: Residual Plot")
hist(t1.res)

# test for normality
ggqqplot(t1.res)

summary(t1.res)
var(t1.res, na.rm = TRUE)