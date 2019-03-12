
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


ui <- fluidPage(
   titlePanel("Heroes and Their Connections"),
   selectInput(
     "names",
     label = "Choose a hero:",
     choices = hero_names$names,
     selected = hero_names$names[1]
   ),
   checkboxInput("collapsed", "Collapse the Tree?", TRUE),
   collapsibleTreeOutput(outputId = "tree")
)


server <- function(input, output) {
  
   output$tree <- renderCollapsibleTree({
     
     hero_id <- hero_names[hero_names$names == input$names, ]$id
      
     if(input$names == "Batman") {
       hero_id <- 70
     }
     
     print(hero_id)
     
     return(organizations(hero_id, input$collapsed))
     })
}

shinyApp(ui, server)