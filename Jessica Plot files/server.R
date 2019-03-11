library("dplyr")
library("shiny")
library("ggplot2")
library("plotly")

source("support.R")
source("heroscatter.R")
source("build_scatter.R")

shinyServer(function(input, output) {
  # Render a  object that returns scatterplot
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
})
