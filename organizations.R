
# Load necessary libraries
library(ggplot2)
library(collapsibleTree)
library(shiny)

# Source Connections
source("connections_scripts/get_connections.R")
source("connections_scripts/get_self.R")
source("connections_scripts/get_all_names.R")


organizations <- function(id, collapse) {
  
  hero_connections <- get_connections(character_id = id)
  
  organization_tree <- collapsibleTree(
    hero_connections,
    hierarchy = c("relation", "entity"),
    width = 800,
    zoomable = TRUE,
    root = get_self(character_id = id),
    fill = "relation",
    nodeSize = "leafCount",
    collapsed = collapse
    )  
  
  organization_tree %>% 
    return()
}

all_names <- get_all_names()


ui <- fluidPage(
   titlePanel("Heroes and Their Connections"),
   selectInput(
     "names",
     label = "Choose a hero:",
     choices = all_names,
     selected = all_names[1]
   ),
   collapsibleTreeOutput(outputId = "tree")
)

server <- function(input, output) {
   all_names <- get_all_names()
   output$tree <- renderCollapsibleTree({
     return(organizations(match(input$names, all_names), FALSE))
     })
}

shinyApp(ui, server)
