#' Load resources once for test
resources <- APCalign::load_taxonomic_resources(stable_or_current_data = "stable", version = "0.0.2.9000")

#' Server for app
server <- function(input, output, session) {
  
  # Set empty reactive value for some parameters
  input_names <- reactiveVal()
  input_data <- reactiveVal()
  ident <- reactiveVal(NA_character_)
  
  # Detect whether names are inputted
  observeEvent(input$names_input, {
    
    pasted_names <- strsplit(input$names_input, ",")[[1]] |> trimws()
    input_names(pasted_names)
  } 
  )
  
  # Detect whether file is uploaded
  observeEvent(input$file_input, {
    data <- utils::read.csv(input$file_input$datapath)
    
    input_data(data)
    input_names(data[,1])
  }
  )
  
  # Watch if user wants to supply an identifier 
  observeEvent(input$file_input, {
    # Determine column names for identifier
    updateVarSelectInput(session, "col", data = input_data())
  }
  )
  
  # Update ident if user changes variable selection
  ident <- reactive({ 
    id_name <- as.character(input$col)
    input_data()[,id_name]})
  
  
  # Perform taxonomic update lookup
  update_lookup <- eventReactive(input$submit, {
    
    if(input$ident){
      
      # browser()
      APCalign::create_taxonomic_update_lookup(input_names(),
                                               identifier = ident(),
                                               resources = resources,
                                               taxonomic_splits = input$taxonomic_splits,
                                               full = input$full)
    } else {
      APCalign::create_taxonomic_update_lookup(taxa = input_names(),
                                               resources = resources,
                                               taxonomic_splits = input$taxonomic_splits,
                                               full = input$full)
    }
  })
  
  
  # Render the sortable data table
  output$names_table <- DT::renderDataTable(
    update_lookup(),
    options = list(ordering = TRUE)
  )
  
  
  # Download the table as a CSV file
  output$download_table <- downloadHandler(
    filename = paste0("APCalign_taxa_",Sys.Date(), ".csv"),
    content = function(file) {
      utils::write.csv(update_lookup(), file, row.names = FALSE)
    }
  )
  
}
