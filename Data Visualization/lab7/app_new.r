library(shiny)
library(datasets)

ui <- fluidPage(
  
  titlePanel("Histogram of Tooth Growth Lengths"),
  
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
    data <- ToothGrowth$len
    bins <- seq(min(data), max(data), length.out = input$num_bins + 1)
    hist(data, breaks = bins, col = "#007bc2", border = "orange",
         xlab = "Tooth Growth Length (in mm)",
         main = "Histogram of Tooth Growth Lengths")
  })
  
}

shinyApp(ui = ui, server = server)
