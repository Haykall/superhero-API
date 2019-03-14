
# Load necessary libraries
library(ggplot2)
library(collapsibleTree)
library(shiny)

# Source Connections
source("connections_scripts/get_connections.R")
source("connections_scripts/get_self.R")
source("connections_scripts/get_all_names.R")

#Input character id and whether the tree should be collapsed or not
organizations <- function(id, collapse) {
  
  # Get all the characters connections from the API
  hero_connections <- get_connections(character_id = id)
  
  # Make a collapsible tree with this new data and sort it by type of relationship
  organization_tree <- collapsibleTree(
    hero_connections,
    hierarchy = c("relation", "entity"),
    width = 800,
    zoomable = TRUE,
    root = get_self(character_id = id),
    fill = c(
      "#FF5E5B",
      rep("#00CECB", length(unique(hero_connections$relation))),
      rep("#FFED66",
          length(
            unique(
              paste(
                hero_connections$entity, hero_connections$relation)
              )
            )
        )
    ),
    fillByLevel = TRUE,
    nodeSize = "leafCount",
    collapsed = collapse
  )

  organization_tree %>%
    return()
}
