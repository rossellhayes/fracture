expect_comparable <- function(object, expected, ...) {
  object   <- unclass(object)
  expected <- unclass(expected)
  expect_equivalent(object, expected, ...)
}

test_that("simple frac_style()", {
  expect_comparable(frac_style(fracture(0.5)), fracture(0.5))
  expect_output(print(frac_style(fracture(0.5))), "¹/₂")
})

test_that("mixed frac_style()", {
  expect_comparable(
    frac_style(fracture(1.5, mixed = TRUE)), fracture(1.5, mixed = TRUE)
  )
  expect_output(print(frac_style(fracture(1.5, mixed = TRUE))), "1 ¹/₂")
})

test_that("vector frac_style()", {
  expect_comparable(frac_style(fracture(c(0.5, 1.5))), fracture(c(0.5, 1.5)))
  expect_output(print(frac_style(fracture(c(0.5, 1.5)))), "¹/₂ ³/₂")
})

test_that("frac_style() coerces to fracture", {
  expect_comparable(frac_style(0.5), fracture(0.5))
  expect_output(print(frac_style(0.5)), "¹/₂")

  expect_comparable(frac_style(1.5, mixed = TRUE), fracture(1.5, mixed = TRUE))
  expect_output(print(frac_style(1.5, mixed = TRUE)), "1 ¹/₂")
})

test_that("frac_style() math", {
  expect_equal(frac_style(fracture(c(0.5, 1.5))) + 1, fracture(c(0.5, 1.5)) + 1)
})
