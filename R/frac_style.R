#' Style a fracture with superscripts and subscripts
#'
#' Uses Unicode superscripts and subscripts to format a fracture.
#'
#' @param fracture A [fracture] or a vector to be passed to [fracture()].
#' @param ... Additional arguments passed to [fracture()].
#'
#' @return `fracture` with numerators formatted with Unicode superscripts and
#'   denominators formatted with Unicode subscripts.
#' @export
#'
#' @example examples/frac_style.R

frac_style <- function(fracture, ...) {
  if (!is.fracture(fracture)) {fracture <- fracture(fracture, ...)}
  frac_mat <- as.frac_mat(fracture)

  if (nrow(frac_mat) == 3) {
    zeroes <- frac_mat[2, ] == 0 & frac_mat[3, ] %in% c(0, 1)
  } else {
    zeroes <- FALSE
  }

  frac_style   <- frac_mat
  frac_style[] <- as.character(frac_style)

  frac_style[
    "numerator", !zeroes & !is_NAish(frac_mat["numerator", ])
  ] <- vapply(
    lapply(
      strsplit(
        frac_style["numerator", !zeroes & !is_NAish(frac_mat["numerator", ])],
        ""
      ),
      function(x) numerators[x] %||% x
    ),
    paste,
    character(1),
    collapse = ""
  )


  frac_style[
    "denominator", !zeroes & !is_NAish(frac_mat["denominator", ])
  ] <- vapply(
    lapply(
      strsplit(
        frac_style[
          "denominator", !zeroes & !is_NAish(frac_mat["denominator", ])
        ],
        ""
      ),
      function(x) denominators[x] %||% x
    ),
    paste,
    character(1),
    collapse = ""
  )

  as.fracture_paste(frac_style)
}

is_NAish <- function(x) {
  is.na(x) | x == "NaN"
}

`%||%` <- function(lhs, rhs) {
  lhs[is.na(lhs)] <- rhs[is.na(lhs)]
  lhs
}
