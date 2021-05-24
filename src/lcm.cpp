#define STRICT_R_HEADERS
#include <Rcpp.h>
#include <limits>
#include <numeric>
using namespace Rcpp;

int pair_gcd(int a, int b) {
  if (a == 0) {return b;}
  return pair_gcd(b % a, a);
}

// [[Rcpp::export]]
int gcd(Rcpp::IntegerVector x) {
  Rcpp::IntegerVector::iterator i = x.begin();

  return(std::accumulate(i + 1, i + x.size(), *i, pair_gcd));
}

int pair_lcm(long double a, long double b, int max = 1e7) {
  long double result = (a * b) / pair_gcd(a, b);

  if (result > max) {return (max);}

  return result;
}

// [[Rcpp::plugins("cpp11")]]
// [[Rcpp::export]]
int lcm(Rcpp::IntegerVector x, int max = 1e7) {
  auto lambda_lcm = [&max](int a, int b) {
    return(pair_lcm(a, b, max));
  };

  Rcpp::IntegerVector::iterator i = x.begin();

  return(std::accumulate(i + 1, i + x.size(), *i, lambda_lcm));
}

