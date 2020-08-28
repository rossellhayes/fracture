# continued_fraction <- function(x) {
#   integer   <- rep(0, 20)
#   remainder <- 1
#   i         <- 1
#
#   while (remainder > sqrt(.Machine$double.eps) & i < 20) {
#     integer[i] <- floor(x)
#     remainder  <- x - integer[i]
#     x          <- 1 / remainder
#     i          <- i + 1
#   }
#
#   integer[integer > sqrt(.Machine$double.eps)]
# }
#
# decimal_to_fraction <- function(x, max_denom = 1e7) {
#   cont_frac <- c(continued_fraction(x), 0)
#   n_old     <- 1
#   d_old     <- 0
#   n         <- cont_frac[1]
#   d         <- 1
#   i         <- 1
#
#   while (i < length(cont_frac) & d <= max_denom) {
#     result <- c(n, d)
#     i      <- i + 1
#     n_curr <- n
#     d_curr <- d
#     n      <- cont_frac[i] * n + n_old
#     d      <- cont_frac[i] * d + d_old
#     n_old  <- n_curr
#     d_old  <- d_curr
#   }
#
#   result
# }
