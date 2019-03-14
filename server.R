# Server File
# server
library(ggplot2)
library(plotly)
library(dplyr)
library(shiny)
library(collapsibleTree)
library(leaflet)

source("scatter_files/support.R")
source("scatter_files/heroscatter.R")
source("scatter_files/build_scatter.R")
source("connections_scripts/build_hist.R")
source("organizations.R")
source("heroMap.R")

data <- read.csv("connections_scripts/comparison.csv")

# Server used to run the app
server <- function(input, output) {
  # First page output, changes which supehero and power range
  output$scatter <- renderPlotly({
    return(build_scatter(
      female,
      input$search,
      input$range[1],
      input$range[2]
    ))
  })
  
  # First page second output, changes hero alignment
  output$scatter2 <- renderPlot({
    return(build_scatterplot(
      female, input$race
    ))
  })
  
  # Second page output, changes hero and whether the tree shoudl be collapsed
  output$tree <- renderCollapsibleTree({
    hero_id <- hero_names[hero_names$names == input$names, ]$id
    
    # Catch duplicate superheroes
    if(input$names == "Batman") {
      hero_id <- 70
    }
    if(input$names == "Atom") {
      hero_id <- 50
    }
    if(input$names == "Atlas") {
      hero_id <- 48
    }
    if(input$names == "Captain Marvel") {
      hero_id <- 157
    }
    if(input$names == "Spider-Man") {
      hero_id <- 620
    }
    if(input$names == "Batgirl") {
      hero_id <- 63
    }
    if(input$names == "Black Canary") {
      hero_id <- 97
    }
    if(input$names == "Blizzard") {
      hero_id <- 116
    }
    if(input$names == "Blue Beetle") {
      hero_id <- 123
    }
    if(input$names == "Goliath") {
      hero_id <- 290
    }
    if(input$names == "Nova") {
      hero_id <- 496
    }
    if(input$names == "Toxin") {
      hero_id <- 671
    }
    
    return(organizations(hero_id, input$collapsed))
   })
  
  # Third page output, changes two heroes
  output$hist <- renderPlot({
    return(build_hist(data, input$hero1, input$hero2))
  })
  
  # Fourth page output, changes publisher
  output$map <- renderLeaflet({
    return(make_super_map(input$publisher))
  })

}