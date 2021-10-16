test_that("simple frac_style()", {
  expect_equal(frac_style(fracture(0.5)), "¹/₂")
})

test_that("mixed frac_style()", {
  expect_equal(frac_style(fracture(1.5, mixed = TRUE)), "1 ¹/₂")
})

test_that("vector frac_style()", {
  expect_equal(frac_style(fracture(c(0.5, 1.5))), c("¹/₂", "³/₂"))
})

test_that("frac_style() coerces to fracture", {
  expect_equal(frac_style(0.5), "¹/₂")
  expect_equal(frac_style(1.5, mixed = TRUE), "1 ¹/₂")
})
