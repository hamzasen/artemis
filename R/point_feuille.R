#' Produces the reference of the feuille corresponding to the point
#'
#' @param banRmatrix matrix given out by banR
#' @param cadastre_sheet_feuilles corresponding cadaster_sheet in dataframe form
#'
#' @return integer
#' @import sf
#' @export
#'
#' @examples \dontrun{
#' point_feuille(geocode_address("youradrress"),feuille_cadaster_sheet.json)}
#'
point_feuille <- function(banRmatrix,cadastre_sheet_feuilles){

  ## Transforms the banRmatrix longitude & latitude into geographical objects with CRS
  point <- sf::st_point(c(banRmatrix$longitude, banRmatrix$latitude))
  point <- sf::st_sfc(point, crs = 4326)

  ## Changes CRS to go from longitude latitude to UTM to be able to compute distance both for point and matrix
  UTM_point <- sf::st_transform(point, crs = 32748)
  UTM_sheet <- cadastre_sheet_feuilles %>%
    sf::st_transform(crs = 32748)

  ## Evaluate distance between the point from the addres and every feuille area in the downloaded dataframe
  distance_matrix <- sf::st_distance(UTM_point, UTM_sheet)

  ## Chososes the feuille closest (containing) to the point
  point_feuille_reference <- which.min(distance_matrix)

  ## Returns its row number
  return(point_feuille_reference)
}
