02\_debugging\_comfy.R
================
medk-cka
2020-01-27

``` r
#dplyr::na_if(x, y) replaces NA values in `x` with `y`
# it works when x is a data.frame _without_ Date objects, but fails when there is a Date in the df
# Can you use our debugging tools to figure out where and why it is failing?
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
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
```

    ##    b                 c    d
    ## 1  1 0.981987431412563    u
    ## 2  2 0.646591003984213    w
    ## 3  3 0.815229669911787    t
    ## 4  4 0.925928491167724    e
    ## 5 NA              <NA> <NA>

``` r
# How could you apply na_if only to non-date columns?




test %>% 
  mutate_if(is.numeric, list(~na_if(.,""))) %>% 
  mutate_if(is.factor, list(~na_if(.,""))) 
```

    ##            a  b                 c    d
    ## 1 2020-02-24  1 0.981987431412563    u
    ## 2 2020-01-30  2 0.646591003984213    w
    ## 3 2020-01-27  3 0.815229669911787    t
    ## 4 2020-02-05  4 0.925928491167724    e
    ## 5 2020-02-05 NA              <NA> <NA>
