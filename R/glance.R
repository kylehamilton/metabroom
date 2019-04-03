#' Construct a one-row summary of meta-analysis model fit statistics.
#'
#' `glance()` computes a one-row summary of  meta-analysis objects,
#'  including estimates of heterogenity and model fit.
#'
#' @param x a meta-analysis object. Currently supports `rma.uni` from the
#'   `metafor` package.
#' @param ... additional arguments
#'
#' @return a `data.frame`
#' @export
#'
#' @examples
#'
#' example_ma %>%
#'   glance()
#'
glance.rma <- function(x, ...) {
  fit_stats <- metafor::fitstats(x)
  fit_stats <- fit_stats %>%
    t() %>%
    as.data.frame()
  names(fit_stats) <-
    stringr::str_replace(names(fit_stats), "\\:", "")

  list(
    k = x$k,
    measure = x$measure,
    method = x$method,
    i.squared = x$I2,
    h.squared = x$H2,
    tau.squared = x$tau2,
    tau.squared.se = x$se.tau2,
    QE = x$QE,
    QE_p = x$QEp,
    QM = x$QM,
    QM_p = x$QMp,
    fit_stats
  ) %>%
    # get rid of null values
    purrr::discard(is.null) %>%
    # change to tibble with correct column and row names
    as.data.frame() %>%
    tibble::as_tibble() %>%
    tibble::remove_rownames()
}
