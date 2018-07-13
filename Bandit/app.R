library(shiny)
library(shinydashboard)

ui<-fluidPage(
  #  input  : stuff you allow the users to interact with:actionButton, numericInput
)

server<-function(input, output){
  # fetch the input from ui and respond with some output: renderPlot, renderPrint...etc
}
# call shinyApp and launch it shinyApp(ui=ui, server=server)

library(shiny) # shiny library
# begining of ui component
ui<-shinyUI(fluidPage(
  column(12,"Calculation Panel",   #12 is the size of the sidebar
         
         sidebarLayout(
           sidebarPanel(
             h3('Input your numbers to find the suggested proportion'),
             numericInput("SalesOriginal", "Sales Original version", value=0, min = 1, max=10000, step=10),
             numericInput("NoTrialOriginal", "Number of Trial Original version", value=0, min = 1, max=100000, step=10),
             numericInput("SalesVar1", "Sales Variation #1", value=0, min = 1,max=10000),
             numericInput("NoTrialVar1", "Number of Trial Variation #1", value=0, min = 1, max=100000, step=10),
             numericInput("SalesVar2", "Sales Variation #2", value=0, min = 1,max=10000),
             numericInput("NoTrialVar2", "Number of Trial Variation #2", value=0, min = 1, max=100000, step=10),
             numericInput("SalesVar3", "Sales Variation #3", value=0, min = 1,max=10000),
             numericInput("NoTrialVar3", "Number of Trial Variation #3", value=0, min = 1, max=100000, step=10),
             actionButton('bandit', label = 'Bandit result',icon("ok",lib="glyphicon"), 
                          style="color: #fff; background-color: #339933; border-color: #2e6da4")
             
         ),
         # this is how you create many "tabs" in the finishing 
         mainPanel(
           tabsetPanel(tabPanel("Conversion rate", verbatimTextOutput("conversion")),
                       tabPanel("Statistical significance", verbatimTextOutput('significance')),
                       tabPanel("Suggested proportion", verbatimTextOutput('proportion'))
           )
         )  
)))
)
library(bandit)
server<- function(input,output, session){
  set.seed(1234)
  observe({
    require(bandit)
    SalesOriginal<-as.integer(input$SalesOriginal)
    SalesVar1<-as.integer(input$SalesVar1)
    SalesVar2<-as.integer(input$SalesVar2)
    SalesVar3<-as.integer(input$SalesVar3)
    NoTrialOriginal<-as.integer(input$NoTrialOriginal)
    NoTrialVar1<-as.integer(input$NoTrialVar1)
    NoTrialVar2<-as.integer(input$NoTrialVar2)
    NoTrialVar3<-as.integer(input$NoTrialVar3)
    Sales<-c(SalesOriginal, SalesVar1, SalesVar2, SalesVar3)
    NoTrials<-c(NoTrialOriginal,NoTrialVar1,NoTrialVar2,NoTrialVar3)
    Conversion<-sprintf("%.1f %%", 100*Sales/NoTrials)
    Conversionoutput<-data.frame(Sales,NoTrials,Conversion)

    observeEvent(input$bandit, {
      require(bandit)
      bestarm<-round(best_binomial_bandit_sim(Sales,NoTrials, ndraws=3000),2)
      Suggestedproportion<-bestarm
      a<-min(Suggestedproportion)
      b<-max(Suggestedproportion)
      c<-ifelse(a<0.1,0.1,a)
      d<-ifelse(a<0.1,b-(0.1-a),b)
      minBanditposition<-which(Suggestedproportion == min(Suggestedproportion))
      maxBanditposition<-which(Suggestedproportion == max(Suggestedproportion))
      Suggestedproportion[minBanditposition]<-c
      Suggestedproportion[maxBanditposition]<-d
      
      #populate conversion rate
      output$conversion<-renderPrint({
        Conversionoutput})
      #populate bandit significance
      output$significance<-renderPrint({bestarm})
      #populate suggested proportion
      output$proportion<-renderPrint({Suggestedproportion})
      })
    
  })
}
shinyApp(ui=ui, server=server)
# free server shinyapps.io