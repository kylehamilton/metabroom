#' Augment data with values from a meta-analysis model
#'
#' Augment the original data with model residuals, fitted values, and influence
#' statistics.
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
#'   augment()
#'
#' @rdname augmenters
augment.rma <- function(x, ...) {
  blup0 <- purrr::possibly(metafor::blup, NULL)
  residuals0 <- purrr::possibly(stats::residuals, NULL)
  influence0 <- purrr::possibly(stats::influence, NULL)


 y <- x$yi
 pred <- blup0(x)
 if (is.null(pred)) pred <- predict(x)
 pred <- as.data.frame(pred)

 # fix names
 names(pred)[1:4] <- c(".fitted", ".se.fit", "conf.low.fit", "conf.high.fit")
 credible_intervals <- names(pred) %in% c("cr.lb", "cr.ub")
 names(pred)[credible_intervals] <- c("cred.low.fit", "cred.high.fit")
 moderator <- names(pred) == "X"
 names(pred)[moderator] <- "moderator"

 res <- residuals0(x)
 inf <- influence0(x)
 if (!is.null(inf)) {
   inf <- cbind(as.data.frame(inf$inf), dfbetas = inf$dfbs$intrcpt)
   inf <- dplyr::select(
     inf, .hat = hat, .cooksd = cook.d, .std.resid = rstudent,
     .dffits = dffits, .cov.ratio = cov.r,
     tau.squared.del = tau2.del, qe.del = QE.del,
     .weight = weight, .dfbetas = dfbetas)
 }

 ret <- cbind(
   .rownames = x$slab,
   y,
   pred,
   .resid = res
 )

 ret <- tibble::as_tibble(ret) %>%
   tibble::remove_rownames()

  if (all(ret$.rownames == seq_along(ret$.rownames))) {
    ret$.rownames <- NULL
  }

  ret
}
