#the file has to be saved as app.R in order to work, don't ask why!
#library(shiny)
#ui<-basicPage()

#server<-function(input,output){}

#shinyApp(ui=ui,server=server)
#these 4 lines above are the basic structure of shinyapp
#library(shiny)

# ui<-pageWithSidebar(
#   titlePanel("Title"),
#   sidebarPanel ("Sidebarpanel"),
#   mainPanel ("Main Panel")
# )
# 
# 
# server<-function(input,output){}
# 
# shinyApp(ui=ui,server=server)
#these scripts below made the apps resizable
# library(shiny)
# 
# ui<-fluidPage(
#   titlePanel("Title"),
#   sidebarLayout(
#     sidebarPanel("Sidebar Panel"),
#     mainPanel ("Main Panel")
#   )
# )
# server<-function(input,output){}
# 
# shinyApp(ui=ui,server=server)
#this app below with slider
# library(shiny)
# 
# ui<-fluidPage(
#   titlePanel("Title"),
#   sidebarLayout(
#     sidebarPanel("Sidebar Panel",
#     sliderInput(
#       inputId = "bins",
#       label = "Slider Label",
#       min=1,
#       max=30,
#       value=15
#     )
#     ),
#     mainPanel ("Main Panel")
# )
# )
# server<-function(input,output){}
# 
# shinyApp(ui=ui,server=server)
#the app below creates dropdown list
# library(shiny)
# 
# ui<-fluidPage(
#   titlePanel("Title"),
#   sidebarLayout(
#     sidebarPanel("Sidebar Panel",
#                  selectInput(
#                    inputId = "list",
#                    label = "List Label",
#                    choices = c("fair","good","very good"),
#                    selected = "good"
#                  )
#     ),
#     mainPanel ("Main Panel")
#   )
# )
# server<-function(input,output){}
# 
# shinyApp(ui=ui,server=server)
#the code below gives framework for plots
# library(shiny)
# 
# ui<-fluidPage(
#   titlePanel("Title"),
#   sidebarLayout(
#     sidebarPanel("Sidebar Panel"),
#     mainPanel ("Main Panel",
#     tabsetPanel(
#       tabPanel(title="1st Plot",plotOutput(outputId = "plot1")),
#       tabPanel(title = "2nd Plot",plotOutput(outputId = "plot2"))
#     )
#   )
# )
# )
# 
# server<-function(input,output){}
# 
# shinyApp(ui=ui,server=server)

#this script below will plot 2 charts as different tabs
# library(shiny)
# 
# ui<-fluidPage(
#   titlePanel("Title"),
#   sidebarLayout(
#     sidebarPanel("Sidebar Panel"),
#     mainPanel ("Main Panel",
#                tabsetPanel(
#                  tabPanel(title="1st Plot",plotOutput(outputId = "plot1")),
#                  tabPanel(title = "2nd Plot",plotOutput(outputId = "plot2"))
#                )
#     )
#   )
# )
# #all the plots are included in the function
# server<-function(input,output){
#   output$plot1<-renderPlot(( #these two open brackets are necessary
#     ggplot(data=diamonds,aes(x=price))+geom_histogram()
#   ))
#   output$plot2<-renderPlot((
#     ggplot(data=diamonds,aes(x=carat))+geom_histogram()
#   ))
# }
# 
# shinyApp(ui=ui,server=server)

# #this will plot chart with side bar and dropdown list
# library(shiny)
# 
# ui<-fluidPage(
#   titlePanel("Title"),
#   sidebarLayout(
#     sidebarPanel("Sidebar Panel",
#     sliderInput(
#       inputId = 'bins',
#       label = 'Slider label',
#       min=1,
#       max=30,
#       value=15,
#       ticks=FALSE
#     ),
#     selectInput(
#       inputId = 'list',
#       label="list label",
#       choices=c("price","carat"),
#       selected = "price"
#     )),
#     mainPanel ("Main Panel",
#                tabsetPanel(
#                  tabPanel(title="1st Plot",plotOutput(outputId = "plot1")),
#                  tabPanel(title = "2nd Plot",plotOutput(outputId = "plot2")))
#                )
#     )
#   )
# 
# #all the plots are included in the function
# server<-function(input,output){
#   output$plot1<-renderPlot(( #these two open brackets are necessary
#     ggplot(data=diamonds,aes(x=price))+geom_histogram()
#   ))
#   output$plot2<-renderPlot((
#     ggplot(data=diamonds,aes(x=carat))+geom_histogram()
#   ))
# }
# 
# shinyApp(ui=ui,server=server)

#this script below added slider

