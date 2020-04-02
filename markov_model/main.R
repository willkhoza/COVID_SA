# reading data into env
library(tidyverse)
dat <- read_csv("https://raw.githubusercontent.com/willkhoza/COVID_SA/master/machinery/waiting_times.csv")
dat <- dat %>%
  mutate(country <- as.factor(country))

t(dat)

dat2 <- as.data.frame(t(dat))
?as.data.frame()
?t
