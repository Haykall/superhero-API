
library("dplyr")

#calling the csv file with super hero data
df <- read.csv('scatter_files/femalechart.csv', stringsAsFactors = FALSE)

#filtering data to show specific power stats
female <- df %>% select(intelligence, strength, name, race, alignment) 
#Setting a range for dataframe
df_range <- range(0:100)
#Getting the alignments for each hero
alignment_list <- df %>% select(alignment)
