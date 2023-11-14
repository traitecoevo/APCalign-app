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
      
      if (input$workflowType == "both"){
        # Create a taxonomic lookup
        # Store the data in the reactive value
        dataInput <- reactive({
          APCalign::create_taxonomic_update_lookup(taxa = input_names, 
                                                   resources = resources, 
                                                   taxonomic_splits = input$taxonomic_splits,
                                                   imprecise_fuzzy_matches = input$imprecise,
                                                   APNI_matches = input$apni
          )
        })
      }
      
      if (input$workflowType == "align"){
        # Align taxa only
        dataInput <- reactive({
          APCalign::align_taxa(original = input_names, 
                               resources = resources, 
                               full = input$full,
                               fuzzy_abs_dist = input$abs_dist,
                               fuzzy_rel_dist = input$rel_dist,
                               imprecise_fuzzy_matches = input$imprecise,
                               APNI_matches = input$apni
          )
        })
      }
      
      if (input$workflowType == "update"){
        # Align taxa only
        dataInput <- reactive({
          tmp <- APCalign::align_taxa(original = input_names)
          
          tmp |> 
          APCalign::update_taxonomy(
                                    resources = resources, 
                                    taxonomic_splits = input$taxonomic_splits
          )
        })
      }
      
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
