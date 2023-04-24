library(shiny)
library(ggplot2)
library(plotly)
library(tidyr)

data(iris)

ui <- fluidPage(
  
  titlePanel("Iris Data Visualization"),
  
  sidebarLayout(
    mainPanel(
      plotlyOutput("plot"),
    ),
    sidebarPanel(
      h4("Select Attribute:"),
      selectInput("attribute", label = NULL, 
                  choices = names(iris)[-5], 
                  selected = "Sepal.Width"),
      h4("Select Plot Type:"),
      selectInput("plot_type", label = NULL, 
                  choices = c("Box Plot", "Violin Plot"), 
                  selected = "Box Plot")
    ),
  )
)

server <- function(input, output) {
  
  plot_data <- reactive({
    if(input$plot_type == "Box Plot") {
      iris %>%
        pivot_longer(-c(Species, input$attribute), names_to = "variable", values_to = "value") %>%
        ggplot(aes(x = Species, y = value, fill = Species)) +
        geom_boxplot() 
    } else {
      iris %>%
        ggplot(aes(x = Species, y = .data[[input$attribute]], fill = Species)) +
        geom_violin() +
        geom_boxplot() 
    }
  })
  
  output$plot <- renderPlotly({
    plot_data() %>%
      ggplotly(tooltip = c("Species", input$attribute, "value")) %>%
      layout(xaxis = list(title = "Species"),
             yaxis = list(title = input$attribute)) %>%
      config(displayModeBar = FALSE)
  })
  
}


shinyApp(ui, server)
