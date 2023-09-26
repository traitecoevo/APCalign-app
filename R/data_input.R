data_input <- function() {
  sidebarLayout(
  conditionalPanel(
    condition = "input.inputType == 'paste'",
    
    textInput("names_input", "",
              value = "Banksia serrata, Acacia longifolia, Not a species"),
    
    p("Click submit again if you have changed the taxon name input")
  ),
  
  conditionalPanel(
    condition = "input.inputType == 'upload'",
    
    fileInput("file_input", "", multiple = FALSE, accept = c(".csv"), buttonLabel = "Select file"),
    
  )
  )
} 