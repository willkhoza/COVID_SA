library(tidyverse)
setwd("~/repos/COVID_SA/COVID_SA/machinery")
dat <- read.csv("timeline.csv")
dat <- dat %>%
  mutate(Median_Age = as.numeric(Median_Age), Urban_Population = as.numeric(Urban_Population), mig2 = sign(Migrants)*log(abs(Migrants)))

modt1.1 <- lm(t1~ Population + Annual_Change +
     Annual_Change_Absolute + Density +
     Land_Area + Migrants +Fert_Rate +
     Median_Age + Urban_Population + 
     World_Share, data = dat)

summary(modt1.1)

modt1.2 <- lm(t1~  log(Population) + Annual_Change + Density +
                mig2 + 
                Median_Age, data = dat)

modt1.2 <- lm(t1~ log(Population) + mig2 
              + Density + Median_Age
              
              , data = dat)

summary(modt1.2)

modt2 <- lm(t2 ~ t1 + Population +
     Annual_Change_Absolute + Density, data = dat)

summary(modt2)

# regression tree to suppliment the model1
require(rpart, warn.conflicts = FALSE)
require(rpart.plot)

tree.t1 <- rpart(t1~Population +
         Annual_Change_Absolute + Density +
         Land_Area + Migrants +
         Median_Age + Urban_Population + 
         World_Share, data = dat, control = rpart.control(cp = 0.08))

rpart.plot(tree.t1)

pred1 <- rpart.predict(tree.t1, select(dat, -t2, -t1))

select(dat, -c(t2, t1))

cor(dat$t1, pred1)

dat$tree <- pred1

modt1.3 <- lm(lm(t1~  log(Population) +
        tree +
        Median_Age, data = dat))

summary(modt1.3)

library(MASS)
# Fit the full model 
full.model <- lm(t1~ Population + Annual_Change +
                   Annual_Change_Absolute + Density +
                   Land_Area + Migrants +Fert_Rate + mig2 +
                   Median_Age + Urban_Population + tree + 
                   World_Share, data = dat)
# Stepwise regression model
step.model <- stepAIC(full.model, direction = "both", 
                      trace = FALSE)
summary(step.model)
