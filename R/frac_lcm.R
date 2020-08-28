#' Least common multiple and greatest common divisor
#'
#' @param ... Integer vectors or vectors that can be coerced to integer.
#' @param max If the least common multiple is greater than `max`, `max` is
#'   returned instead.
#'
#' @return An integer.
#' @export
#'
#' @example examples/frac_lcm.R

frac_lcm <- function(..., max = 1e7) {
  x <- c(list(...), recursive = TRUE)

  if (any(x != as.integer(x))) {
    stop("The least common multiple can only be calculated for integers.")
  }

  lcm(x, max)
}

#' @rdname frac_lcm
#' @export

frac_gcd <- function(...) {
  x <- c(list(...), recursive = TRUE)

  if (any(x != as.integer(x))) {
    stop("The greatest common divisor can only be calculated for integers.")
  }

  gcd(x)
}
