# UI file
library(shiny)
library(plotly)

source("Scatter_files/support.R")

# Responsbile for the first page with two widgets controling one visualization
# allowing users to change the race population shown and the opacity
first_page <- tabPanel(
  "Welcome",
  titlePanel("Superhero Data Analysis"),
  sidebarLayout(
    sidebarPanel(
      
    ),
    mainPanel(
      h1("Introduction"),
      p("We are a group of college students who are big fans of superheros.")
      )
  )
  )

second_page <- tabPanel(
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
      "Strength and Intelligence: 
          
      Two of the most common factors considered 
      when analyzing the hierarchy of well known superheros. Compare how 
      each female superhero stands against each other in terms of strength
      and intelligence. You have the flexibility to search for an individual 
      hero, or look within a certain range of strength. 
      
      You also have the ability to compare strength and intelligence 
      between alignments."
    ),
    mainPanel(plotlyOutput("scatter"), plotOutput("scatter2"))
  )
)

# Responsible for the second page with two widgets controling one visualization
# allowing users to change the age group in pverty and the color of the points


# Describes the loyout of the webpage
ui <- navbarPage(
  "Superhero API",
  first_page, 
  second_page
)