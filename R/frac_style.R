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
  frac_style <- as.frac_mat(fracture)

  frac_style[] <- as.character(frac_style)
  frac_style["numerator", ] <- vapply(
    strsplit(frac_style["numerator", ], ""),
    function(x) paste(numerators[as.numeric(x) + 1], collapse = ""),
    character(1)
  )
  frac_style["denominator", ] <- vapply(
    strsplit(frac_style["denominator", ], ""),
    function(x) paste(denominators[as.numeric(x) + 1], collapse = ""),
    character(1)
  )

  as.fracture_paste(frac_style)
}
