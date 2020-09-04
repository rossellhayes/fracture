# fracture (development version)

## New features

* Add `frac_style()` which formats fractures using Unicode superscripts and subscripts.
* Add `is.frac_mat()`.

## Bug fixes 

* Fixed bug where certain fractions (e.g. 16/113) would cause an integer overflow in C++.
  * Added tests to cover all fractions below 3000/3000 and a random sample of fractions below 1000000/1000000.
* Fixed bug with fracture math where only the first element would be returned.

# fracture 0.1.0

* Initial release.
