#include <Rcpp.h>
#include <limits>
using namespace Rcpp;

// [[Rcpp::export]]
IntegerVector decimal_to_fraction_cont(double x, int max_denom, double sqrt_eps)
{
  int n0;
  int n1 = 1;
  int n2 = (int) floor(x);
  int d0;
  int d1 = 0;
  int d2 = 1;
  int i  = n2;

  x = x - (double) n2;

  do {
    x  = 1 / x;
    i  = (int) floor(x);
    x  = x - i;
    n0 = n1;
    n1 = n2;
    n2 = i * n1 + n0;
    d0 = d1;
    d1 = d2;
    d2 = i * d1 + d0;
  } while ((i > sqrt_eps) & (d2 <= max_denom));

  return IntegerVector::create(n1, d1);
}

// [[Rcpp::export]]
IntegerVector decimal_to_fraction_base_10(
    double x, int max_denom, double epsilon
) {
  int n = 0;
  int d = 1;
  IntegerVector result(2);

  while (d <= max_denom) {
    n      = (int) R::fround(x * d, 0);
    result = {n, d};
    if (fabs(x - (double) n / d) < epsilon) {break;}
    d      = d * 10;
  }

  return result;
}

// [[Rcpp::export]]
IntegerMatrix decimal_to_fraction(NumericVector x, bool base_10, int max_denom)
{
  double epsilon  = std::numeric_limits<double>::epsilon();
  int nx          = x.size();
  IntegerMatrix result(2, nx);

  if (base_10) {
    for (int i = 0; i < nx; i++) {
      result(_, i) = decimal_to_fraction_base_10(x[i], max_denom, epsilon);
    }
  } else {
    double sqrt_eps = std::sqrt(epsilon);

    for (int i = 0; i < nx; i++) {
      result(_, i) =
        decimal_to_fraction_cont(x[i], max_denom, sqrt_eps);
    }
  }

  return result;
}

