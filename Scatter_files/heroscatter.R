
library("stringr")
library("dplyr")
library("plotly")



build_scatter <- function(dataset,
                          search = "",
                          min,
                          max,
                          xvar = "strength",
                          yvar = "intelligence") {



  dataset <- dataset %>%
    filter(grepl(search, name), strength >= min, strength <= max)

  plot_ly(
    data = dataset,      # pass in the data to be visualized
    x = ~dataset[, xvar], # use a formula to specify the column for the x-axis
    y = ~dataset[, yvar], # use a formula to specify the column for the y-axis
    color = ~race, # use a formula to specify the color encoding
    type = "scatter", # specify the type of plot to create
    mode = "markers", 
    marker = list(opacity = 0.6, size = 15),
    text = paste(dataset$name,":" ,
                 "Strength -", dataset$strength, 
                 "Intelligence -", dataset$intelligence,
                 "Alignment - ", dataset$alignment),
    hoverinfo = "text"
  ) %>%
    layout(
      title = "Intelligence vs. Strength",    # plot title
      xaxis = list(title = "Strength Levels"), # axis label + format
      yaxis = list(title = "Intelligence Levels")  # axis label + format
    ) %>% 
    return()
  

}
