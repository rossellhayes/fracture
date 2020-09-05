.onUnload <- function(libpath) {
  library.dynam.unload("fracture", libpath)
}

release_questions <- function() {
  "Have you checked sanitizers (with `rhub::check_with_sanitizers()`)?"
}
