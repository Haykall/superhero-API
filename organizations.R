
# Load necessary libraries
library(ggplot2)
library(collapsibleTree)
# Source Connections
source("connections_scripts/get_connections.R")

id <- 731

hero_connections <- get_connections(character_id = id)

collapsibleTree(hero_connections,
                hierarchy = c("relation", "entity"), width = 800,
                zoomable = FALSE, root = get_self(character_id = id))
