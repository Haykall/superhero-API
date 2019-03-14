
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
    fill = c(
      # The root
      "#FF5E5B",
      # Unique regions
      rep("#00CECB", length(unique(hero_connections$relation))),
      # Unique names per region
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
