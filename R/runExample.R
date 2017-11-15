#' Launcher for Shiny
#'
#' @return Shiny app
#' @import shiny
#' @export
#'
#' @examples \dontrun{
#' runExample()
#' }
runExample <- function() {
  appDir <- system.file("shiny-examples", "shinyartemis", package = "artemis")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `mypackage`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
