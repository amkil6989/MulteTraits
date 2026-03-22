test_that("read_multe_data imports data correctly", {

  data <- read_multe_data()

  expect_true(is.data.frame(data))
  expect_true(nrow(data) > 0)
  expect_true(all(c("site", "seeds") %in% names(data)))
})
