---
output: github_document
---

<!-- README.md is generated from README.Rmd. Please edit that file -->



# bdmepr

<!-- badges: start -->
<!-- badges: end -->

The goal of bdmepr is to ...

## Installation

You can install the development version of bdmepr from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("rfsaldanha/bdmepr")
```

## Example

Download data from 2012


``` r
library(bdmepr)
dest <- tempdir()

res_download <- download_data(year = 2012, destpath = dest)
#> ℹ https:/portal.inmet.gov.br/uploads/dadoshistoricos/2012.zip
#> ℹ Unziping file...
#> ℹ File unziped!
res_download[10]
#> /tmp/Rtmpt73UJ8/2012/INMET_CO_GO_A015_ITAPACI_01-01-2012_A_31-12-2012.CSV
```

Parse data


``` r
res <- parse_bdmep(file = res_download[10])

res
#> # A tibble: 8,784 × 20
#>    station_cod station_name datetime            prec_total press press_max press_min   rad temp_sec temp_orv temp_max
#>    <chr>       <chr>        <dttm>                   <dbl> <dbl>     <dbl>     <dbl> <dbl>    <dbl>    <dbl>    <dbl>
#>  1 A015        ITAPACI      2012-01-01 00:00:00        0    949.      949.      948.    NA     23.2     20.8     24.1
#>  2 A015        ITAPACI      2012-01-01 01:00:00        0    950.      950.      949.    NA     23.3     20.9     23.7
#>  3 A015        ITAPACI      2012-01-01 02:00:00        0    950.      950.      950.    NA     22.8     21.2     23.3
#>  4 A015        ITAPACI      2012-01-01 03:00:00        0.8  950.      950.      950.    NA     22.5     21.3     23.1
#>  5 A015        ITAPACI      2012-01-01 04:00:00        0.6  949.      950.      949.    NA     22.3     21.3     22.5
#>  6 A015        ITAPACI      2012-01-01 05:00:00        1.2  949.      949.      948.    NA     21.6     20.4     22.4
#>  7 A015        ITAPACI      2012-01-01 06:00:00        0.8  948.      949.      948.    NA     21.5     20.5     21.6
#>  8 A015        ITAPACI      2012-01-01 07:00:00        0.4  948.      948.      948.    NA     21.7     20.5     21.8
#>  9 A015        ITAPACI      2012-01-01 08:00:00        0.2  949.      949.      948.    NA     21.4     20.3     21.7
#> 10 A015        ITAPACI      2012-01-01 09:00:00        0    949.      949.      949.    NA     21.4     20.3     21.5
#> # ℹ 8,774 more rows
#> # ℹ 9 more variables: temp_min <dbl>, temp_orv_max <dbl>, temp_orv_min <dbl>, umid_rel_min <dbl>, umid_rel_max <dbl>,
#> #   umid_real <dbl>, vento_dir <dbl>, vento_raj <dbl>, vento_veloc <dbl>
```
