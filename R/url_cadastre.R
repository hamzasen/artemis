#' Gives the URL of the cadastre datanase corresponding to the city of the address input in geocode_address
#'
#' @param city_code numerical vector from geocode result
#' @param context character vector from geocode result
#'
#' @return character vector
#' @export
#'
#' @examples
#' \dontrun{
#' url_cadastre(75107,"75, Paris")
#' }
#'
url_cadastre <- function(city_code,context){

  ## Transform the banR data into strings to be able to construct the URL with paste
  city_code <- toString(city_code)
  context <- toString(context)

  ## Isolates the department number from the context column of the banR matrix; The department number is used in the URL
  dep <- strsplit(context,",")[[1]][1]

  ## This is the basis of every cadaster url in the official database
  url_basis <- "https://cadastre.data.gouv.fr/data/etalab-cadastre/latest/geojson/communes"

  ## The URL end with "cadastre/the_city_code/the_type_of_info
  ## In order to obtain the information, we need both parcelles and feuilles
  type <- c("parcelles","feuilles")
  url_end <- paste("cadastre", city_code, type, sep="-")

  ## Pastes the different parts to complete the URL witout the .json.gz extension
  url <- paste(url_basis, dep, city_code, url_end, sep="/")

  ## Adding the extension
  url <- paste(url,".json.gz",sep = "")

  ## Returns a vector with two different URLS for the parcelles sheet and the feuilles sheet
  return(url)
}
