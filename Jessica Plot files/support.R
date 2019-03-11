
library("dplyr")

df <- read.csv('femalechart.csv', stringsAsFactors = FALSE)

female <- df %>% select(intelligence, strength, name, race, alignment) 
df_range <- range(0:100)
alignment_list <- df %>% select(alignment)
