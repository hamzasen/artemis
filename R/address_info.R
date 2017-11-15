#' Gives the cadaster information of an address
#'
#' @param polygon_ref numeric
#' @param feuille_ref numeric
#' @param matrix_parcelles matrix corresponding to the given address (parcelles category) in the cadastre database
#' @param matrix_feuilles matrix corresponding to the given address (feuilles category) in the cadastre database
#'
#' @return character string
#' @import stringr
#'
#' @examples \dontrun{
#' adress_info(1,1,parcelles75107.json,feuilles75107.json)
#' }
#'

address_info <- function(polygon_ref, feuille_ref,matrix_parcelles,matrix_feuilles){

  ## Gives the id of the parcelle that corresponds to the address given
  id_parcelles <- as.character(matrix_parcelles$id[polygon_ref])

  ## By subsetting the id we obtain the parcelle number and the city section
  num_parcelles <- substr(id_parcelles,nchar(id_parcelles)-3,nchar(id_parcelles))
  city_section <- stringr::str_extract(id_parcelles, "[A-Z]+" )

  ## This obtains the surface of the parcelle that corresponds to the address
  surface <- matrix_parcelles$contenance[polygon_ref]

  ## Gives the id of the feuille that corresponds to the address given, which is subsetted to get the feuille number
  id_feuille <- as.character(matrix_feuilles$id[feuille_ref])
  num_feuille <- substr(id_feuille,6,nchar(id_feuille))

  ## Returns a text with the information that will be shown on leaflet
  information <- paste("<b>","Parcel Number: ","</b>",num_parcelles,"<br>",
                       "<b>","City section: ","</b>",city_section,"<br>",
                       "<b>","Feuille number: ","</b>",num_feuille,"<br>",
                       "<b>","Surface: ","</b>", surface,"m2")

  return(information)
}
