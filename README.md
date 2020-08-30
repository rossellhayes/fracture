
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fracture <img src="man/figures/logo.png?raw=TRUE" align="right" height="138" />

<!-- badges: start -->

[![](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![License:
MIT](https://img.shields.io/badge/license-MIT-blueviolet.svg)](https://cran.r-project.org/web/licenses/MIT)

<!-- badges: end -->

Convert decimals to fractions in R

## Installation

<!-- You can install the released version of **fracture** from [CRAN](https://CRAN.R-project.org) with: -->

<!-- ``` {r eval = FALSE} -->

<!-- install.packages("fracture") -->

<!-- ``` -->

You can install the development version of **fracture** from
[GitHub](https://github.com/rossellhayes/fracture) with:

``` r
# install.packages("remotes")
remotes::install_github("rossellhayes/fracture")
```

## Usage

### Convert decimals to a character vector of fractions

**fracture** converts decimals into fractions.

``` r
fracture(0.5)
#> [1] 1/0

fracture((1:11) / 12)
#>  [1] 1/0 1/0 1/0 1/0 1/0 1/0 1/0 1/0 1/0 1/0 1/0
```

Additional arguments help you get exactly the result you expect:

#### Common denominators

``` r
fracture((1:11) / 12, common_denom = TRUE)
#>  [1] NaN/0 NaN/0 NaN/0 NaN/0 NaN/0 NaN/0 NaN/0 NaN/0 NaN/0 NaN/0 NaN/0
```

#### Base-10 denominators

``` r
fracture(1 / (2:12), base_10 = TRUE)
#>  [1] 5/10             3333333/10000000 25/100           2/10            
#>  [5] 1666667/10000000 1428571/10000000 125/1000         1111111/10000000
#>  [9] 1/10             909091/10000000  833333/10000000
```

#### Maximum denominators

``` r
fracture(1 / (2:12), base_10 = TRUE, max_denom = 100)
#>  [1] 5/10   33/100 25/100 2/10   17/100 14/100 12/100 11/100 1/10   9/100 
#> [11] 8/100
fracture(1 / (2:12), base_10 = TRUE, common_denom = TRUE, max_denom = 100)
#>  [1] 50/100 33/100 25/100 20/100 17/100 14/100 12/100 11/100 10/100 9/100 
#> [11] 8/100
```

#### Mixed fractions

``` r
fracture((1:9) / 3, mixed = TRUE)
#> [1] 1/0   1/0   1 1/0 1 1/0 1 1/0 2 1/0 2 1/0 2 1/0 3 1/0
```

### Convert decimals to a fraction matrix

For more advanced work, you may prefer to work with a fraction matrix:

``` r
frac_mat((1:11) / 12)
#>             [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11]
#> numerator      1    1    1    1    1    1    1    1    1     1     1
#> denominator    0    0    0    0    0    0    0    0    0     0     0
```

`frac_mat()` accepts all the same arguments as `fracture()`.

When mixed fractions are used, `frac_mat()` has three rows:

``` r
frac_mat((1:9) / 3, mixed = TRUE)
#>             [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9]
#> integer        0    0    1    1    1    2    2    2    3
#> numerator      1    1    1    1    1    1    1    1    1
#> denominator    0    0    0    0    0    0    0    0    0
```

### Math with `fracture`s

`fracture`s are implemented using an S3 class. This means we can perform
mathematical operations on them like real fractions.

``` r
fracture(0.25) * 2
#> [1] NaN/0

fracture(0.25) + fracture(1/6)
#> [1] NaN/0
```

### Just a fun example

Use **fracture** to find the best approximations of π for each maximum
denominator.

``` r
unique(purrr::map_chr(1:50000, ~ fracture(pi, max_denom = .x)))
#> [1] "1/0"
```

Isn’t is interesting that there’s such a wide gap between
![](http://www.sciweavers.org/tex2img.php?eq=%5Cfrac%7B355%7D%7B113%7D&bc=white&fc=black&im=jpg&fs=8&ff=arev)
and
![](http://www.sciweavers.org/tex2img.php?eq=%5Cfrac%7B103993%7D%7B33102%7D&bc=white&fc=black&im=jpg&fs=8&ff=arev)?

## Advantages 🚀

**fracture** is implemented using C++ with [**Rcpp**](http://rcpp.org/).
This allows it to run faster than alternatives like
[`MASS::fractions()`](https://stat.ethz.ch/R-manual/R-devel/library/MASS/html/fractions.html)
written in R.

``` r
x <- round(runif(1e5, 1, 1e5)) / round(runif(1e5, 1, 1e5))

# Performance with a single value
bench::mark(fracture(x[1]), MASS::fractions(x[1]), check = FALSE)
#> # A tibble: 2 x 6
#>   expression                 min   median `itr/sec` mem_alloc `gc/sec`
#>   <bch:expr>            <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl>
#> 1 fracture(x[1])          39.3us   54.7us    17701.    2.49KB     23.7
#> 2 MASS::fractions(x[1])   96.9us    135us     7184.  286.98KB     37.9

# Performace with a large vector
bench::mark(fracture(x), MASS::fractions(x), check = FALSE)
#> Warning: Some expressions had a GC in every iteration; so filtering is disabled.
#> # A tibble: 2 x 6
#>   expression              min   median `itr/sec` mem_alloc `gc/sec`
#>   <bch:expr>         <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl>
#> 1 fracture(x)           230ms    286ms      3.49    27.1MB     3.49
#> 2 MASS::fractions(x)    810ms    810ms      1.23   277.8MB    13.6
```

-----

Hex sticker fonts are [Source Code
Pro](https://github.com/adobe-fonts/source-code-pro) by
[Adobe](https://adobe.com) and
[Hasklig](https://github.com/i-tu/Hasklig) by [Ian
Tuomi](https://github.com/i-tu).

Please note that **fracture** is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
