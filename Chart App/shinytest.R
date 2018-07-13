library(shiny)
library(ggplot2)

ggplot(data=diamonds,aes(price))+geom_histogram(binwidth = 1000)

ui<-fluidPage(
  titlePanel("Example Shiny App: Dist of Diamond stock by Price Bands"),
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "bands",
        label = "Select No. of Price Bands",
        min=1,
        max=30,
        value=15
      )
    ),
    mainPanel(plotOutput(outputId = "plot"))
  )
)

server<-function(input,output) {}
shinyApp(ui=ui,server=server)
