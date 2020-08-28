test_that("scalar frac_mat()", {
  mat <- frac_mat(0.5)
  expect_equivalent(mat, c(1, 2))
  expect_equal(nrow(mat), 2)
  expect_equal(ncol(mat), 1)
  expect_equal(rownames(mat), c("numerator", "denominator"))
})

test_that("vector frac_mat()", {
  mat <- frac_mat(c(0.5, 0.75, 2/3))
  expect_equivalent(mat, matrix(c(1, 2, 3, 4, 2, 3), nrow = 2))
  expect_equal(nrow(mat), 2)
  expect_equal(ncol(mat), 3)
  expect_equal(rownames(mat), c("numerator", "denominator"))
})

test_that("improper frac_mat()", {
  mat <- frac_mat(c(1.5, 2))
  expect_equivalent(mat, c(3, 2, 2, 1))
  expect_equal(nrow(mat), 2)
  expect_equal(ncol(mat), 2)
  expect_equal(rownames(mat), c("numerator", "denominator"))
})

test_that("negative frac_mat()", {
  mat <- frac_mat(-0.5)
  expect_equivalent(mat, c(-1, 2))
  expect_equal(nrow(mat), 2)
  expect_equal(ncol(mat), 1)
  expect_equal(rownames(mat), c("numerator", "denominator"))
})

test_that("base_10 frac_mat()", {
  mat <- frac_mat(0.5, base_10 = TRUE)
  expect_equivalent(mat, c(5, 10))
  expect_equal(nrow(mat), 2)
  expect_equal(ncol(mat), 1)
  expect_equal(rownames(mat), c("numerator", "denominator"))
})

test_that("common_denom frac_mat()", {
  mat <- frac_mat(c(0.5, 0.75, 2/3), common_denom = TRUE)
  expect_equivalent(mat, matrix(c(6, 12, 9, 12, 8, 12), nrow = 2))
  expect_equal(nrow(mat), 2)
  expect_equal(ncol(mat), 3)
  expect_equal(rownames(mat), c("numerator", "denominator"))
})

test_that("mixed frac_mat()", {
  mat <- frac_mat(c(1.5, 0.5, 1), mixed = TRUE)
  expect_equivalent(mat, c(1, 1, 2, 0, 1, 2, 1, 0, 1))
  expect_equal(nrow(mat), 3)
  expect_equal(ncol(mat), 3)
  expect_equal(rownames(mat), c("integer", "numerator", "denominator"))
})

test_that("mixed negative frac_mat()", {
  mat <- frac_mat(c(-0.5, -4/3), mixed = TRUE)
  expect_equivalent(mat, matrix(c(0, -1, 2, -1, 1, 3), nrow = 3))
  expect_equal(nrow(mat), 3)
  expect_equal(ncol(mat), 2)
  expect_equal(rownames(mat), c("integer", "numerator", "denominator"))
})

test_that("max_denom frac_mat()", {
  mat <- frac_mat(pi, max_denom = 100)
  expect_equivalent(mat, matrix(c(22, 7), nrow = 2))
  expect_equal(nrow(mat), 2)
  expect_equal(ncol(mat), 1)
  expect_equal(rownames(mat), c("numerator", "denominator"))

  mat <- frac_mat(pi, max_denom = 1000)
  expect_equivalent(mat, matrix(c(355, 113), nrow = 2))
  expect_equal(nrow(mat), 2)
  expect_equal(ncol(mat), 1)
  expect_equal(rownames(mat), c("numerator", "denominator"))
})

test_that("base_10 max_denom frac_mat()", {
  mat <- frac_mat(c(1/2, 1/3, 1/4), base_10 = TRUE, max_denom = 1000)
  expect_equivalent(mat, matrix(c(5, 10, 333, 1000, 25, 100), nrow = 2))
  expect_equal(nrow(mat), 2)
  expect_equal(ncol(mat), 3)
  expect_equal(rownames(mat), c("numerator", "denominator"))
})

test_that("base_10 common_denom max_denom frac_mat()", {
  mat <- frac_mat(
    c(1/2, 1/3, 1/4), base_10 = TRUE, common_denom = TRUE, max_denom = 1000
  )
  expect_equivalent(mat, matrix(c(500, 1000, 333, 1000, 250, 1000), nrow = 2))
  expect_equal(nrow(mat), 2)
  expect_equal(ncol(mat), 3)
  expect_equal(rownames(mat), c("numerator", "denominator"))
})

test_that("epsilon without common_denom frac_mat()", {
  mat <- frac_mat(c(1e-10, 1 - 1e-10), max_denom = 100)
  expect_equivalent(mat, matrix(c(0, 100, 100, 100), nrow = 2))
  expect_equal(nrow(mat), 2)
  expect_equal(ncol(mat), 2)
  expect_equal(rownames(mat), c("numerator", "denominator"))
})

test_that("epsilon with common_denom frac_mat()", {
  mat <- frac_mat(c(1e-10, 1 - 1e-10, 1/3), common_denom = TRUE)
  expect_equivalent(mat, matrix(c(0, 3, 3, 3, 1, 3), nrow = 2))
  expect_equal(nrow(mat), 2)
  expect_equal(ncol(mat), 3)
  expect_equal(rownames(mat), c("numerator", "denominator"))
})

test_that("big max_denom frac_mat()", {
  expect_warning(frac_mat(0.5, max_denom = 1e10))
})
