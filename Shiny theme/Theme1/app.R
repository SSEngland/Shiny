shinyApp(
  ui = navbarPage("Sindy test",
                  theme = shinythemes::shinytheme("united"),  # <--- Specify theme here
                  tabPanel("Plot", "Plot tab contents..."),
                  tabPanel("Summary", "Summary tab contents..."),
                  navbarMenu("More",
                             tabPanel("Analysis", "Detailed analysis tab contents..."),
                             tabPanel("Table", "Table tab contents...")
                  )
  ),
  server = function(input, output) { }
)