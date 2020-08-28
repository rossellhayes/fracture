test_that("frac_lcm()", {
  expect_equal(frac_lcm(1, 2, 3, 4, 5, 6), 60)
  expect_equal(frac_lcm(1:6), 60)
  expect_equal(frac_lcm(1:6, 7), 420)
})

test_that("max frac_lcm()", {
  expect_equal(frac_lcm(1:6, 7, max = 100), 100)
})

test_that("non-integer frac_lcm()", {
  expect_error(frac_lcm(1:6, 6.5))
})

test_that("frac_gcd()", {
  expect_equal(frac_gcd(12, 42, 60), 6)
  expect_equal(frac_gcd(c(12, 42, 60)), 6)
  expect_equal(frac_gcd(c(12, 42, 60), 39), 3)
})

test_that("non-integer frac_gcd()", {
  expect_error(frac_gcd(c(12, 42, 60), 6.5))
})
