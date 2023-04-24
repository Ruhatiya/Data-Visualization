library(shiny)

ui <- fluidPage(
  
  titlePanel("Visualizing the Distribution of Waiting Times"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput(inputId = "num_bins",
                  label = "Number of Bins:",
                  min = 1,
                  max = 50,
                  value = 30)),
    mainPanel(
      plotOutput(outputId = "hist_plot")
    )
  )
)

server <- function(input, output) {
  
  output$hist_plot <- renderPlot({
    data <- faithful$waiting
    bins <- seq(min(data), max(data), length.out = input$num_bins + 1)
    hist(data, breaks = bins, col = "#007bc2", border = "orange",
         xlab = "Waiting Time to Next Eruption (in mins)",
         main = "Histogram of Waiting Times")
    
  })
  
}

shinyApp(ui = ui, server = server)
