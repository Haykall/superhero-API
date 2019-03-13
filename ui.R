# UI file
library(shiny)
library(plotly)
library(collapsibleTree)

source("Scatter_files/support.R")
source("organizations.R")

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
      "WAHAHAHAH"
    ),
    mainPanel(plotlyOutput("scatter"), plotOutput("scatter2"))
  )
)

third_page <- tabPanel(
  "Heros and Connections",
  titlePanel("Heroes and Their Connections"),
  selectInput(
    "names",
    label = "Choose a hero:",
    choices = hero_names$names,
    selected = hero_names$names[1]
  ),
  checkboxInput("collapsed", "Collapse the Tree?", TRUE),
  collapsibleTreeOutput(outputId = "tree")
)

# Responsible for the second page with two widgets controling one visualization
# allowing users to change the age group in pverty and the color of the points


# Describes the loyout of the webpage
ui <- navbarPage(
  "Superhero API",
  first_page, 
  second_page,
  third_page
)