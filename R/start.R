#' Helper function that obtains all the bits and pieces we need
#'
#' This is a wrapper which creates an object which we use in other functions
#'
#' @import xml2
#' @import rvest
#' @import stringr
initiate <- function(...){
  head <- "https://thl.fi/en/web/thlfi-en/statistics/statistical-databases/open-data"
  pg <- xml2::read_html(head)
  at <- rvest::html_attr(rvest::html_nodes(pg, "a"), "href")
  opts <- stringr::str_remove(at[which(stringr::str_detect(string = unlist(at),
                                                           pattern = ".json") == TRUE)],
                              pattern = "http://")
  opts <- unique(opts)
  prefix <- "https://sampo.thl.fi/pivot/prod/api/"
  return(list(head = head, opts = opts, prefix = prefix))
}
