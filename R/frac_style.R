#' Style a fracture with superscripts and subscripts
#'
#' Uses Unicode superscripts and subscripts to format a fracture.
#'
#' @param fracture A vector created by [fracture()] or [as.fracture()].
#'
#' @return `fracture` with numerators formatted with Unicode superscripts and
#'   denominators formatted with Unicode subscripts.
#' @export
#'
#' @examples

frac_style <- function(fracture) {
  if (!is.fracture(fracture)) {stop('Input must be a "fracture".')}
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

  frac_style <- as.fracture_paste(frac_style)

  structure(
    fracture,
    frac_style = frac_style,
    numeric = as.numeric(fracture),
    class   = c("frac_style", class(fracture))
  )
}

#' @export

as.character.frac_style <- function(x, ...) {
  attr(x, "frac_style")
}

#' @export

print.frac_style <- function(x, ...) {
  x <- as.character(x)
  NextMethod("print", quote = FALSE)
}
