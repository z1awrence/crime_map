library(shiny)
library(datasets)
library(ggplot2) # load ggplot
library(ggmap)
library(reshape2)

SFMap <- qmap('San Francisco', zoom = 12, legend = 'topleft')
source("map_functions.R")
crime_points <- head(read.table("data/crime_data.csv", header=TRUE, sep=","),5000)


# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
  

  
  # Return the formula text for printing as a caption
  output$geocode <- renderText(function() {
    paste("The Safety Score for your route is: ", safeScoreRoute( getRoutePoints(input$start_address, input$end_address), subset(crime_points, Category == input$category)))
  })
  
  # Generate a plot of the requested variable against mpg and only 
  # include outliers if requested
  # ggplot version
  
  output$map <- reactivePlot(function() {
    start_point<- melt(geocode(input$start_address))
    end_point<- melt(geocode(input$end_address))
    print(SFMap +geom_point(aes(x = X, y = Y), data = subset(crime_points, Category == input$category), alpha=1 ) +
            geom_point(x=start_point$value[1], y=start_point$value[2], color='red') + 
            geom_point(x=end_point$value[1], y=end_point$value[2], color='red')) 
    
  })
  
})





# server.R
# library(ggmap)
# library(reshape2)
# SFMap <- qmap('San Francisco', zoom = 12, legend = 'topleft')
# 
# crime_points <- read.table("data/crime_data.csv", header=TRUE, sep=",")
# source("map_functions.R")
# 
# shinyServer(
#   function(input, output) {
#     output$address <- renderText({
#       paste("You entered", input$address, "that is geocode: ", geocode(input$address)[1], " ", geocode(input$address)[2])
#     },
#     
#     output$map <- reactivePlot(function() {
#       print(SFMap)
#     }
#     
#       )
#     )
#   }
# 
# )
# 

