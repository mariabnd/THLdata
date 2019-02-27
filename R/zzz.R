.onLoad <- function(libname, pkgname){
  head <- "https://thl.fi/en/web/thlfi-en/statistics/statistical-databases/open-data"
  if(isFALSE(RCurl::url.exists(head))){
    stop("THL data site not available")
  }
}
