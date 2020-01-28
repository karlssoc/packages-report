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
    ## 1  1 0.696863548830152    d
    ## 2  2 0.239832773804665    h
    ## 3  3 0.421695846831426    k
    ## 4  4 0.331969237420708    e
    ## 5 NA              <NA> <NA>

``` r
# How could you apply na_if only to non-date columns?




test %>% 
  mutate_if(is.numeric, list(~na_if(.,""))) %>% 
  mutate_if(is.factor, list(~na_if(.,""))) 
```

    ##            a  b                 c    d
    ## 1 2020-02-18  1 0.696863548830152    d
    ## 2 2020-02-03  2 0.239832773804665    h
    ## 3 2020-02-09  3 0.421695846831426    k
    ## 4 2020-02-21  4 0.331969237420708    e
    ## 5 2020-02-22 NA              <NA> <NA>

``` r
sessionInfo()
```

    ## R version 3.6.1 (2019-07-05)
    ## Platform: x86_64-apple-darwin15.6.0 (64-bit)
    ## Running under: macOS Mojave 10.14.6
    ## 
    ## Matrix products: default
    ## BLAS:   /Library/Frameworks/R.framework/Versions/3.6/Resources/lib/libRblas.0.dylib
    ## LAPACK: /Library/Frameworks/R.framework/Versions/3.6/Resources/lib/libRlapack.dylib
    ## 
    ## locale:
    ## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] dplyr_0.8.3
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] Rcpp_1.0.3       lubridate_1.7.4  crayon_1.3.4     digest_0.6.23   
    ##  [5] assertthat_0.2.1 R6_2.4.1         magrittr_1.5     evaluate_0.14   
    ##  [9] pillar_1.4.3     highr_0.8        rlang_0.4.2      stringi_1.4.5   
    ## [13] rmarkdown_2.0    tools_3.6.1      stringr_1.4.0    glue_1.3.1      
    ## [17] purrr_0.3.3      xfun_0.12        yaml_2.2.0       compiler_3.6.1  
    ## [21] pkgconfig_2.0.3  htmltools_0.4.0  tidyselect_0.2.5 knitr_1.27      
    ## [25] tibble_2.1.3
