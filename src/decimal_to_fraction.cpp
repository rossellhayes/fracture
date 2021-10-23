#define STRICT_R_HEADERS
#include <cfloat>
#include <Rmath.h>
#include <cpp11/integers.hpp>
#include <cpp11/doubles.hpp>
#include <cpp11/matrix.hpp>
using namespace cpp11;
namespace writable = cpp11::writable;

integers decimal_to_fraction_cont(const double x, const long max_denom) {
  double n0 = 0;
  double n1 = 1;
  double n2 = floor(x);
  double d0 = 0;
  double d1 = 0;
  double d2 = 1;
  double f  = n2;
  double z  = x - n2;
  writable::integers result(2);

  while (d2 <= max_denom) {
    z  = 1 / z;
    f  = floor(z);
    z  = z - f;
    n0 = n1;
    n1 = n2;
    n2 = f * n1 + n0;
    d0 = d1;
    d1 = d2;
    d2 = f * d1 + d0;
    if (fabs(x - n1 / d1) < DBL_EPSILON) {break;}
    if (f == 0) {break;}
  }

  result[0] = n1;
  result[1] = d1;
  return result;
}

integers decimal_to_fraction_base_10(const double x, const long max_denom)
{
  double n = 0;
  double d;
  writable::integers result(2);

  for (long i = 1; i <= max_denom; i *= 10) {
    d = i;
    n = Rf_fround(x * d, 0);
    if (fabs(x - n / d) <= sqrt(DBL_EPSILON)) {break;}
  }

  result[0] = n;
  result[1] = d;
  return result;
}

[[cpp11::register]]
integers_matrix<> decimal_to_fraction(
    const doubles x, const bool base_10, const long max_denom
) {
  writable::integers_matrix<> matrix(2, x.size());

  if (base_10) {
    for (int i = 0; i < x.size(); i++) {
      integers vector = decimal_to_fraction_base_10(x[i], max_denom);
      matrix(0, i) = vector[0];
      matrix(1, i) = vector[1];
    }

    return matrix;
  }

  for (int i = 0; i < x.size(); i++) {
    integers vector = decimal_to_fraction_cont(x[i], max_denom);
    matrix(0, i) = vector[0];
    matrix(1, i) = vector[1];
  }

  return matrix;
}
