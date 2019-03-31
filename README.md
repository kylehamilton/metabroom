<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis build
status](https://travis-ci.org/softloud/metabroom.svg?branch=master)](https://travis-ci.org/softloud/metabroom)

metabroom
=========

The goal of metabroom is to `broom` meta-analysis models produced by
`metafor`. That is, when I finish it.

See the **testing** file to see where I’m at.

Example
-------

### Get example dataset

``` r
# Hmmm. What's best practice for loading %>% in packages? What's best practice for package dependencies?
library(metabroom)



# Check all is as it should be.
example_ma %>% 
  metafor::forest()
```

![](README-Get%20a%20test%20model-1.png)

``` r
library(tidyverse)
#> ── Attaching packages ───────────────────────── tidyverse 1.2.1.9000 ──
#> ✔ ggplot2 3.1.0.9000     ✔ purrr   0.3.1     
#> ✔ tibble  2.1.1.9000     ✔ dplyr   0.8.0.9002
#> ✔ tidyr   0.8.1          ✔ stringr 1.3.1     
#> ✔ readr   1.1.1          ✔ forcats 0.3.0
#> ── Conflicts ───────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
```

### `augment`

``` r
example_ma %>% augment()
#>            .rownames          y    .fitted   .se.fit conf.low.fit
#> 1          Edinburgh -0.3551696 -0.3581264 0.1134792   -0.5805415
#> 2     Orpington-Mild -0.3479400 -0.3621985 0.2452567   -0.8428927
#> 3 Orpington-Moderate -2.3175692 -2.2200778 0.2087804   -2.6292798
#> 4   Orpington-Severe -1.8879823 -1.6599389 0.3690780   -2.3833185
#> 5      Montreal-Home -0.3839641 -0.4155426 0.4088075   -1.2167906
#> 6  Montreal-Transfer  0.1721487  0.1405220 0.1882926   -0.2285248
#> 7          Newcastle  0.2720521  0.2147554 0.2376495   -0.2510291
#> 8               Umea -0.4245963 -0.4266718 0.1209185   -0.6636677
#> 9            Uppsala  0.2895562  0.2533042 0.1867199   -0.1126600
#>   conf.high.fit     .resid       .hat     .cooksd .std.resid     .dffits
#> 1    -0.1357114  0.1819386 0.11851103 0.007387834  0.2031432  0.07994352
#> 2     0.1184957  0.1891682 0.11138852 0.007033309  0.2053917  0.07858262
#> 3    -1.8108757 -1.7804609 0.11387240 0.684363592 -3.2100342 -1.26913790
#> 4    -0.9365592 -1.3508740 0.10013227 0.237279865 -1.5640378 -0.52135279
#> 5     0.3857053  0.1531441 0.09562802 0.003555285  0.1552711  0.05669244
#> 6     0.5095688  0.7092569 0.11509697 0.090675033  0.8087748  0.29359454
#> 7     0.6805400  0.8091603 0.11193842 0.110062884  0.9200823  0.32781647
#> 8    -0.1896759  0.1125120 0.11824651 0.003139723  0.1261677  0.05203345
#> 9     0.6192685  0.8266645 0.11518586 0.121988299  0.9596687  0.34678427
#>   .cov.ratio tau.squared.del   qe.del   .weight    .dfbetas
#> 1  1.2996302       0.9162371 123.3977 11.851103  0.08026186
#> 2  1.2819965       0.9096931 123.6645 11.138852  0.07857522
#> 3  0.4904882       0.3096683  37.1817 11.387240 -1.25645764
#> 4  0.9520256       0.6699754 109.8115 10.013227 -0.52578864
#> 5  1.2448155       0.8966233 123.7258  9.562802  0.05624433
#> 6  1.1867477       0.8338381 113.4740 11.509697  0.29381530
#> 7  1.1531932       0.8114289 115.4769 11.193842  0.32782793
#> 8  1.3035553       0.9194719 123.7116 11.824651  0.05223729
#> 9  1.1458596       0.8027343 108.6344 11.518586  0.34686056
```

### `tidy`

``` r
example_ma %>% tidy()
#>                 study    type   estimate std.error   statistic    p.value
#> 1           Edinburgh   study -0.3551696 0.1143008  -3.1073239         NA
#> 2      Orpington-Mild   study -0.3479400 0.2539072  -1.3703432         NA
#> 3  Orpington-Moderate   study -2.3175692 0.2140376 -10.8278581         NA
#> 4    Orpington-Severe   study -1.8879823 0.4007714  -4.7108704         NA
#> 5       Montreal-Home   study -0.3839641 0.4532475  -0.8471402         NA
#> 6   Montreal-Transfer   study  0.1721487 0.1921212   0.8960418         NA
#> 7           Newcastle   study  0.2720521 0.2454936   1.1081838         NA
#> 8                Umea   study -0.4245963 0.1219141  -3.4827506         NA
#> 9             Uppsala   study  0.2895562 0.1904514   1.5203681         NA
#> 10            Overall summary -0.5371083 0.3086615  -1.7401207 0.08183782
#>       conf.low   conf.high
#> 1  -0.57919512 -0.13114417
#> 2  -0.84558903  0.14970898
#> 3  -2.73707522 -1.89806310
#> 4  -2.67347981 -1.10248469
#> 5  -1.27231288  0.50438460
#> 6  -0.20440204  0.54869938
#> 7  -0.20910661  0.75321076
#> 8  -0.66354344 -0.18564910
#> 9  -0.08372165  0.66283411
#> 10 -1.14207367  0.06785715
```

### `glance`

``` r
example_ma %>% glance()
#>   k measure method     effect     ci.lb      ci.ub i.squared h.squared
#> 1 9     SMD   REML -0.5371083 -1.142074 0.06785715  95.49494  22.19725
#>   tau.squared tau.squared.se       QE         QE_p      QM       QM_p
#> 1   0.7908429      0.4280955 123.7293 5.622513e-23 3.02802 0.08183782
#>      logLik deviance     AIC      BIC    AICc
#> 1 -10.76335  21.5267 25.5267 25.68559 27.9267
```
