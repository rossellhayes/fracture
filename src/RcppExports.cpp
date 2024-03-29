// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// decimal_to_fraction
IntegerMatrix decimal_to_fraction(const NumericVector x, const bool base_10, const long max_denom);
RcppExport SEXP _fracture_decimal_to_fraction(SEXP xSEXP, SEXP base_10SEXP, SEXP max_denomSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< const NumericVector >::type x(xSEXP);
    Rcpp::traits::input_parameter< const bool >::type base_10(base_10SEXP);
    Rcpp::traits::input_parameter< const long >::type max_denom(max_denomSEXP);
    rcpp_result_gen = Rcpp::wrap(decimal_to_fraction(x, base_10, max_denom));
    return rcpp_result_gen;
END_RCPP
}
// gcd
int gcd(Rcpp::IntegerVector x);
RcppExport SEXP _fracture_gcd(SEXP xSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Rcpp::IntegerVector >::type x(xSEXP);
    rcpp_result_gen = Rcpp::wrap(gcd(x));
    return rcpp_result_gen;
END_RCPP
}
// lcm
int lcm(Rcpp::IntegerVector x, int max);
RcppExport SEXP _fracture_lcm(SEXP xSEXP, SEXP maxSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< Rcpp::IntegerVector >::type x(xSEXP);
    Rcpp::traits::input_parameter< int >::type max(maxSEXP);
    rcpp_result_gen = Rcpp::wrap(lcm(x, max));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_fracture_decimal_to_fraction", (DL_FUNC) &_fracture_decimal_to_fraction, 3},
    {"_fracture_gcd", (DL_FUNC) &_fracture_gcd, 1},
    {"_fracture_lcm", (DL_FUNC) &_fracture_lcm, 2},
    {NULL, NULL, 0}
};

RcppExport void R_init_fracture(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
