#' UI part of the Shiny app
apcalign_ui <- function(){
  
  fluidPage(
    theme = shinythemes::shinytheme("cerulean"),
    
    shinybusy::add_busy_spinner("hollow-dots", color = "#527DA9", position = "bottom-left"),
    
    titlePanel("APCalign-app"),
    
    sidebarLayout(
      sidebarPanel(
        p("This app uses the Australian Plant Census to align and update plant taxon name strings"),
        HTML("<p>For more information, check out the <a href = 'traitecoevo.github.io/APCalign/'> APCalign R package website</a></p>"),
        
        br(),
        
        radioButtons(
          "inputType",
          "How would you like to supply taxon names?",
          choices = list(
            "Enter manually (separated by commas)" = "paste",
            "Upload a .csv" = "upload"
          ),
          selected = "paste",
          inline = TRUE
        ),
        
        conditionalPanel(
          condition = "input.inputType == 'paste'",
          
          textInput("names_input", "",
                    value = "Banksia serrata, Acacia longifolia, Not a species"),
          
          p("Click submit again if you have changed the taxon name input")
        ),
        
        conditionalPanel(
          condition = "input.inputType == 'upload'",
          
          fileInput("file_input", "", multiple = FALSE, accept = c(".csv"), buttonLabel = "Select file"),
          
        ),
        
        
        radioButtons("taxonomic_splits", 
                     h5("Taxonomic splits"), 
                     choices = list("Most likely species" = "most_likely_species",
                                    "Collapse to higher taxon" = "collapse_to_higher_taxon", 
                                    "Display all" = "return_all" 
                     ),
                     selected = "most_likely_species"),
        
        h5("Table display"),
        checkboxInput("full", "Full output", value = FALSE),
        
        actionButton("submit_button", "Submit"),
        
        downloadButton("download_table", "Download Table")
      ),
      mainPanel(
        tabsetPanel(
          tabPanel(
            "Output", 
            DT::DTOutput("names_table")
          ),
          get_started(), 
          faqs(),
        )
      )
    ),
    tags$footer(
      "Powered by ",
      tags$a(href = "https://www.unsw.edu.au/science", "UNSW Faculty of Science"), 
      align = "right", style = "padding: 30px",
      
      div("Created by Elizabeth Wenk, Daniel Falster, Will Cornwell and Fonti Kar",  
          target)
    )
  )
}
