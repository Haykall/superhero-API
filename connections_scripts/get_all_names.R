# Load necessary libraries
library(dplyr)
source("connections_scripts/get_data.R")
source("connections_scripts/get_self.R")

# Buggy ones are 132, 173, 368

get_all_names <- function() {
  
  names_list <- c()
  
  for (i in 1:3) {
    names_list[i] <- get_self(i)
  }
  
  # for (i in 133:172) {
  #   names_list[i] <- get_self(i)
  # }
  # 
  # for (i in 174:367) {
  #   names_list[i] <- get_self(i)
  # }
  # 
  # for (i in 369:731) {
  #   names_list[i] <- get_self(i)
  # }
  
  names_list
}

