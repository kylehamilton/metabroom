<!-- README.md is generated from README.Rmd. Please edit that file -->
metabroom
=========

The goal of metabroom is to `broom` meta-analysis models produced by `metafor`. That is, when I finish it.

See the `testing` file to see where I'm at.

Example
-------

### Get example dataset

``` r
# Hmmm. What's best practice for loading %>% in packages? What's best practice for package dependencies?
library(tidyverse)
#> Loading tidyverse: ggplot2
#> Loading tidyverse: tibble
#> Loading tidyverse: tidyr
#> Loading tidyverse: readr
#> Loading tidyverse: purrr
#> Loading tidyverse: dplyr
#> Conflicts with tidy packages ----------------------------------------------
#> filter(): dplyr, stats
#> lag():    dplyr, stats
library(metafor)
#> Loading required package: Matrix
#> 
#> Attaching package: 'Matrix'
#> The following object is masked from 'package:tidyr':
#> 
#>     expand
#> Loading 'metafor' package (version 2.0-0). For an overview 
#> and introduction to the package please type: help(metafor).
library(metabroom)

example_ma <- data("dat.normand1999", package = "metafor") %>% # Get an example dataset.
  get() %>% # NB: slab (i.e., study) := "source".
  metafor::escalc( # Calculate effect.
    measure = "SMD",
    n1i = n1i,
    m1i =m1i,
    sd1i = sd1i,
    n2i = n2i,
    m2i = m2i,
    sd2i = sd2i,
    data = .
  ) %>% 
  metafor::rma( # Meta-analyse!
    slab = source
  ) 

# Check all is as it should be.
example_ma %>% 
  metafor::forest()
```

![](README-Get%20a%20test%20model-1.png)

``` r
library(tidyverse)
```

### `augment`

``` r
example_ma %>% augment()
#> # A tibble: 9 x 8
#>           yi         vi             .study    .ci_lb     .ci_ub   .weight
#>        <dbl>      <dbl>              <chr>     <dbl>      <dbl>     <dbl>
#> 1 -0.3551696 0.01306468          Edinburgh -1.142074 0.06785715 11.851103
#> 2 -0.3479400 0.06446888     Orpington-Mild -1.142074 0.06785715 11.138852
#> 3 -2.3175692 0.04581211 Orpington-Moderate -1.142074 0.06785715 11.387240
#> 4 -1.8879823 0.16061774   Orpington-Severe -1.142074 0.06785715 10.013227
#> 5 -0.3839641 0.20543328      Montreal-Home -1.142074 0.06785715  9.562802
#> 6  0.1721487 0.03691057  Montreal-Transfer -1.142074 0.06785715 11.509697
#> 7  0.2720521 0.06026713          Newcastle -1.142074 0.06785715 11.193842
#> 8 -0.4245963 0.01486304               Umea -1.142074 0.06785715 11.824651
#> 9  0.2895562 0.03627173            Uppsala -1.142074 0.06785715 11.518586
#> # ... with 2 more variables: .beta <dbl>, .se.beta <dbl>
```

### `tidy`

``` r
example_ma %>% tidy()
#> # A tibble: 1 x 6
#>         coef        se         z          p     ci_lb      ci_ub
#>        <dbl>     <dbl>     <dbl>      <dbl>     <dbl>      <dbl>
#> 1 -0.5371083 0.3086615 -1.740121 0.08183782 -1.142074 0.06785715
```

### `glance`

``` r
example_ma %>% glance()
#>   measure      tau2   se_tau2 method no_studies no_coef       I2       H2
#> 1     SMD 0.7908429 0.4280955   REML          9       1 95.49494 22.19725
#>         QE         QE_p      QM       QM_p        ll     dev     AIC
#> 1 123.7293 5.622513e-23 3.02802 0.08183782 -10.76335 21.5267 25.5267
#>        BIC    AICc
#> 1 25.68559 27.9267
```
