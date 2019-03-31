example_ma <- data("dat.normand1999", package = "metafor") %>% # Get an example dataset.
  get() %>% # NB: slab (i.e., study) := "source".
  metafor::escalc( # Calculate effect.
    measure = "SMD",
    n1i = n1i,
    m1i =m1i,
    sd1i = sd1i,
    n2i = n2i,
    m2i = m2i,
    sd2i = sd2i,
    data = .
  ) %>%
  metafor::rma( # Meta-analyse!
    slab = source
  )

usethis::use_data(example_ma, overwrite = TRUE)
