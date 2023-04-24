library(ggplot2)
library(shiny)

data(iris)

ui <- fluidPage(
  
  titlePanel("Iris Data Histograms"),
  
  sidebarLayout(
    
    mainPanel(
      h2("Histograms"),
      
      h3("Sepal Length"),
      plotOutput("sepal_length_hist", height = 300, width = "100%"),
      h3("Sepal Width"),
      plotOutput("sepal_width_hist", height = 300, width = "100%"),
      h3("Petal Length"),
      plotOutput("petal_length_hist", height = 300, width = "100%"),
      h3("Petal Width"),
      plotOutput("petal_width_hist", height = 300, width = "100%")
    ), 
    
    sidebarPanel(
      br(),
      h4("Select Histogram Bins and Colors"),
      sliderInput("sepal_length_bins", "Sepal Length Bins", min = 0.1, max = 1, value = 0.1),
      selectInput("sepal_length_color", "Sepal Length Color", choices = c("blue", "red", "green", "purple")),
      sliderInput("sepal_width_bins", "Sepal Width Bins", min = 0.1, max = 1, value = 0.1),
      selectInput("sepal_width_color", "Sepal Width Color", choices = c("blue", "red", "green", "purple")),
      sliderInput("petal_length_bins", "Petal Length Bins", min = 0.1, max = 1, value = 0.1),
      selectInput("petal_length_color", "Petal Length Color", choices = c("blue", "red", "green", "purple")),
      sliderInput("petal_width_bins", "Petal Width Bins", min = 0.1, max = 1, value = 0.1),
      selectInput("petal_width_color", "Petal Width Color", choices = c("blue", "red", "green", "purple"))
    )
    
  )
)


server <- function(input, output) {
  output$sepal_length_hist <- renderPlot({
    # Set the binwidth and color based on user input
    binwidth <- input$sepal_length_bins
    fill_color <- input$sepal_length_color
    
    # Create the histogram plot using ggplot2
    ggplot(iris, aes(x = Sepal.Length)) +
      geom_histogram(binwidth = binwidth, fill = fill_color) +
      labs(x = "Sepal Length", y = "Frequency") +
      coord_cartesian(xlim = c(4, 8)) +
      scale_x_continuous(expand = c(0, 0)) +
      scale_y_continuous(expand = c(0, 0))
  })
  
  
  output$sepal_width_hist <- renderPlot({
    # Set the binwidth and color based on user input
    binwidth <- input$sepal_width_bins
    fill_color <- input$sepal_width_color
    
    # Create the histogram plot using ggplot2
    ggplot(iris, aes(x = Sepal.Width)) +
      geom_histogram(binwidth = binwidth, fill = fill_color) +
      labs(x = "Sepal Width", y = "Frequency") +
      coord_cartesian(xlim = c(2, 5)) +
      scale_x_continuous(expand = c(0, 0)) +
      scale_y_continuous(expand = c(0, 0))
  })
  
  output$petal_length_hist <- renderPlot({
    # Set the binwidth and color based on user input
    binwidth <- input$petal_length_bins
    fill_color <- input$petal_length_color
    
    # Create the histogram plot using ggplot2
    ggplot(iris, aes(x = Petal.Length)) +
      geom_histogram(binwidth = binwidth, fill = fill_color) +
      labs(x = "Petal Length", y = "Frequency") +
      coord_cartesian(xlim = c(0, 8)) +
      scale_x_continuous(expand = c(0, 0))
  })
  
  output$petal_width_hist <- renderPlot({
    # Set the binwidth and color based on user input
    binwidth <- input$petal_width_bins
    fill_color <- input$petal_width_color
    
    # Create the histogram plot using ggplot2
    ggplot(iris, aes(x = Petal.Width)) +
      geom_histogram(binwidth = binwidth, fill = fill_color) +
      labs(x = "Petal Width", y = "Frequency") +
      coord_cartesian(xlim = c(0, 4))
  })
  
}


shinyApp(ui = ui, server = server)
