#' Returns the closes polygon to a long lat point
#'
#' @param banRmatrix the banR matrix given by address_geocode
#' @param cadaster_sheet the corresponding cadaster sheet in dataframe form
#'
#' @return integer
#' @import sf
#' @export
#'
#' @examples \dontrun{
#' nearest_polygon(geocode_address("5 rue d'Olivet 75007"),cadaster_sheet_75107)
#' }
#'
nearest_polygon <- function(banRmatrix,cadaster_sheet){

  ## Transforms the banRmatrix longitude & latitude into geographical objects with CRS
  point <- sf::st_point(c(banRmatrix$longitude, banRmatrix$latitude))
  point <- sf::st_sfc(point, crs = 4326)

  ## Changes CRS to go from longitude latitude to UTM to be able to compute distance both for point and matrix
  UTM_point <- sf::st_transform(point, crs = 32748)
  UTM_sheet <- cadaster_sheet %>%
    sf::st_transform(crs = 32748)

  ## Evaluate distance between the point from the addres and every parcelle (polygon) in the downloaded dataframe
  distance_matrix <- sf::st_distance(UTM_point, UTM_sheet)

  ## Chososes the feuille closest to the point
  nearest_polygon_reference <- which.min(distance_matrix)

  ## Returns its row number
  return(nearest_polygon_reference)
}
