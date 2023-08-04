library(shiny)
library(DT)

# UI part of the Shiny app
ui <- fluidPage(
  titlePanel("Names Table"),
  sidebarLayout(
    sidebarPanel(
      textInput("names_input", "Enter names (separated by commas):", ""),
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
    # Convert the input string of names to a vector
    input_names <- strsplit(input$names_input, ",")[[1]]
    # Remove leading and trailing white spaces (if any)
    input_names <- trimws(input_names)
    
    # Create a data frame with the names
    data_set <- data.frame(Name = input_names)
    
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
