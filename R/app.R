#'Run APCalign-app
#'
#' @return Shiny app to open in your browser
#' @param ... arguments passed to shiny::shinyApp
#' @import shiny
#' @export

align_app <- function(...){

# Load APC resources once
resources <- APCalign::load_taxonomic_resources(stable_or_current_data = "stable", version = "0.0.2.9000")

# UI part of the Shiny app
ui <- apcalign_ui()

# Server part of the Shiny app
server <- apcalign_server(resources = resources)

# Run the Shiny app
shinyApp(ui, server, ...)

}

