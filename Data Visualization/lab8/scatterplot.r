library(shiny)
library(ggplot2)
library(plotly)

data(iris)

ui <- fluidPage(
  
  titlePanel("Iris Data Visualization"),
  
  sidebarLayout(
    
    mainPanel(
      plotlyOutput(outputId = "scatterplot")
    ),
    
    sidebarPanel(
      selectInput(inputId = "xvar", label = "Select x-axis variable:", choices = names(iris)[1:4], selected = "Petal.Length"),
      selectInput(inputId = "yvar", label = "Select y-axis variable:", choices = names(iris)[1:4]),
      sliderInput(inputId = "pointsize", label = "Point size:", min = 1, max = 100, value = 5),
      
      selectInput(inputId = "pointshape", label = "Point shape setosa:", choices = c("Square", "Diamond", "Circle")),
      selectInput(inputId = "colorvar", label = "Color variable setosa:", choices = c("Species", "Sepal Width", "Petal Width")),
      
      selectInput(inputId = "pointshape1", label = "Point shape versicolor:", choices = c("Square", "Diamond", "Circle")),
      selectInput(inputId = "colorvar1", label = "Color variable versicolor:", choices = c("Species", "Sepal Width", "Petal Width")),
      
      selectInput(inputId = "pointshape2", label = "Point shape virginica:", choices = c("Square", "Diamond", "Circle")),
      selectInput(inputId = "colorvar2", label = "Color variable virginica:", choices = c("Species", "Sepal Width", "Petal Width"))
    )
  )
)

server <- function(input, output) {
  
  
  output$scatterplot <- renderPlotly({
    ggplot(iris, aes_string(x = input$xvar, y = input$yvar, color = input$colorvar, size = input$colorvar, shape = "Species")) +
      geom_point() +
      scale_color_manual(values = c("setosa" = "blue", "versicolor" = "green", "virginica" = "red")) +
      scale_size_manual(values = c("setosa" = input$pointsize, "versicolor" = input$pointsize, "virginica" = input$pointsize)) +
      scale_shape_manual(values = c("setosa" = 1, "versicolor" = 2, "virginica" = 3)) +
      labs(x = input$xvar, y = input$yvar, color = input$colorvar) 
    
  })
  
}

shinyApp(ui, server)
