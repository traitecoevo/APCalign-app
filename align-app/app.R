library(shiny)
library(shinythemes)
library(shinybusy)
library(APCalign)
library(DT)

# Load APC resources once
resources <- load_taxonomic_resources(stable_or_current_data = "stable", version = "0.0.2.9000")

# UI part of the Shiny app
ui <- fluidPage(
  theme = shinytheme("cerulean"),
  
  add_busy_spinner("hollow-dots", color = "#527DA9", position = "bottom-left"),
  
  titlePanel("APCalign-app"),
  
  sidebarLayout(
    sidebarPanel(
      p("This app uses the Australian Plant Cenus to standardise plant taxon names."),
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
      
      actionButton("submit_button", "Submit")
    ),
    
    
    mainPanel(
      DTOutput("names_table"),
      downloadButton("download_table", "Download Table")
    )
  )
)

# Server part of the Shiny app
server <- function(input, output) {
  data <- reactiveVal(NULL)
  
  observeEvent(input$submit_button,{
  # Check if a file is uploaded
  if (!is.null(input$file_input)) {
    # Read the uploaded file as a data frame
    data_set <- read.csv(input$file_input$datapath)
    input_names <- data_set[,1]
  } else {
    # If no file is uploaded, use the input from the text box
    # Convert the input string of names to a vector
    input_names <- strsplit(input$names_input, ",")[[1]]
  }
  
  # Remove leading and trailing white spaces (if any)
  input_names <- trimws(input_names)
  
  # Create a taxonomic lookup
  # Store the data in the reactive value
  dataInput <- reactive({
    create_taxonomic_update_lookup(taxa = input_names, 
                                   resources = resources, 
                                   full = input$full,
                                   taxonomic_splits = input$taxonomic_splits)
  })
  
  # Store the data in the reactive value
  data(dataInput())
  
  # Render the sortable data table
  output$names_table <- DT::renderDataTable(
    dataInput(),
    options = list(ordering = TRUE)
  )


  
  })
  
  # Download the table as a CSV file
  output$download_table <- downloadHandler(
    filename = paste0("APCalign_taxa_",Sys.Date(), ".csv"),
    content = function(file) {
      write.csv(data(), file, row.names = FALSE)
    }
  )
}

# Run the Shiny app
shinyApp(ui, server)
