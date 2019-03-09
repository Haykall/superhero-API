
# Load necessary libraries
library(dplyr)
library(stringr)

# Source API Key
source("get_data.R")


# Given a character id return a map of of each organization for this character
get_connections <- function(character_id) {

  response_data <- get_data(character_id)
  
  connections <- response_data$connections
  
  groups <- unlist(strsplit(connections$`group-affiliation`, split=", "))
  
  group_data <- tibble(entity = groups, relation = "Groups")
  
  relatives_raw <- connections$relatives
  
  relatives <- gsub("\\s*\\([^\\)]+\\)","",as.character(relatives_raw))
  relatives <- unlist(strsplit(relatives, split=", "))
  
  relations <- gsub(
    "[\\(\\)]",
    "",
    regmatches(
      relatives_raw,
      gregexpr(
        "\\(.*?\\)",
        relatives_raw)
    )
    [[1]]
  )
  
  relations <- gsub(", deceased", "", relations)
  
  relative_data <- tibble(entity = relatives, relation = "Relatives") %>%
    mutate(entity = paste0(entity, " - ", relations))
  
  connection_data <- full_join(group_data, relative_data, by = c("entity", "relation"))
  
  connection_data 
}
  

