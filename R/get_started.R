get_started <- function(){
  bslib::nav_panel("Get Started",

           # Wrapping the prose in a card() (as the AusTraits Data Portal
           # does for all of its nav_panel content) makes it a proper bslib
           # fill item: bslib gives cards their own internal scrollbar
           # (overflow: auto) when their content is taller than the space
           # available, instead of letting it overflow past the footer. This
           # is what lets the footer stay always visible without needing any
           # position: fixed hacks.
           #
           # `apcalign-prose` (max-width, for readable line length) is on an
           # inner div rather than the card/nav_panel itself — putting it on
           # the outer tab caps the *card* down to that width too, leaving it
           # looking like a small floating box in a lot of empty space. Here
           # the card spans the full tab (like the Data Portal's table does),
           # and only the text inside is width-capped.
           bslib::card(
           bslib::card_body(
           div(class = "apcalign-prose",
           h3("APCalign-app"),
           
           p(strong("APCalign-app "), 'is a Shiny interface to the R package ', tags$a("APCalign.", href = "https://traitecoevo.github.io/APCalign", target="_blank")," This app aligns and updates Australian plant taxon name strings. 
           using taxonomic information from the ", tags$a("Australian Plant Census (APC)", href = "https://www.anbg.gov.au/cpbr/program/hc/hc-APC.html", target="_blank")," and ", tags$a("Australian Plant Name Index (APNI).", href = "https://www.anbg.gov.au/apni/")), 
           
           h4("Supplying your taxon names"),
           p("Taxon names can be typed  directly into the name input box, making sure the names are seperated
             by commas. This method is suited to alignments and updates for a small number of taxa"), 
           
           p("For larger alignments and updates, we recommend uploading a .csv and selecting the column which contains your taxon names"),
           
           
           h4("Supplying additional identifiers"),
           
           p('In cases where there are multiple records for a genus or family alignment e.g. Eucalyptus sp.,
             you can nominate an additional identifier from another column in your data that is linked to your taxon name e.g. collection site or collector name. 
             This information is retained under `suggested_name` and clarifies that the records are not identical taxon concepts. The identifier feature is only available via the "Upload" method'),
           
           h4("Handling of taxonomic splits"),
           p("Taxonomic splits refers to instances where a single taxon concept is subsequently split into multiple taxon concepts. 
             For such taxa, when the aligned_name is the 'old' taxon concept name, it is impossible to know which of the currently accepted taxon concepts the name represents."),
           
           p("APCalign-app offers three alternative approaches to handle these instances:"),
           
           p(tags$ul(
             tags$li(HTML('<b>Most likely species</b> which gives you the <samp>accepted_name</samp> of the original <samp>taxon_concept</samp>; alternative names are documented in <samp>suggested_name</samp>')),
             tags$li(HTML('<b>Collapse to higher taxon</b> which declares that for split names, there is no way to be certain about which <samp>accepted_name</samp> is appropriate and therefore updates the <samp>aligned_name</samp> to the genus level; no <samp>accepted_name</samp> is returned, <samp>suggested_name</samp> documents the possible species-level names')),
             tags$li(HTML('<b>Display all</b> which gives you all the currently accepted names that were split from the original <samp>taxon_concept</samp>'))
           )
           )
           )
           )
           )
  )
}