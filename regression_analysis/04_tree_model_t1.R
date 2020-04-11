# regression tree to suppliment the t1 regression model
require(rpart, warn.conflicts = FALSE)
require(rpart.plot)

t1.mod2 <- rpart(t1~ Population +
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
                 data = dat,
                 control = rpart.control(cp = 0.025))

rpart.plot(t1.mod2)

dat$tree <- as.factor(predict(t1.mod2, dat))
plot(x = dat$t1, y = dat$tree)
