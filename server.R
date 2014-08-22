# server.R


library(maps)
library(mapproj)
counties <- readRDS("data/counties.rds")
source("helpers.R")

shinyServer(
  function(input, output) {
    output$map <- renderPlot({
      data <- switch(input$var, 
                     "Percent White" = counties$white,
                     "Percent Black" = counties$black,
                     "Percent Hispanic" = counties$hispanic,
                     "Percent Asian" = counties$asian)
      color <- switch(input$var, 
                      "Percent White" = "darkgreen",
                      "Percent Black" = "black",
                      "Percent Hispanic" = "darkorange",
                      "Percent Asian" = "darkviolet")
      
      legend <- switch(input$var, 
                       "Percent White" = "% White",
                       "Percent Black" = "% Black",
                       "Percent Hispanic" = "% Hispanic",
                       "Percent Asian" = "% Asian")
      
      percent_map(var = data, 
                  color = color, 
                  legend.title = legend, 
                  max = input$range[2], 
                  min = input$range[1])
    })
  }
)

##lesson 4 stuff
# shinyServer(function(input, output) {
#   
#   output$text1 <- renderText({ 
#     paste("You have selected", input$var)
#   })
#   
#   output$text2 <- renderText({ 
#     output$text2 <- renderText({ 
#       paste("You have chosen a range that goes from",
#             input$range[1], "to", input$range[2])
#     })
#     
#   })
#   
# }
# )
