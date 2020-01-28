# dplyr::na_if(x, y) replaces NA values in `x` with `y`
# it works when x is a data.frame _without_ Date objects, but fails when there is a Date in the df
# Can you use our debugging tools to figure out where and why it is failing?
library(dplyr)

test <- data.frame(
  a = lubridate::today() + runif(5) * 30, 
  b = as.numeric(c(1:4, "")), 
  c = c(runif(4), ""),
  d = c(sample(letters, 4, replace = TRUE), ""))

# khsdfkj



# The traceback is easier to understand without the pipe involved

#na_if(test,"") 

# Also useful to look at the implementation of `na_if()`
# Can you reproduce the error without using `na_if()`?

# What happens if you remove the date column from the tibble?

test %>% select(-a) %>% na_if("")

# How could you apply na_if only to non-date columns?




test %>% 
  mutate_if(is.numeric, list(~na_if(.,""))) %>% 
  mutate_if(is.factor, list(~na_if(.,""))) 