# UI file
library(shiny)
library(plotly)
library(collapsibleTree)
library(shinythemes)
library(leaflet)

source("scatter_files/support.R")
source("organizations.R")

data <- read.csv("connections_scripts/comparison.csv")

# Responsbile for the first page which welcomes the users to the page
first_page <- tabPanel(
  "Welcome",
  titlePanel("Superhero Data Analysis"),
  mainPanel(
    h1("Introduction"),
    p("We are a group of college students who are big fans of superheroes. In our team we have George Zhang,
      Jessica Prasetyo, Zarah Khan, Jeremey Lin, and Haykal Mubin. "),
    h2("Where is Our Data From?"),
    p("We worked with the Superhero API. This API is a quantified and programmatically
      accessible data source of all superheroes from different comic universes. They’ve taken
      all the stuff and put it together in a form that is easier to consume with software. The
      data is accessible through a REST API. A Facebook account to get your access token the link
      to the API is https://superheroapi.com. The R packages used for this project were: shiny, plotly
      collapsibleTree, shinythemes, leaflet, ggplot2, and dplyr. These allowed us to build beauitful and 
      interactive plots and diagrams throughout our pages."),
    h2("Research Questions"),
    p("Our target audience are comic book fans and anyone who is a fan of superheroes and villains,
      and just want to know more about them. We hope to help aspiring superheroes
      and villains in preparing them on their journey in becoming a hero / villain.
      Our audience is interested in learning everything about superheroes, such as how 
      they compare against each other and where they are found. We want to help our audience
      understand what it takes to be a superhero
      "),
    h3("Female Hero Scatterplot"),
    p("This plot displays plots that compare female heroes with their strength and intelligence levels.
      You can search for a hero and identify where they lie on the plot and adjust the range of hero 
      strength. Hovering over the Intelligence vs. Strength points will show the name of the Hero, alignment
      strength, and intelligence. You can also pick a plot by alignment which displays the Strength vs
      Intelligence for that alignment. These plots help identify which female heroes are most strong and
      intelligent."),
    h3("Heroes and Their Connections"),
    p("We wanted to make sure our audience was able to understand the context of the lives these heroes live.
      For that reason, we created a collapsible tree which allows the visualization of the organizations
      and people that these heroes are associated with. There is a selection bar for the hero and the tree can
      be collapsed to reveal the people."),
    h3("Comparing Heroes Histogram"),
    p("A natural question someone might have when thinking about superheroes has to do with the comparison of
      powers from different heroes. Thus, we created a histogram that displays various aspects of a hero and
      allows users to select two heroes that they want to compare."),
    h3("Hero Birthplace Map"),
    p("Where do the heroes that we admire so much come from? This visualization represents points that the 
      heroes were born in within the United States. Each point on the map show the birthplace of a hero,
      hovering over the data points will reveal the Name, Full Name, Place of Birth, and Publisher of the hero.
      You can select a publisher which will show heroes produced by the publisher selected.")
    )
  )

# Creating the second tab page for female hero strengths
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

# Collapsable tree connections tab code
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

# Comparison histogram page display
fourth_page <- tabPanel(
  "Power Comparision",
  # Add a titlePanel to your tab
  titlePanel("Comparing Superhero Power Statistics"),
  # Create a sidebarPanel for your controls
  sidebarPanel(
    # Make a textInput widget for searching for a state in the scatter
    selectInput("hero1", label = "Choose a Character",
                choices = data$name, selected = data$name[1]),
    selectInput("hero2", label = "Choose Second Character",
                choices = data$name, selected = data$name[2])
  ),
  # Create a main panel to show the histogram
  mainPanel(
    plotOutput("hist")
  )
)

# Controls the webpage for the Hero Map Visualization
fifth_page <- tabPanel(
  "Hero Map",
  # Add a titlePanel to your tab
  titlePanel("Birthplaces of Superheros in the United States"),
  # Create a sidebarPanel for your controls,
  sidebarPanel(
    selectInput("publisher", label = "Choose a publisher:",
                choices = list("DC Comics", "Marvel Comics")
               )
  ),
  # Create a main panel to show the histogram
  mainPanel(
    leafletOutput("map")
  )
)


# Describes the layout and theme of the webpage
ui <- navbarPage(theme = shinytheme("united"),
  "Superhero API",
  first_page, 
  second_page,
  third_page,
  fourth_page,
  fifth_page,
  fluid = TRUE
)
