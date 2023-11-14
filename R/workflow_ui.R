align_workflow <- function(){
  conditionalPanel(
    condition = "input.workflowType == 'align'",
    
    h4("Align Taxa"),
    h5("Fuzzy Matching"),
    sliderInput("abs_dist", "Absolute Distance (The number of characters allowed to differ):",
                min = 0, max = 5,
                value = 3, step = 1),
    
    sliderInput("rel_dist", "Relative Distance (The proportion of characters allowed to differ):",
                min = 0, max = 0.5,
                value = 0.2, step = 0.05),
    
    # Coarse level matching 
    checkboxInput("imprecise", "Imprecise Fuzzy Matching", value = FALSE),
    
    # Taxonomic Resources
    h5("Taxonomic Resources"),
    checkboxInput("apni", "APNI", value = TRUE),
    
    h5("Table display"),
    checkboxInput("full", "Full output", value = FALSE)
  )
}

update_workflow <- function(){
  conditionalPanel(
    condition = "input.workflowType == 'update'",
    
    h4("Update taxonomy"),
    # Output handling
    radioButtons("taxonomic_splits", 
                 h5("Taxonomic splits"), 
                 choices = list("Most likely species" = "most_likely_species",
                                "Collapse to higher taxon" = "collapse_to_higher_taxon", 
                                "Display all" = "return_all" 
                 ),
                 selected = "most_likely_species"),
    
  )
}

both_workflow <- function(){
  conditionalPanel(
    condition = "input.workflowType == 'both'",
    
    # Coarse level matching 
    h5("Match method"),
    checkboxInput("imprecise", "Imprecise Fuzzy Matching", value = FALSE),
    
    # Taxonomic Resources
    h5("Taxonomic Resources"),
    checkboxInput("apni", "APNI", value = TRUE),
    
    
    # Output handling
    radioButtons("taxonomic_splits", 
                 h5("Taxonomic splits"), 
                 choices = list("Most likely species" = "most_likely_species",
                                "Collapse to higher taxon" = "collapse_to_higher_taxon", 
                                "Display all" = "return_all" 
                 ),
                 selected = "most_likely_species"),
    
  
    h5("Table display"),
    checkboxInput("full", "Full output", value = FALSE),

  )
}