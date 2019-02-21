#' Augment data according to a tidied meta-analysis model.
#'
#' Given a metafor model, add columns to the original dataset such as
#' predictions, residuals and cluster assignments.
#'
#' As far as I can see, there is no way to call the original dataframe from the
#' - unfinished, needs troubleshooting.
#'
#' @param x A meta-analysis model produced by metafor's rma function.
#'
#' @export

augment <- function(x) {
  tibble(
    yi = x$yi,
    vi = x$vi,
    # ah, looks like I never got tis working, back in the day.

        # Q: Why did I write this line of code?
    # .study = weights.rma.uni(x) %>% names(),

    .ci_lb = x$ci.lb,
    .ci_ub = x$ci.ub,
    # Q: Why did I write this line of code?

    # .weight = weights.rma.uni(x) %>% as.numeric(),
    .beta = x$beta %>% as.numeric(),
    .se.beta = x$se
  )
}
