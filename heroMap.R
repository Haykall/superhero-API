##Create an interactive map of the hero data 

source("api-keys.R")
library("httr")
library("jsonlite")
library("dplyr")
library("knitr")



#Created a for loop to retrieve individual character information from API
resource <- "/biography"
base_url <- "https://superheroapi.com/api/"
result=data.frame()
for (character_id in 1:731)
{
  endpoint <- paste0(base_url,superhero_key,"/",character_id,resource)
  response <- GET(endpoint)
  body <- content(response, "text")
  parsed_data <- fromJSON(body)
  print(parsed_data)
  #Creates a data frame for information about each superhero/villan and 
  #Useful information that can be displayed on a map
  result= rbind( result,data.frame(parsed_data$id,parsed_data$`full-name`,parsed_data$publisher,
                                   parsed_data$`full-name`, parsed_data$`place-of-birth`))
}

#Create a data frame that renames the columns to be neater and then filters for 
#Marvel Comics characters ONLY to create the map
marvel_frame <- result%>%
  select(parsed_data.id, parsed_data..full.name.,parsed_data.publisher,parsed_data..place.of.birth.)%>%
  rename( "ID"=parsed_data.id,"Full Name"= parsed_data..full.name.,
         "Place of Birth"=parsed_data..place.of.birth., "Publisher"= parsed_data.publisher)%>%
  filter(Publisher == "Marvel Comics")
  


make_impact_map <- leaflet(data = marvel_frame, width = "100%") %>%
  addProviderTiles("CartoDB.Positron") %>%
  setView(lng = -101.584521, lat = 40.554970, zoom = 4.25) %>%
  addLegend(
    position = "topright",
    title = "2018 Impact of Mass shootings in U.S",
    pal = palette_fn,
    values = ~ final_plot$impacted,
    opacity = 1
  ) %>%
  addCircles(
    lat = final_plot$latitude,
    lng = final_plot$longitude,
    popup = paste(
      final_plot$city, "<br>",
      "Number Killed:", final_plot$killed, "<br>",
      "Number Injured:", final_plot$injured, "<br>",
      "Total Affected:", final_plot$affected_people, "<br>",
      "Total impact:", final_plot$impacted, "<br>"
    ),
    color = ~ palette_fn(final_plot$impacted),
    radius = sizing,
    stroke = FALSE,
    fillOpacity = 1
  )