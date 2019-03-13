# Server File
# server
library(ggplot2)
library(plotly)
library(dplyr)
library(shiny)

source("Scatter_files/support.R")
source("scatter_files/heroscatter.R")
source("scatter_files/build_scatter.R")

# Server used to run the app
server <- function(input, output) {
  # First page output, changes race and color
  output$scatter <- renderPlotly({
    return(build_scatter(
      female,
      input$search,
      input$range[1],
      input$range[2]
    ))
  })
  
  output$scatter2 <- renderPlot({
    return(build_scatterplot(
      female, input$race
    ))
  })

}