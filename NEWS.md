# fracture (development version)

# fracture 0.1.1

## New features

* Added `frac_style()` which formats fractures using Unicode superscripts and subscripts.
* Added `is.frac_mat()` which tests if a matrix is formatted like the output of `frac_mat()`.

## Bug fixes 

* Fixed bug where certain fractions (e.g. `fracture(16/113)`, `fracture(1307.36, base_10 = TRUE)`) would cause an integer overflow in C++.
  * Added tests to cover all fractions below 1000/1000 (reduced to 100/100 when testing on CRAN) and a random sample of fractions below 10,000,000/10,000,000.
* Fixed bug with fracture math where only the first element would be returned.
* Added error handling for `NA` and infinite inputs to `frac_mat()`.

## Miscellaneous

* Added `pkgdown` site.

# fracture 0.1.0

* Initial release.
