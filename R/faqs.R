faqs <- function(){
  tabPanel("FAQs",
           h3("Frequently Asked Questions"),
           
           h4("1. What is the Australian Plant Census (APC) and the Australian Plant Name Index (APNI)?"),
           # p(""),
           
           h4("2. What does this app do?"),
           # p(""),
           
           h4("3. How do I format the .csv file to upload to the app?"),
           p(""),
           
           h4("5. Where can I find further information about this app?"),
           # p("For some locations, KML files already exist and can be found by searching the internet for '[place name] + KML'. If you cannot find a KML file for your location, you can manually create one in software such as ", tags$a(href = "https://earth.google.com/", "Google Earth "),  "by drawing a polygon, and then exporting it as a KML."),
           
           h4("6. How does the app align my names to those in the APC/APNI?"),
           p("Generally, the app takes the following steps to align names: "),
           tags$ol(
             tags$li(""),
             tags$li(""),
             tags$li(""),
             tags$li("")
           ),
           p("More information can be found on these ", tags$a("here", href = "https://support.ala.org.au/support/solutions/articles/6000240256-getting-started-with-the-data-quality-filters")),
           
           
           h4("7. Where can I find the metadata for the columns in the data table?"),
           # p("Species with sensitive locations are not included in our app. Any species for which records have their locality data obscured or generalised (whether by the original data provider, or by the ALA itself) are excluded from the app."),
  )
}