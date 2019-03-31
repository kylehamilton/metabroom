context("test example from metafor::")

library(metabroom)

test_that("example dataset is the right class", {
  expect_true("rma" %in% class(example_ma))
})

test_that("tidy produces a non-empty df", {
  expect_is(example_ma %>% tidy(), "data.frame")
  expect_gte(example_ma %>% tidy() %>% nrow(), 1)
})

test_that("glance produces a non-empty df", {
  expect_is(example_ma %>% glance(), "data.frame")
  expect_gte(example_ma %>% glance() %>% nrow(), 1)
})

test_that("augment produces a non-empty df", {
  expect_is(example_ma %>% augment(), "data.frame")
  expect_gte(example_ma %>% augment() %>% nrow(), 1)
})

