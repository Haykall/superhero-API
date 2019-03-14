# Server File
# server
library(ggplot2)
library(plotly)
library(dplyr)
library(shiny)
library(collapsibleTree)

source("Scatter_files/support.R")
source("scatter_files/heroscatter.R")
source("scatter_files/build_scatter.R")
source("organizations.R")
source("comparisonTool.R")

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
  
  output$tree <- renderCollapsibleTree({
    hero_id <- hero_names[hero_names$names == input$names, ]$id
    if(input$names == "Batman") {
      hero_id <- 70
    }
    if(input$names == "Atom") {
      hero_id <- 50
    }
    if(input$names == "Atlas") {
      hero_id <- 48
    }
    print(hero_id)
    return(organizations(hero_id, input$collapsed))
   })
  

}