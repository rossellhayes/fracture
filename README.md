
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fracture <img src="man/figures/logo.png?raw=TRUE" align="right" height="138" />

<!-- badges: start -->

[![](https://www.r-pkg.org/badges/version/fracture?color=brightgreen)](https://cran.r-project.org/package=fracture)
[![](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![License:
MIT](https://img.shields.io/badge/license-MIT-blueviolet.svg)](https://cran.r-project.org/web/licenses/MIT)
[![R build
status](https://github.com/https://fracture.rossellhayes.com/,%20rossellhayes/fracture/workflows/R-CMD-check/badge.svg)](https://github.com/https://fracture.rossellhayes.com/,%20rossellhayes/fracture/actions)
[![](https://codecov.io/gh/https://fracture.rossellhayes.com/,%20rossellhayes/fracture/branch/master/graph/badge.svg)](https://codecov.io/gh/https://fracture.rossellhayes.com/,%20rossellhayes/fracture)
[![Dependencies](https://tinyverse.netlify.com/badge/fracture)](https://cran.r-project.org/package=fracture)
<!-- badges: end -->

Convert decimals to fractions in R

## Installation

You can install the released version of **fracture** from
[CRAN](https://cran.r-project.org/package=fracture) with:

``` r
install.packages("fracture")
```

or the development version from
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
#> [1] 1/2

fracture((1:11) / 12)
#>  [1] 1/12  1/6   1/4   1/3   5/12  1/2   7/12  2/3   3/4   5/6   11/12
```

Additional arguments help you get exactly the result you expect:

#### Common denominators

``` r
fracture((1:11) / 12, common_denom = TRUE)
#>  [1] 1/12  2/12  3/12  4/12  5/12  6/12  7/12  8/12  9/12  10/12 11/12
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
fracture(1 / (2:12), base_10 = TRUE, max_denom = 1000)
#>  [1] 5/10     333/1000 25/100   2/10     167/1000 143/1000 125/1000 111/1000
#>  [9] 1/10     91/1000  83/1000

fracture(1 / (2:12), base_10 = TRUE, common_denom = TRUE, max_denom = 1000)
#>  [1] 500/1000 333/1000 250/1000 200/1000 167/1000 143/1000 125/1000 111/1000
#>  [9] 100/1000 91/1000  83/1000
```

#### Mixed fractions

``` r
fracture((1:9) / 3, mixed = TRUE)
#> [1] 1/3   2/3   1     1 1/3 1 2/3 2     2 1/3 2 2/3 3
```

### Convert decimals to a fraction matrix

For more advanced work, you may prefer to work with a fraction matrix:

``` r
frac_mat((1:11) / 12)
#>             [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11]
#> numerator      1    1    1    1    5    1    7    2    3     5    11
#> denominator   12    6    4    3   12    2   12    3    4     6    12
```

`frac_mat()` accepts all the same arguments as `fracture()`.

When mixed fractions are used, `frac_mat()` has three rows:

``` r
frac_mat((1:9) / 3, mixed = TRUE, common_denom = TRUE)
#>             [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9]
#> integer        0    0    1    1    1    2    2    2    3
#> numerator      1    2    0    1    2    0    1    2    0
#> denominator    3    3    3    3    3    3    3    3    3
```

### Math with `fracture`s

`fracture`s are implemented using an S3 class. This means we can perform
mathematical operations on them like real fractions.

``` r
fracture(0.25) * 2
#> [1] 1/2

fracture(0.25) + fracture(1/6)
#> [1] 5/12
```

### Stylish `fracture`s

`frac_style()` uses Unicode to provide stylish formatting for inline
fractions.

``` r
`r frac_style(pi, mixed = TRUE, max_denom = 500)`
```

3 ¹⁶/₁₁₃

### Just a fun example

Use **fracture** to find the best approximations of π for each maximum
denominator.

``` r
unique(purrr::map_chr(1:50000, ~ fracture(pi, max_denom = .x)))
#> [1] "3/1"          "22/7"         "333/106"      "355/113"      "103993/33102"
#> [6] "104348/33215"
```

Isn’t is interesting that there’s such a wide gap between ³⁵⁵/₁₁₃ and
¹⁰³⁹⁹³/₃₃₁₀₂?

## Advantages 🚀

**fracture** is implemented using optimized C++ with
[**Rcpp**](http://rcpp.org/) and S3 methods. This allows it to run
faster than alternatives like
[`MASS::fractions()`](https://stat.ethz.ch/R-manual/R-devel/library/MASS/html/fractions.html)
or
[`fractional::fractional()`](https://cran.r-project.org/web/packages/fractional/vignettes/Vulgar_Fractions_in_R.html).\*

``` r
# Performance with a single value
single_benchmark
#> # A tibble: 3 x 6
#>   expression                            min median `itr/sec` mem_alloc `gc/sec`
#>   <bch:expr>                          <dbl>  <dbl>     <dbl>     <dbl>    <dbl>
#> 1 print(fracture(x[1]))                1      1         1.78       1       1   
#> 2 print(MASS::fractions(x[1]))         3.11   1.59      1.10      26.4     3.00
#> 3 print(fractional::fractional(x[1]))  2.70   1.82      1         18.3     1.00

# Performance with a vector of length 100
medium_benchmark
#> # A tibble: 3 x 6
#>   expression                                min median `itr/sec` mem_alloc
#>   <bch:expr>                              <dbl>  <dbl>     <dbl>     <dbl>
#> 1 print(fracture(x[1:100]))                1      1         1.29      1.80
#> 2 print(MASS::fractions(x[1:100]))         1.10   1.17      1        15.8 
#> 3 print(fractional::fractional(x[1:100]))  1.25   1.13      1.14      1   
#> # ... with 1 more variable: `gc/sec` <dbl>

# Performance with a vector of length 10,000
large_benchmark
#> # A tibble: 3 x 6
#>   expression                         min median `itr/sec` mem_alloc `gc/sec`
#>   <bch:expr>                       <dbl>  <dbl>     <dbl>     <dbl>    <dbl>
#> 1 print(fracture(x))                1.17   1.17      1.25      1        1.23
#> 2 print(MASS::fractions(x))         1.46   1.46      1         3.18     1   
#> 3 print(fractional::fractional(x))  1      1         1.46      4.87     1.51
```

\* `fractional()` does not compute a decimal’s fractional equivalent
until it is printed. Therefore, benchmarking the time to print provides
a fairer test of the three packages’ capabilities.

-----

Hex sticker fonts are [Source Code
Pro](https://github.com/adobe-fonts/source-code-pro) by
[Adobe](https://www.adobe.com) and
[Hasklig](https://github.com/i-tu/Hasklig) by [Ian
Tuomi](https://github.com/i-tu).

Please note that **fracture** is released with a [Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
