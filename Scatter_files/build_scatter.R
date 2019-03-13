library(plotly)
library(ggplot2)
library(stringr)

library("styler")
### Build Scatter ###
build_scatterplot <- function(dataset,
                          alignment_choice,
                          xvar = "strength",
                          yvar = "intelligence") {

  
  # Filter data based on search
  dataset <- dataset %>%
    filter(alignment == alignment_choice
    )
  
  # Create plot
  creating_plot <- ggplot(data = dataset) + geom_point(size = 5, shape = 18,
    mapping = aes(x = dataset[, xvar], y = dataset[, yvar], color = alignment),
  ) + 
    scale_color_brewer(palette = "Set3") +  labs(
    title = "Strength vs. Intelligence by Allignment",
    x = "Strength Levels", y = "Intelligence Levels"
  )
  creating_plot
}
