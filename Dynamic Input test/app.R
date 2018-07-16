library(shiny)
ui<-shinyUI(pageWithSidebar (
  headerPanel( "Portfolio Returns"),
  sidebarPanel(
    numericInput("assets", label = "Enter Number of variants in Experiment", value="3")
  ),
  mainPanel(
    uiOutput("variants"),
    uiOutput("lastVariant"))
))


server<-shinyServer( function(input, output, session) {
  output$variants <- renderUI({
    numAssets <- as.integer(input$assets)  
    lapply(1:(numAssets-1), function(i) {
      list(tags$p(tags$u(h4(paste0("Variant ", i, ":")))),
           textInput(paste0("variant", i), label = "Variant Name", value = paste0("Variant ", i, " name..."))
           , numericInput(paste0("weight", i)
                          , label = "Proportion allocated (0 - 100)", value=0)
      )
    }) #end of lapply
  }) # end of renderUI
  
  output$lastVariant <- renderUI({
    numAssets <- as.integer(input$assets)
    for (j in 1:(numAssets-1)){
      if(j==1){x=100}
      x = x - input[[paste0("weight",j)]]
    }
    tagList(
      tags$p(tags$u(h4(paste0("Variant ", numAssets, ":")))),
      textInput(paste0("variantFinal"), label = "Variant Name", value = paste0("Variant ", numAssets, " name...")), 
      tags$p(tags$b("Proportion allocated (0 - 100)")),
      helpText(paste0(x))
    ) #end of tagList
  }) #end of renderUI
}) #end of shinyServer

shinyApp(ui=ui, server=server)