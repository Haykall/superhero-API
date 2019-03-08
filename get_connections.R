
# Load necessary libraries
library(dplyr)
library(httr)
library(jsonlite)
library(stringr)

# Source API Key
source("api-keys.R")

# Given a character id return a map of of each organization for this character
get_connections <- function(character_id) {
  
  base_uri <- "https://superheroapi.com/api"
  
  uri.full <- paste(base_uri, superhero_key, character_id, sep = "/")
  
  response <- GET(uri.full)
  
  # Parse with JSON
  response_text <- content(response, "text")
  response_data <- fromJSON(response_text)
  
  connections <- response_data$connections
  
  groups <- unlist(strsplit(connections$`group-affiliation`, split=", "))
  
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
  
  relative_data <- data_frame(relatives, relations)
  
  relative_data
  
  connections_data <- list(groups = groups, relatives = relative_data)
  
}





