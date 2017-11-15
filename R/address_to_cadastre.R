#' Gives the map and all the cadaster information of a given address- global function
#'
#' @param address character string
#'
#' @export
#'
#' @examples \dontrun{
#' address_to_cadastre("3 rue d'Olivet 75007 Paris)}
#'
#'
address_to_cadastre <- function(address){

  ##Returns the matrix containing long lat and additional information for the address
  banRmatrix <- address_geocode(address)

  ## Finds the URL of the databases sheets corresponding to the address
  url <- url_cadastre(banRmatrix$citycode,banRmatrix$context)

  ## Downaloads and imports the data in geographical format
  matrice <- load_cadastre_sheet(url,banRmatrix$citycode)
  a <- class(matrice)
  b <- (matrice$parcelles)
  c <- class(matrice$feuilles)

  ## Obtains the reference of the closest parcelle in the database
  polygon_ref <- nearest_polygon(banRmatrix,matrice$parcelles)

  ## Obtains the reference of the feuille containing the address
  feuille_ref <- point_feuille(banRmatrix,matrice$feuilles)

  ## Summarises the information in a phrase to be used on leaflet
  address_information <- address_info(polygon_ref,feuille_ref,matrice$parcelles,matrice$feuilles)

  ## Uses leaflet to show the address and the information obtained
  map_point(banRmatrix,paste("<h4>",banRmatrix$label,"</h4>",address_information))
}
