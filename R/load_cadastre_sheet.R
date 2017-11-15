#' Loads and open the cadaster sheet corresponding to the city code
#'
#' @param url character vecor
#' @param city_code numerical vector
#'
#' @import sf R.utils
#' @return dataframe
#' @export
#'
#' @examples \dontrun{
#' load_cadaster_sheet("https://cadastre.data.gouv.fr/data/etalab-cadastre/latest/communes/75/75117/cadastre-75117-batiments.json.gz",75117)
#' }
#'
#'
load_cadastre_sheet <- function(url,city_code){

  ## Turns the citycode into string to be used in paste
  toString(city_code)

  ## Type of datbase data needed
  type <- c("parcelles","feuilles")

  ## Vector containing the names we are giving to the files we are downloading from the databse
  saved_names <- paste("Cadastre.sheet",city_code,type,"json.gz",sep = ".")


  ## Downloads the json.gz files from the database and saves it under the name specified above
  download.file(url[1],saved_names[1])
  download.file(url[2],saved_names[2])

  ## Decompresses and imports the data with geographical package sf
  cadastre_sheet_parcelles <- sf::st_read(R.utils::gunzip(saved_names[1]))
  cadastre_sheet_feuilles <- sf::st_read(R.utils::gunzip(saved_names[2]))


  ## Deletes the files that were downloaded once the dataframes are imported
 ## file.remove(substring(saved_names[1],1,nchar(saved_names[1])-3))
## file.remove(substring(saved_names[2],1,nchar(saved_names[2])-3))

  ## Stores the files into a list
  cadastre_sheets <- list(cadastre_sheet_parcelles,cadastre_sheet_feuilles)


  ## Names the elements of the list by their type
  names(cadastre_sheets) <- type

  # Returns the list
  return(cadastre_sheets)
}


