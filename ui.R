# UI file
library(shiny)
library(plotly)

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

# Responsible for the second page with two widgets controling one visualization
# allowing users to change the age group in pverty and the color of the points


# Describes the loyout of the webpage
ui <- navbarPage(
  "Superhero API",
  first_page
)