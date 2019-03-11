library("shiny")
library("ggplot2")
library("plotly")

source("support.R")



shinyUI(
  navbarPage(
    "Superhero API",
    tabPanel(
      "Female Hero Scatterplot",
      titlePanel("Scatterplot"),
      sidebarLayout(
        sidebarPanel(
          sliderInput(
            "range",
            label = "Range of Hero Strength",
            min = df_range[1],
            max = df_range[2],
            value = df_range
          ),
          textInput("search", label = "Search by Hero Name", value = ""),
          selectInput(
            "race",
            label = "Choose a type of alignment",
            choices = alignment_list
          ),
          "WAHAHAHAH"
        ),
        mainPanel(plotlyOutput("scatter"), plotOutput("scatter2"))
      )
    )
  )
)
