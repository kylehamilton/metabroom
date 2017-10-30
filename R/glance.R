#' Construct a single-row summary "glance" of a meta-analysis model.
#'
#' This function is analogous to the broom::tidy function but for meta-analysis
#' models.

#' glance methods always return either a one-row data frame, or NULL.
#'
#' @param x A meta-analysis model produced by metafor's rma function.
#'
#' @export

glance <- function(x) {
  tibble(
    measure = x$measure,
    tau2 = x$tau2,
    se_tau2 = x$se.tau2,
    method = x$method,
    no_studies = x$k,
    no_coef = x$p,
    I2 = x$I2,
    H2 = x$H2,
    QE = x$QE,
    QE_p = x$QEp,
    QM = x$QM,
    QM_p = x$QMp
  ) %>%
    cbind(x$fit.stats %>% select(REML) %>% t()) %>%
    rownames_to_column("remove_this") %>%
    select(-remove_this)
}
