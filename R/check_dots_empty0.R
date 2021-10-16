check_dots_empty0 <- function(..., match.call) {
  if (!empty(...)) {
    call        <- as.list(match.call[-1])
    dots        <- call[lapply(call, eval) %in% list(...)]
    names       <- names(dots)
    named       <- which(names != "")
    args        <- vapply(dots, deparse, character(1))
    args[named] <- paste(names[named], "=", args[named])

    stop(
      paste(
        "`...` is not empty.",
        "These dots only exist to allow future extensions and should be empty.",
        "We detected these problematic arguments:",
        paste0("* `", args, "`", collapse = "\n"),
        "Did you misspecify an argument?",
        sep = "\n"
      ),
      call. = FALSE
    )
  }
}

empty <- function(...) {
  nargs() == 0
}
