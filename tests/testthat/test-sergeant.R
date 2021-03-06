context("basic functionality")
test_that("we can do something", {

  testthat::skip_on_cran()
  testthat::skip_on_travis()

  ds <- src_drill("drill1")
  db <- tbl(ds, "cp.`employee.json`")

  count(db, gender, marital_status) %>%
    collect() -> res

  expect_that(res, is_a("data.frame"))

  dc <- drill_connection("drill1")
  expect_equal(drill_active(dc), TRUE)

  con <- drill_jdbc("drill1:2181", "jla")
  res <- drill_query(con, "SELECT * FROM cp.`employee.json`")
  expect_that(res, is_a("data.frame"))

})
