faqs <- function(){
  tabPanel("FAQS",
           h3("Frequently Asked Questions"),
           
           h4("1. What is the Australian Plant Census (APC) and Australian Plant Name Index (APNI)?"), 
           
           p("The ", tags$a("Australian Plant Census (APC)", href = "https://www.anbg.gov.au/cpbr/program/hc/hc-APC.html", target="_blank")," is national database of accepted taxonomic names for Australian vascular plants.
             The APC includes information on synonyms, and misapplications of them, as well as established status (native/introduced) and distribution across states and territories."),
           
           p("APCalign-app will first use the APC to align your taxonomic names to ones that exist in the database."),
           
           p(tags$a("The Australian Plant Index (APNI)", href= "https://www.anbg.gov.au/apni/", target="_blank")," is a database containing names of Australian plants and their use in scientific literature. 
             It is primarily used by the botanical community for standardising synonyms. Importantly, APNI does not provide recommendation of taxonomy or nomenclature, this is where the APC comes in."), 
           
           p("This app only uses APNI when an alignment cannot be found in the APC"),
           
           h4("2. How does the app align my names to those in the APC/APNI?"),
           p("Generally, the app takes the following steps to align names: "),
           tags$ol(
             tags$li("Clean the inputted names"),
             tags$li("Find best alignment with APC/APNI to your input names using 50 matching algorithims with exact and fuzzy matching"),
             tags$li("Determine the taxon_rank to which the name can be resolved, based on its syntax."),
             tags$li("Determine the taxonomic_reference (APC/APNI) of each name-alignment")
           ),
           p("Learn more about our ", tags$a("matching algorithim", href = "https://traitecoevo.github.io/APCalign/articles/updating-taxon-names.html", target="_blank")),
           
           h4("3. What if the taxon is not listed in the APC?"),
           
           h4("4. Where can I find the metadata for the columns in the output data"),
           p("The metadata for the output columns are summarised in the ", tags$a("R package documention", href = "https://traitecoevo.github.io/APCalign/reference/create_taxonomic_update_lookup.html", target="_blank")),
           
           h4("5. Where can I find further information about this app?"),
           p("APCalign-app is a Shiny interface to the R package APCalign. Learn more about other features at the ", tags$a("package website", href = "https://traitecoevo.github.io/APCalign/", target="_blank"))
           
  )
}