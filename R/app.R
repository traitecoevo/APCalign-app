#'Run APCalign-app
#'
#' @return Shiny app to open in your browser
#' @param ... arguments passed to shiny::shinyApp
#' @import shiny
#' @export

align_app <- function(...){

# Load APC resources once
resources <- APCalign::load_taxonomic_resources()

# UI part of the Shiny app
ui <- apcalign_ui()

# Server part of the Shiny app
server <- apcalign_server(resources = resources)

# Run the Shiny app
shinyApp(ui, server, ...)

}

