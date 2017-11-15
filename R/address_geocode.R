#' Gives the geocode of the address given by the user
#'
#' @param address character parameter under the format "street number street type street name postcode city name"
#'
#' @return numeric vector
#' @import banR assertthat
#'
#' @examples
#' \dontrun{
#' assert_geocode(12 rue de Rivoli 75001 Paris)}
#'
address_geocode <- function(address){

  ## Checks that the address is a character
  assertthat::assert_that(is.character(address))

  ## Selects the first row (most likely) returned by the banR search with the address
  coord <- banR::geocode(address)
  coord <- coord[1,]

  ## Returns a matrix with all information for the input address
  return(coord)

}