# library(shiny)
# 
# ui<-fluidPage(
#   titlePanel("Title"),
#   sidebarLayout(
#     sidebarPanel("Sidebar Panel",
#                  sliderInput(
#                    inputId = 'bins',
#                    label = 'Slider label',
#                    min=1,
#                    max=30,
#                    value=15,
#                    ticks=FALSE
#                  ),
#                  selectInput(
#                    inputId = 'list',
#                    label="list label",
#                    choices=c("price","carat"),
#                    selected = "price"
#                  )),
#     mainPanel ("Main Panel",
#                tabsetPanel(
#                  tabPanel(title="1st Plot",plotOutput(outputId = "plot1")),
#                  tabPanel(title = "2nd Plot",plotOutput(outputId = "plot2")))
#     )
#   )
# )
# 
# #all the plots are included in the function
# server<-function(input,output){
#   output$plot1<-renderPlot(( #these two open brackets are necessary
#     ggplot(data=diamonds,aes(x=price))+geom_histogram()+stat_bin(bins=input$bins)
#   ))
#   output$plot2<-renderPlot((
#     ggplot(data=diamonds,aes(x=carat))+geom_histogram()+stat_bin(bins=input$bins)
#   ))
# }
# 
# shinyApp(ui=ui,server=server)
# this script plot charts with dropdown
# library(shiny)
# 
# ui<-fluidPage(
#   titlePanel("Title"),
#   sidebarLayout(
#     sidebarPanel("Sidebar Panel",
#                  sliderInput(
#                    inputId = 'bins',
#                    label = 'Slider label',
#                    min=1,
#                    max=30,
#                    value=15,
#                    ticks=FALSE
#                  ),
#                  selectInput(
#                    inputId = 'list',
#                    label="list label",
#                    choices=c("price","carat"),
#                    selected = "price"
#                  )),
#     mainPanel ("Main Panel",
#                tabsetPanel(
#                  tabPanel(title="1st Plot",plotOutput(outputId = "plot1"))
#                  )
#     )
#   )
# )
# 
# #all the plots are included in the function
# server<-function(input,output){
#   output$plot1<-renderPlot(( #these two open brackets are necessary
#     ggplot(data=diamonds,aes_string(x=input$list))+geom_histogram()+stat_bin(bins=input$bins)
#   ))#need to use aes_string this time to convert the variables from choices to strings
# 
# }
# 
# shinyApp(ui=ui,server=server)

#plot more choices
# library(shiny)
# library(dplyr)
# 
# ui<-fluidPage(
#   titlePanel("Title"),
#   sidebarLayout(
#     sidebarPanel("Sidebar Panel",
#                  sliderInput(
#                    inputId = 'bins',
#                    label = 'Slider label',
#                    min=1,
#                    max=30,
#                    value=15,
#                    ticks=FALSE
#                  ),
#                  selectInput(
#                    inputId = 'cut',
#                    label="list label",
#                    choices=c('Fair','Good','Very Good','Premium','Ideal','Any'),
#                    selected = 'Fair'
#                  )),
#     mainPanel ("Main Panel",
#                tabsetPanel(
#                  tabPanel(title="1st Plot",plotOutput(outputId = "plot1")),
#                  tabPanel(title="2nd Plot",plotOutput(outputId = "plot2"))
#                )
#     )
#   )
# )
# 
# #all the plots are included in the function
# server<-function(input,output){
#   output$plot1<-renderPlot(( #these two open brackets are necessary
#     ggplot(data=diamonds,aes(x=price))+geom_histogram()+stat_bin(bins=input$bins)
#   ))#need to use aes_string this time to convert the variables from choices to strings
#   output$plot2<-renderPlot(
#     {selectedcut<-
#       if(input$cut=='Any'){
#         c('Fair','Good','Very Good','Premium','Ideal')
#         }else{
#           input$cut}
#     #filter diamonds data by cut
#     filter(diamonds, cut%in% selectedcut) %>%
#       ggplot(aes(clarity,fill=color))+geom_bar()})
# }
# 
# shinyApp(ui=ui,server=server)
library(shiny)
library(dplyr)
library(ggplot2)
ui<-fluidPage(
  titlePanel("Title"),
  sidebarLayout(
    sidebarPanel("Sidebar Panel",
                 sliderInput(
                   inputId = 'bins',
                   label = 'Slider label',
                   min=1,
                   max=30,
                   value=15,
                   ticks=FALSE
                 ),
                 selectInput(
                   inputId = 'cut',
                   label="list label",
                   choices=c('Fair','Good','Very Good','Premium','Ideal','Any'),
                   selected = 'Fair'
                 )),
    mainPanel ("Main Panel",
               tabsetPanel(
                 tabPanel(title="1st Plot",plotOutput(outputId = "plot1")),
                 tabPanel(title="2nd Plot",plotOutput(outputId = "plot2"))
               ))))

#all the plots are included in the function
server<-function(input,output){
  output$plot1<-renderPlot(( #these two open brackets are necessary
    ggplot(data=diamonds,aes(x=price))+geom_histogram()+stat_bin(bins=input$bins)
  ))#need to use aes_string this time to convert the variables from choices to strings
  output$plot2<-renderPlot(
    {selectedcut<-
      if(input$cut=='Any'){
        c('Fair','Good','Very Good','Premium','Ideal')
      }else{
        input$cut}
    #filter diamonds data by cut
    filter(diamonds, cut%in% selectedcut) %>%
      ggplot(aes(clarity,fill=color))+geom_bar()})
}

shinyApp(ui=ui,server=server)

#change the above with getDataset <- reactive so that you can return more choices/charts
