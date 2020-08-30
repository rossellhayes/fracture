#include <Rcpp.h>
#include <limits>
using namespace Rcpp;

IntegerVector decimal_to_fraction_cont(double x, int max_denom) {
  int n0;
  int n1 = 1;
  int n2 = floor(x);
  int d0;
  int d1 = 0;
  int d2 = 1;
  int i;

  double z = x - n2;

  while (d2 <= max_denom) {
    z  = 1 / z;
    i  = (int) floor(z);
    z  = z - i;
    n0 = n1;
    n1 = n2;
    n2 = i * n1 + n0;
    d0 = d1;
    d1 = d2;
    d2 = i * d1 + d0;
    if (fabs(x - (double) n1 / (double) d1) <=
        std::numeric_limits<double>::epsilon()) {break;}
    if (fabs(i) <= std::numeric_limits<double>::epsilon()) {break;}
  }

  return IntegerVector::create(n1, d1);
}

IntegerVector decimal_to_fraction_base_10(double x, int max_denom) {
  int n = 0;
  int d = 1;

  while (d <= max_denom) {
    n      = (int) R::fround(x * d, 0);
    if (fabs(x - (double) n / (double) d) <=
        std::numeric_limits<double>::epsilon()) {break;}
    d      = d * 10;
  }

  return IntegerVector::create(n, d);
}

// [[Rcpp::export]]
IntegerMatrix decimal_to_fraction(NumericVector x, bool base_10, int max_denom)
{
  IntegerMatrix result(2, x.size());

  if (base_10) {
    for (int i = 0; i < x.size(); i++) {
      result(_, i) = decimal_to_fraction_base_10(x[i], max_denom);
    }
  } else {
    for (int i = 0; i < x.size(); i++) {
      result(_, i) = decimal_to_fraction_cont(x[i], max_denom);
    }
  }

  return result;
}
