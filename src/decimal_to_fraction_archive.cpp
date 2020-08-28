// #include <Rcpp.h>
// #include <limits>
// using namespace Rcpp;
//
// IntegerVector pair_decimal_to_fraction(
//     double x, bool base_10, int max_denom, double epsilon, double sqrt_eps
// ) {
//   int sign              = 1;
//   int numer             = 0;
//   int numer_guess       = 0;
//   int denom             = 1;
//   int denom_guess       = 1;
//   double fraction       = 0;
//   double fraction_guess = 0;
//
//   if (x < 0) {
//     sign = -1;
//     x    = x * -1;
//   }
//
//   if (x - 0 < sqrt_eps) {
//     numer    = 0;
//     denom    = 1;
//     fraction = x;
//   } else if (1 - x < sqrt_eps) {
//     numer    = 1;
//     denom    = 1;
//     fraction = x;
//   } else
//     if (base_10) {
//     for (int i = 1; i <= max_denom; i = i * 10) {
//       denom_guess    = i;
//       numer_guess    = (int) R::fround(x * denom_guess, 0);
//       fraction_guess = (double) numer_guess / denom_guess;
//
//       if (fabs(x - fraction_guess) < fabs(x - fraction)) {
//         numer    = numer_guess;
//         denom    = denom_guess;
//         fraction = (double) numer / denom;
//         if (fabs(x - fraction) < epsilon) {break;}
//       }
//     }
//   } else {
//     int numer_min = 0;
//     int numer_max = 1;
//     int denom_min = 1;
//     int denom_max = 1;
//     denom_guess   = 1;
//
//     while ((fabs(x - fraction) > epsilon) & (denom_guess <= max_denom)) {
//       if (fabs(x - fraction_guess) < fabs(x - fraction)) {
//         numer    = numer_guess;
//         denom    = denom_guess;
//         fraction = (double) numer / denom;
//       }
//
//       numer_guess    = numer_min + numer_max;
//       denom_guess    = denom_min + denom_max;
//       fraction_guess = (double) numer_guess / denom_guess;
//
//       if (fraction_guess > x) {
//         numer_max = numer_guess;
//         denom_max = denom_guess;
//       } else {
//         numer_min = numer_guess;
//         denom_min = denom_guess;
//       }
//     }
//   }
//
//   return IntegerVector::create(numer * sign, denom);
// }
//
// // [[Rcpp::export]]
// IntegerMatrix decimal_to_fraction(NumericVector x, bool base_10, int max_denom)
// {
//   double epsilon  = std::numeric_limits<double>::epsilon();
//   double sqrt_eps = std::sqrt(epsilon);
//   int nx          = x.size();
//   IntegerMatrix result(2, nx);
//
//   for (int i = 0; i < nx; i++) {
//     result(_, i) =
//       pair_decimal_to_fraction(x[i], base_10, max_denom, epsilon, sqrt_eps);
//   }
//
//   return result;
// }
