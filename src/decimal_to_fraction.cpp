#include <Rcpp.h>
using namespace Rcpp;

IntegerVector decimal_to_fraction_cont(double x, int max_denom) {
  int  n0 = 0;
  int  n1 = 1;
  long long n2 = floor(x);
  int  d0 = 0;
  int  d1 = 0;
  long long d2 = 1;
  long long f  = n2;

  double z = x - n2;

  while (d2 <= max_denom) {
    z  = 1 / z;
    f  = (long long) floor(z);
    z  = z - f;
    n0 = n1;
    n1 = n2;
    n2 = f * n1 + n0;
    d0 = d1;
    d1 = d2;
    d2 = f * d1 + d0;
    if (fabs(x - (double) n1 / (double) d1) < DBL_EPSILON) {break;}
    if (f == 0) {break;}
  }

  if (n1 == NA_INTEGER) {
    n1 = (int) ceil(x);
    d1 = 1;
  } else if (d1 == NA_INTEGER) {
    n1 = (int) floor(x);
    d1 = 1;
  }

  return IntegerVector::create(n1, d1);
}

IntegerVector decimal_to_fraction_base_10(double x, int max_denom) {
  int n = 0;
  int d;

  for (int i = 1; i <= max_denom; i *= 10) {
    d = i;
    n = (int) R::fround(x * d, 0);
    if (fabs(x - (double) n / (double) d) <= DBL_EPSILON) {break;}
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
