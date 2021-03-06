% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tidy.R
\name{tidy.rma}
\alias{tidy.rma}
\title{Tidying methods for meta-analyis objects}
\usage{
\method{tidy}{rma}(x, conf.int = TRUE, exponentiate = FALSE,
  include_studies = TRUE, measure = "GEN", ...)
}
\arguments{
\item{x}{a meta-analysis object. Currently supports \code{rma.uni} from the
\code{metafor} package.}

\item{conf.int}{logical. Include confidence intervals?}

\item{exponentiate}{logical. Should the estimates and (if \code{conf.int} =
\code{TRUE}) confidence intervals be exponentiated?}

\item{include_studies}{logical. Should individual studies be included in the
output?}

\item{measure}{measure type. See \code{\link[metafor:rma]{metafor::rma()}}}

\item{...}{additional arguments}
}
\value{
a \code{data.frame}
}
\description{
These methods tidy the results of meta-analysis objects
}
\examples{

example_ma \%>\%
  tidy()

}
