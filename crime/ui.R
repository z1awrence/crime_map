library(shiny)
source('map_functions.R')
library(datasets)
library(ggplot2) # load ggplot
library(ggmap)
library(reshape2)
# Define UI for miles per gallon application
shinyUI(fluidPage(
  
  titlePanel("Welcome! This app will calculate how safe is it to travel from Point A to Point B depending on the type of crime."),
  
  sidebarLayout(
  
  # Application title
  
  # Sidebar with controls to select the variable to plot against mpg
  # and to specify whether outliers should be included
  sidebarPanel(
    textInput(inputId = "start_address", 
                      label = "Please Enter a start location",
                      value = "University of California, San Francisco"
                      ),
    textInput(inputId = "end_address", 
              label = "Please Enter an end location",
              value = "Chinatown, San Francisco"
    ),
    selectInput("category", "What type of Crime to Plot and Use in Safety Score",
                c("Assault" = "ASSAULT",
                  "Burglary" = "BURGLARY",
                  "Missing person" = "MISSING PERSON",
                  "Robbery" = "ROBBERY",
                  "Vandalism" = "VANDALISM"
                  ))
  ),
  
  # Show the caption and plot of the requested variable against mpg
  mainPanel(
    textOutput("geocode"),
    plotOutput("map")
  )
)
)
)


