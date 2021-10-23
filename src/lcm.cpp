#define STRICT_R_HEADERS
#include <limits>
#include <numeric>
#include <cpp11/integers.hpp>
using namespace cpp11;

int pair_gcd(int a, int b) {
  if (a == 0) {return b;}
  return pair_gcd(b % a, a);
}

[[cpp11::register]]
int gcd(integers x) {
  return std::accumulate(x.begin(), x.end(), x[1], pair_gcd);
}

int pair_lcm(long double a, long double b, int max = 1e7) {
  long double result = (a * b) / pair_gcd(a, b);

  if (result > max) {return (max);}

  return result;
}

[[cpp11::register]]
int lcm(integers x, int max = 1e7) {
  auto lambda_lcm = [&max](int a, int b) {
    return(pair_lcm(a, b, max));
  };

  return std::accumulate(x.begin(), x.end(), x[1], lambda_lcm);
}

