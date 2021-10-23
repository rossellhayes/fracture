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
  x    <- c(list(...), recursive = TRUE)
  ints <- as.integer(x)

  if (
    !isTRUE(all.equal(x, ints, check.attributes = FALSE, check.names = FALSE))
  ) {
    stop("The least common multiple can only be calculated for integers.")
  }

  lcm(ints, max)
}

#' @rdname frac_lcm
#' @export

frac_gcd <- function(...) {
  x    <- c(list(...), recursive = TRUE)
  ints <- as.integer(x)

  if (
    !isTRUE(all.equal(x, ints, check.attributes = FALSE, check.names = FALSE))
  ) {
    stop("The greatest common divisor can only be calculated for integers.")
  }

  gcd(ints)
}
