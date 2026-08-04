#' UI part of the Shiny app
apcalign_ui <- function(){

  # Serve the packaged static assets (AusTraits stylesheet, hex logo) under www/
  shiny::addResourcePath(
    "www",
    system.file("www", package = "APCalignApp")
  )

  bslib::page_sidebar(

    # AusTraits site stylesheet (matches austraits.org and the data portal)
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "www/apcalign-app.css")
    ),

    shinybusy::add_busy_spinner(
      spin = "fading-circle",
      position = "top-right",
      color = "#2f7d55",
      height = "60px",
      width = "60px"
    ),

    # Set the overall theme of the app to match austraits.org (simplex base
    # with the AusTraits brand palette).
    theme = bslib::bs_theme(
      preset = "simplex",
      primary = "#235c43",
      secondary = "#64726b",
      success = "#2f7d55",
      info = "#2a7f9e",
      warning = "#d9a441",
      "body-bg" = "#fdfdfc",
      "body-color" = "#2b332f",
      "link-color" = "#235c43",
      "link-hover-color" = "#2a7f9e",
      "border-radius" = "8px"
    ),

    # Title with the APCalign hex logo. The `bslib-page-title` class matches
    # the brand-bar rules in apcalign-app.css (bslib does not add it for
    # custom title nodes).
    title = tags$span(
      class = "bslib-page-title navbar-brand",
      tags$img(src = "www/APCalign_hex.png", alt = "APCalign", height = "30"),
      "APCalign-app"
    ),

    sidebar = bslib::sidebar(
      width = 340,

      p("This app uses the Australian Plant Census to align and update plant taxon name strings"),
      HTML("<p>For more information, check out the <a href='https://traitecoevo.github.io/APCalign/' target='_blank'>APCalign R package website</a></p>"),

      h5("Taxon names"),

      radioButtons(
        "inputType",
        "How would you like to supply taxon names?",
        choices = list(
          "Enter manually (separated by commas)" = "paste",
          "Upload a .csv" = "upload"
        ),
        selected = "paste"
      ),

      conditionalPanel(
        condition = "input.inputType == 'paste'",

        textInput("names_input", "",
                  value = "Banksia serrata, Acacia longifolia, Not a species"),

        p("Click submit again if you have changed the taxon name input")
      ),

      conditionalPanel(
        condition = "input.inputType == 'upload'",

        fileInput("file_input", "", multiple = FALSE, accept = c(".csv"), buttonLabel = "Select file"),

        varSelectInput("sp_col", "Choose column containing taxon names", NULL),

        checkboxInput(
          "ident",
          "Include identifier?",
          value = FALSE
        ),

        conditionalPanel(
          condition = "input.ident ==1",

          varSelectInput("col", "Choose column containing additional identifier", NULL)
        )
      ),

      h5("Taxonomic splits"),
      radioButtons("taxonomic_splits",
                   NULL,
                   choices = list("Most likely species" = "most_likely_species",
                                  "Collapse to higher taxon" = "collapse_to_higher_taxon",
                                  "Display all" = "return_all"
                   ),
                   selected = "most_likely_species"),

      h5("Table display"),
      checkboxInput("full", "Full output", value = FALSE),

      actionButton("submit", "Submit", class = "btn-primary"),

      downloadButton("download_table", "Download Table", class = "btn-outline-primary")
    ),

    bslib::navset_bar(
      id = "main_tabs",

      bslib::nav_panel(
        title = "Output",
        # Wrapped in a card() so this tab gets its own internal scrollbar
        # (matching the AusTraits Data Portal's mod_data_table.R) instead of
        # growing/overflowing the page — see get_started.R for the full
        # explanation.
        bslib::card(
          bslib::card_body(
            DT::DTOutput("names_table")
          )
        )
      ),
      get_started(),
      faqs(),

      # Note: the footer belongs on navset_bar, not page_sidebar —
      # page_sidebar() has no `footer` argument, so passing one there is
      # silently swallowed as an HTML attribute and never renders.
      # Every nav_panel's content above is wrapped in a card(), which bslib
      # gives its own internal scrollbar (overflow: auto) once its content
      # is taller than the space available between the tab bar and this
      # footer. That's what keeps the footer always on screen — the page
      # itself never needs to scroll, so there's no position: fixed hack
      # needed here (this matches how the AusTraits Data Portal does it).
      footer = tags$footer(
        "Powered by ",
        tags$a(href = "https://www.unsw.edu.au/science", target = "_blank",
               "UNSW Faculty of Science"),
        align = "right", style = "padding: 30px",

        div("Created by Elizabeth Wenk, Daniel Falster, Will Cornwell and Fonti Kar",
            target)
      )
    )
  )
}