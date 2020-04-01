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
                lnPopulation+
                lnPassengers, 
              data = na.omit(dat))
# Stepwise regression model
t2.mod1 <- stepAIC(t2.mod0, direction = "both", 
                   trace = FALSE)

summary(t2.mod0)
summary(t2.mod1)

#Model Evaluation

t2.pred = predict(t2.mod0, dat)
plot(dat$t2, t2.pred, main = "t2: Model Performance Plot")

t2.res <- dat$t2-t2.pred
plot(t2.res, main = "t2: Residual Plot")
hist(t2.res)

# test for normality
ggqqplot(t2.res)

summary(t2.res)
var(t2.res, na.rm = TRUE)
