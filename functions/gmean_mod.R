gmean_mod <- function(x) {
  x[x == 0] <- NA
    DescTools::Gmean(x, na.rm = T)
  }