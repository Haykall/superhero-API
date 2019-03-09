library(dplyr)
library(stringr)

# Source API Key
source("get_data.R")

# Given a character's id, get their name
get_self <- function(character_id) {
  
  response_data <- get_data(character_id = character_id)
  
  hero_name <- response_data$name
  real_name <- response_data$biography$`full-name`
  
  display_name <- paste(real_name, hero_name, sep = " - ")
  
  display_name
  
}