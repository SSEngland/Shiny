library(shiny)

ui<-fluidPage(
  #  input  : stuff you allow the users to interact with:actionButton, numericInput
)

server<-function(input, output){
  # fetch the input from ui and respond with some output: renderPlot, renderPrint...etc
}
# call shinyApp and launch it shinyApp(ui=ui, server=server)
#Step 3 : try-and-error to build the app, insert your first model 

library(shiny) # shiny library
# begining of ui component
ui<-shinyUI(fluidPage(
  
  fluidRow(
    column(12,
           "Model Selection Panel",
           
           sidebarLayout(
             sidebarPanel(
               h3('choose the model'),
               # the actioButton called rpart which is the name of the variable you need to use in the server component
               # icon website http://getbootstrap.com/components/#glyphicons
               actionButton('rpart', label = 'Decision Tree',icon("leaf",lib="glyphicon"), 
                            style="color: #fff; background-color: #339933; border-color: #2e6da4"),
               actionButton('rf', label = 'Random Forest', icon("tree-conifer", lib="glyphicon"),
                            style="color: #fff; background-color: #33cc33; border-color: #2e6da4"),
               actionButton('nn', label = 'Neural Network', icon("random", lib="glyphicon"),
                            style="color: #fff; background-color: #0066ff; border-color: #2e6da4"),
               actionButton('svm', label = 'SupportVectorMachine', icon("cloud", lib="glyphicon"),
                            style="color: #fff; background-color: #ffa500; border-color: #2e6da4"),
               
               
               # the training sample split you allow the user to control on your model
               numericInput("ratio", "training sample in %", value=50/100, min = 50/100, max = 90/100, step=0.1)
             ),
             # this is how you create many "tabs" in the finishing 
             mainPanel(
              
               tabsetPanel( tabPanel("first 5 rows of the dataframe", verbatimTextOutput("head")), 
                            tabPanel("model result", tableOutput("result")), 
                            tabPanel("model plot", plotOutput('plot')),
                            tabPanel("model summary", verbatimTextOutput('summary'))
               )
             )
           )))
))

# remember to inmport all the libraries you need for your machine learning models and plots
library(rpart)				        # Popular decision tree algorithm
library(rpart.plot)				# Enhanced tree plots
library(RColorBrewer)				# Color selection for fancy tree plot
library(party)					# Alternative decision tree algorithm
library(partykit)				# Convert rpart object to BinaryTree
library(tree) # good to have but not necessary
library(neuralnet) # you will need this to do neural network
library(xtable) # good to havelibrary(e1071) # your suppose vector machine modellibrary(randomForest) # your randomforest model

data(iris) # you call the famous machine learning data iris like this
#attach(iris) i usually do this to cache my dataset


# begining of your server component
server<- function(input,output, session){
  set.seed(1234)
  observe({
    r<-as.numeric(input$ratio)
    ind <- sample(2, nrow(iris), replace = TRUE, prob=c(r,1-r))
    trainset = iris[ind==1,]
    testset = iris[ind==2,]
    
    # decision tree action button
    observeEvent(input$rpart, {
      ml_rpart<-rpart(trainset$Species~.,method='class',data=trainset,control=rpart.control(minsplit=10,cp=0))
      model_pred<-predict(ml_rpart, testset, type="class")
      output$result<-renderTable({
        table(model_pred, testset$Species)    })
      output$summary <- renderPrint(summary(ml_rpart))
      output$plot <- renderPlot({
        prune.fit<-prune(ml_rpart, cp=0.001)
        # prune the treefirst then plot the pruned tree 
        plot(prune.fit, uniform=TRUE, 
             main="Pruned Classification Tree for iris data")
        text(prune.fit, use.n=TRUE, all=TRUE, cex=.8)
      })
    })
    #random forest action button
    observeEvent(input$rf, {
      require(randomForest)
      rf.fit<-with(trainset, randomForest(Species~., data=trainset, importance=TRUE, ntree=400))
      rf.pred<- predict(rf.fit, testset)
      output$result<-renderTable({
        
        table(rf.pred, testset$Species)   })
      output$summary <- renderPrint(summary(rf.fit))
      output$plot <- renderPlot({
        varImpPlot(rf.fit, main="Random Forest model fit, importance of the parameters")
        importance(rf.fit)
      })
    })
    # neural network action button called nn
    observeEvent(input$nn, {
      require(neuralnet)
      trainset$setosa = trainset$Species == "setosa"
      trainset$virginica = trainset$Species == "virginica"
      trainset$versicolor = trainset$Species == "versicolor"
      # train the neuralnet
      nn <-neuralnet(versicolor + virginica + setosa~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, trainset, hidden=c(3))
      comp <- compute(nn, testset[-5]) # this is how you make prediction with testset
      pred.weights <- comp$net.result
      idx <- apply(pred.weights, 1, which.max)
      prednn <- c('setosa', 'versicolor', 'virginica')[idx] # the resulting prediction
      
      output$result<-renderTable({
        table(prednn, testset$Species)  })
      output$summary <- renderPrint(summary(nn$net.result))
      output$plot <- renderPlot({
        plot(nn)
      })
    })
    # svm action button
    observeEvent(input$svm, {
      require(e1071)
      attach(iris)
      x <- subset(iris, select=-Species)
      y <- Species
      svm_model <- svm(Species ~ ., data=iris)
      svm_model1 <- svm(x,y)
      pred <- predict(svm_model1,x)
      output$result<-renderTable({
        table(pred,y) })
      output$summary <- renderPrint(summary(svm_model1))
      output$plot <- renderPlot({
        plot(svm_model, iris, Petal.Width ~ Petal.Length,
             slice = list(Sepal.Width = 3, Sepal.Length = 4))
      })
    })
    
    #print dataframe's sample head
    output$head <- renderPrint({
      head(testset, 5)
    })
  })
}

shinyApp(ui=ui, server=server)
# free server shinyapps.io