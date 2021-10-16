test_that("empty dots", {
  expect_snapshot_error(fracture(1, "test"))
  expect_snapshot_error(fracture(1, z = 20))
  expect_snapshot_error(fracture(1, "test", z = letters))
  expect_snapshot_error(fracture(1, list(1:10)))
  expect_snapshot_error(fracture(1, z = c(letters, 20)))
  expect_snapshot_error(fracture(1, list(1:10), z =c(letters, 20)))
})
