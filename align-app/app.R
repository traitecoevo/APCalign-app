library(shiny)
library(DT)
library(APCalign)
source("helper.R")

# Load APC resources once
resources <- load_taxonomic_resources(stable_or_current_data = "stable", version = "0.0.2.9000")

# UI part of the Shiny app
ui <- fluidPage(
  titlePanel("APCalign-app"),
  sidebarLayout(
    sidebarPanel(
      textInput("names_input", "Enter taxa names (separated by commas):", ""),
      
      fileInput("file_input", "Upload a .csv file of names"),
      
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
  
  observeEvent(input$submit_button, {
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
    data_set <- standardise_names(input_names, resources)
    
    # Store the data in the reactive value
    data(data_set)
  })
  
  # Render the sortable data table
  output$names_table <- renderDT({
    datatable(
      data(),
      options = list(ordering = TRUE)
    )
  })
  
  # Download the table as a CSV file
  output$download_table <- downloadHandler(
    filename = function() {
      paste("names_table", ".csv", sep = "")
    },
    content = function(file) {
      write.csv(data(), file)
    }
  )
}

# Run the Shiny app
shinyApp(ui, server)
