#' Tidy the result of a meta-analysis into a summary data.frame.
#'
#' This function is analogous to the broom::tidy function but for meta-analysis
#' models.
#'
#' From the broom tidy documentation:
#' The output of tidy is always a data.frame with disposable row names.
#' It is therefore suited for further manipulation by packages like dplyr,
#' reshape2, ggplot2 and ggvis.
#'
#' This aims to produce a data frame that summarises the model's statistical
#' findings.
#'
#' @param x A meta-analysis model produced by metafor's rma function.
#'
#' @export

tidy <- function(df) {
  # We take our brief from the broom vignette:
  # http://onlinelibrary.wiley.com/doi/10.1359/JBMR.0301265/full
  #
  # tidy: constructs a data frame that summarizes the model's statistical
  # findings. This includes coefficients and p-values for each term in a
  # regression, per-cluster information in clustering applications, or per-test
  # information for multtest functions.

  df %>% {
    tibble(
      coef = .$b %>% as.numeric(),
      se = .$se,
      p_value = .$pval,
      ci_lb = .$ci.lb,
      ci_ub = .$ci.ub,
      tau2 = .$tau2
  )}
}
