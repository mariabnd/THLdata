#' List available data sets on THL website
#'
#' Retrieves the available collectons of data
#'
#' @export
#' @import stringr
#' @import dplyr
#' @examples
#' list_available()
#' @seealso [list_collection()]
list_available <- function(...){
  init <- initiate()
  sets <- stringr::str_remove(stringr::str_remove(string = init$opts,
                                                  pattern = init$prefix),
                              pattern = "http://")
  tmp <- lapply(str_split(sets, "/"), function(x) x[[1]])
  tmp2 <- lapply(str_split(sets, "/"), function(x) x[[2]])
  tmp2 <- lapply(str_split(tmp2, ".json"), function(x) x[[1]])
  dat <- cbind(do.call(c, tmp), do.call(c, tmp2))
  colnames(dat) <- c("category", "set")
  return(dplyr::as_tibble(dat))
}

#' List data sets contained in collection
#'
#' Retrieves the available collectons of data in a set
#'
#' @param category
#' @param set
#' @export
#' @import httr
#' @import dplyr
#' @import jsonlite
#' @examples
#' # Vaccination data sets
#' list_collection("vaccreg", "coverage")
#' @seealso [list_available()]
list_collection <- function(category, set, ...){
  init <- initiate()
  selection <- paste0(init$prefix, category, "/", set, ".json")

  resp <- httr::GET(selection)
  if(httr::http_type(resp) != "application/json"){
    stop("API did not return json", call. = FALSE)
  }

  return(dplyr::as_tibble(jsonlite::fromJSON(content(resp, "text"),
                                             simplifyDataFrame = TRUE)[[1]][[1]]))
}
