# fracture 0.2.1

## New features
* `fracture()` and `frac_mat()` no longer return an error when receiving a vector containing `NA` or `Inf` values (#14).
  * `fracture(NA)` now returns `NA`.
  * `fracture(Inf)` now returns `"Inf/1"`.

## Bug fixes
* Fixed a bug where `frac_style()` would print integers in mixed `fracture`s as `"1 ⁰/₀"` instead of `"1"` (#12).

# fracture 0.2.0

## Breaking changes
* The second argument to `fracture()` and `frac_mat()` is now `...`, which must be empty. As a result, all arguments besides `x` must now be named. (#5)
* `fracture()` and `frac_mat()` now default to a denominator of `1` when `x` equals `0` or `1`. Previously, these would default to a denominator of `max_denom`. `max_denom` is still used as the denominator when `x` is `0` or `1` ± ε. (#6)

## New features
* `fracture()` and `frac_mat()` gain the argument `denom`, which allows the user to set an explicit denominator used by all fractions. (#5)

## Miscellaneous
* The `print()` method for `fracture`s now puts quotes around mixed fractions to increase legibility. (#7)
* Updated `testthat` to 3rd edition. (#5)

# fracture 0.1.3

* Implemented STRICT_R_HEADERS in accordance with RcppCore/Rcpp#1158

# fracture 0.1.2

## Bug fixes

* Fixed bug where certain fractions (e.g. `frac_mat(1307.36, base_10 = TRUE)`) would cause an floating point rounding error.
  * Reimplemented `decimal_to_fraction_base_10()` with `double` rather than `int`.
  * Added tests to cover all base_10 fractions below 10,000/10,000 (reduced to 100/100 when testing on CRAN) and a random sample of base_10 fractions below 10,000,000/10,000,000.
  
## Documentation fixes

* `frac_mat()`'s `max_denom` should be less than the *inverse* square root of machine double epsilon.

# fracture 0.1.1

## New features

* Added `frac_style()` which formats fractures using Unicode superscripts and subscripts.
* Added `is.frac_mat()` which tests if a matrix is formatted like the output of `frac_mat()`.

## Bug fixes 

* Fixed bug where certain fractions (e.g. 16/113) would cause an integer overflow in C++.
  * Reimplemented `decimal_to_fraction_cont()` with `double` rather than `int`.
  * Added tests to cover all fractions below 1000/1000 (reduced to 100/100 when testing on CRAN) and a random sample of fractions below 10,000,000/10,000,000.
* Fixed bug with fracture math where only the first element would be returned.
* Added error handling for `NA` and infinite inputs to `frac_mat()`.

## Miscellaneous

* Added `pkgdown` site.

# fracture 0.1.0

* Initial release.
