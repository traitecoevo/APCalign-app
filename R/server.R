#' UI part of the Shiny app
#' @param resources taxonomic resources from APCalign::load_taxonomic_resources
apcalign_server <- function(resources){

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

      updateVarSelectInput(session, "sp_col", data = input_data())
    }
    )

    # Watch which column user selects as the taxa column
    observeEvent(input$sp_col, {
      taxa <-as.character(input$sp_col)
      input_names(input_data() |> dplyr::pull(taxa))
    })

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

    output$instructions_or_table <- renderUI({
      if (input$submit == 0) {
        tags$div(
          style = "background: var(--at-mint); border-left: 4px solid var(--at-green); padding: 20px; margin: 20px 0; border-radius: 4px;",
          tags$div(
            style = "display: flex; align-items: center; gap: 10px; margin-bottom: 12px;",
            icon("info-circle", style = "color: var(--at-green); font-size: 24px;"),
            tags$h4(
              style = "color: var(--at-green-dark); margin: 0;",
              "Ready to align plant names?"
            )
          ),
          tags$p(
            style = "margin: 0 0 10px 0; font-size: 15px; color: var(--at-ink);",
            "To align your plant names, please:"
          ),
          tags$ol(
            style = "margin: 0; padding-left: 20px; color: var(--at-ink);",
            tags$li("Enter taxon names in the sidebar (or upload a .csv)"),
            tags$li("Choose your taxonomic-split and table-display options"),
            tags$li("Click 'Submit'")
          )
        )
      } else {
        DT::dataTableOutput("names_table")
      }
    })

    # Render the sortable data table
    output$names_table <- DT::renderDataTable(
      update_lookup(),
      # scrollX keeps the wide table inside the content region rather than
      # clipping it; `truncated` (styled in apcalign-app.css) stops long
      # free-text columns such as aligned_reason from stretching every row.
      options = list(
        ordering = TRUE,
        scrollX = TRUE,
        columnDefs = list(list(targets = "_all", className = "truncated"))
      ),
      # Native tooltip so the truncated text is still readable on hover.
      callback = DT::JS(
        "table.on('draw.dt', function() {
           table.cells().every(function() {
             var node = this.node();
             node.title = node.textContent;
           });
         }).draw(false);"
      )
    )


    # Download the table as a CSV file
    output$download_table <- downloadHandler(
      filename = paste0("APCalign_taxa_",Sys.Date(), ".csv"),
      content = function(file) {
        utils::write.csv(update_lookup(), file, row.names = FALSE)
      }
    )

  }
}