# UI file
library(shiny)
library(plotly)
library(collapsibleTree)
library(shinythemes)
library(leaflet)

source("Scatter_files/support.R")
source("organizations.R")

data <- read.csv("connections_scripts/comparison.csv")

# Responsbile for the first page with two widgets controling one visualization
# allowing users to change the race population shown and the opacity
first_page <- tabPanel(
  "Welcome",
  titlePanel("Superhero Data Analysis"),
  mainPanel(
    h1("Introduction"),
    p("We are a group of college students who are big fans of superheros.In our team we have"),
    h2("Where is Our Data From?"),
    p("We will be working with the Superhero API. This API is a quantified 
      and programatically accessible data source of all superheroes from
      different comic universes. They’ve taken all the stuff and put
      it together in a form that is easier to consume with software.
      The data is accessible through a REST API. A Facebook account to
      get your access token"),
    h3("Research Questions"),
    p("Our target audience are comic book fans and anyone who is a fan of superheroes and villains,
      and just want to know more about them. We hope to help aspiring superheroes
      and villains in preparing them on their journey in becoming a hero / villian.
      Our audience is interested in learning everything about superheros, such as how 
      they compare against each other and where they are found. We want to help our audience understand what it takes to be a superhero
      
      Our audience wants to learn what it takes to become a superhero. We will address:
      Mapping out each of the superhero and villain organization headquarters/ base to find out where most heroes / villians are mostly stationed, and where is the best place to be a superhero.
      We will compare different heroes and villains with their power stats and abilities to see which hero / villain would win. This would help our audience understand which powers are the strongest and weakest, and what kind of abilities are best against other types of abilities.
      Superheroes and villains have many organizations and affiliations.")
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

fourth_page <- tabPanel(
  "Histogram",
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

fifth_page <- tabPanel(
  "Hero Map",
  # Add a titlePanel to your tab
  titlePanel("Birthplaces of Superheros in the United States"),
  # Create a sidebarPanel for your controls,
  # Create a main panel to show the histogram
  mainPanel(
    leafletOutput("map")
  )
)



# Responsible for the second page with two widgets controling one visualization
# allowing users to change the age group in pverty and the color of the points


# Describes the loyout of the webpage
ui <- navbarPage(theme = shinytheme("united"),
  "Superhero API",
  first_page, 
  second_page,
  third_page,
  fourth_page,
  fifth_page,
  fluid = TRUE
)
