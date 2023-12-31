#' UI part of the Shiny app
apcalign_server <- function(resources){
  
  server <- function(input, output, ...) {

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
        APCalign::create_taxonomic_update_lookup(taxa = input_names, 
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
}
