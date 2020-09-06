# fracture (development version)

## Documentation fixes

* `frac_mat()`'s `max_denom` should be less than the *inverse* square root of machine double epsilon.

# fracture 0.1.2

## Bug fixes

* Fixed bug where certain fractions (e.g. `frac_mat(1307.36, base_10 = TRUE)`) would cause an floating point rounding error.
  * Reimplemented `decimal_to_fraction_base_10()` with `double` rather than `int`.
  * Added tests to cover all base_10 fractions below 10,000/10,000 (reduced to 100/100 when testing on CRAN) and a random sample of base_10 fractions below 10,000,000/10,000,000.

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
