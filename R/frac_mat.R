#' Convert decimals to a matrix of numerators and denominators
#'
#' @param x A vector of decimals or, for `as.frac_mat()`, a character vector
#'   created by [fracture()]
#' @param base_10 If `TRUE`, all denominators will be a power of 10.
#' @param common_denom If `TRUE`, all fractions will have the same denominator.
#'
#'   If the least common denominator is greater than `max_denom`,
#'   `max_denom` is used.
#'
#' @param mixed If `TRUE`, `integer` components will be displayed separately
#'   from fractional components for `x` values greater than 1.
#'
#'   If `FALSE`, improper fractions will be used for `x` values greater than 1.
#'
#' @param max_denom All denominators will be less than or equal to
#'   `max_denom`.
#'
#'   If `base_10` is `TRUE`, the maximum denominator will be the largest power
#'   of 10 less than `max_denom`.
#'
#'   A `max_denom` greater than the inverse square root of
#'   [machine double epsilon][.Machine] will produce a warning because floating
#'   point rounding errors can occur when denominators grow too large.
#'
#' @return A matrix with the same number of columns as the length of `x` and
#'   rows for `integer`s (if `mixed` is `TRUE`), `numerator`s,
#'   and `denominator`s.
#' @seealso [fracture()] to return a character vector of fractions.
#' @export
#'
#' @example examples/frac_mat.R

frac_mat <- function(
  x, base_10 = FALSE, common_denom = FALSE, mixed = FALSE, max_denom = 1e7
) {
  if (base_10) {max_denom <- 10 ^ floor(log(max_denom, base = 10))}

  max_max_denom <- 1 / sqrt(.Machine$double.eps)
  if (max_denom > max_max_denom) {
    warning(
      "Using a `max_denom` greater than ", max_max_denom,
      " is not recommended.", "\n",
      "Using a larger `max_denom` may cause floating point errors."
    )
  }

  integer <- ifelse(x >= 0, x %/% 1, (x %/% 1 + 1))
  integer <- ((x > 0) * 1 + (x < 0) * -1) * (abs(x) %/% 1)
  decimal <- x - integer

  if (any(is.na(decimal)) || any(is.infinite(decimal))) {
    stop("`x` must be a vector of finite numbers.")
  }

  matrix <- decimal_to_fraction(decimal, base_10, max_denom)

  if (common_denom) {
    denom       <- lcm(matrix[2, ], max_denom)
    matrix[1, ] <- round(matrix[1, ] * (denom / matrix[2, ]))
    matrix[2, ] <- denom
  } else {
    extrema           <- which(
      (matrix[1, ] == 1 & matrix[2, ] == 1) | (matrix[1, ] == 0 & integer == 0)
    )
    matrix[, extrema] <- matrix[, extrema] * max_denom
  }

  rownames(matrix) <- c("numerator", "denominator")

  if (mixed) {
    matrix              <- rbind(integer, matrix)
    negative            <- which(matrix[1, ] < 0)
    matrix[2, negative] <- abs(matrix[2, negative])
  } else {
    matrix[1, ] <- integer * matrix[2, ] + matrix[1, ]
  }

  matrix
}

#' @rdname frac_mat
#' @export

as.frac_mat <- function(x) {
  if (is.fracture(x)) {
    split               <- strsplit(x, " |/")
    lengths             <- vapply(split, length, integer(1))

    if (all(lengths == 2)) {
      matrix              <- do.call("cbind", split)
      rownames(matrix)    <- c("numerator", "denominator")
    } else {
      split[lengths == 1] <- lapply(split[lengths == 1], function(x) c(x, 0, 0))
      split[lengths == 2] <- lapply(split[lengths == 2], function(x) c(0, x))
      matrix              <- do.call("cbind", split)
      rownames(matrix)    <- c("integer", "numerator", "denominator")
    }

    mode(matrix) <- "integer"
    matrix
  } else {
    frac_mat(x)
  }
}

#' @rdname frac_mat
#' @export

is.frac_mat <- function(x) {
  is.matrix(x) &&
    is.numeric(x) &&
    all(x %% 1 == 0) &&
    nrow(x) %in% 2:3 &&
    !is.null(rownames(x)) &&
    all(rownames(x) %in% c("integer", "numerator", "denominator"))
}
