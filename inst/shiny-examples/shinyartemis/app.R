library(shiny)
library(artemis)
library(leaflet)

# Define UI for dataset viewer app ----
ui <- bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("map", width = "100%", height = "100%"),

  tags$head(
    # Include our custom CSS
    includeCSS("style.css")),

  absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,

                draggable = TRUE, top = "5", left = "100", right = "auto", bottom = "auto",

                width = "auto", height = "162",

                # App title ----
                h4("Projet Artemis"),
                tags$script(' $(document).on("keydown", function (e) {
                            Shiny.onInputChange("lastkeypresscode", e.keyCode);
                            });
                            '),

                # Input: Text for providing a caption ----
                # Note: Changes made to the adress are taken into account immediatly as typed
                textInput(inputId = "address",
                          label = "Veuillez entrer votre adresse:",
                          value = "Tour Eiffel"),
                actionButton("go","Go")
  )
  )

# Define server logic to view selected dataset ----
server <- function(input, output) {

  observeEvent(
    eventExpr = input$go,
    ignoreNULL = FALSE,
    handlerExpr = {
      output$map <- renderLeaflet({
        isolate({artemis::address_to_cadastre(input$address)})
      })
    }

  )

  observe({
    if(!is.null(input$lastkeypresscode)) {
      if(input$lastkeypresscode == 13){
        output$map <- renderLeaflet({
          isolate({artemis::address_to_cadastre(input$address)})
        })
        if (is.null(input$address) || input$address == "")
          return()
      }
    }
  }
  )
}


# Create Shiny app ----
shinyApp(ui, server)
