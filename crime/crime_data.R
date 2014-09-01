getwd()
setwd('Desktop/School/summer/data_udacity/messing_around/crime')


library(ggmap)
library(reshape2)


crime_points <- read.table("SFPD_Incidents_-_2013.csv", header=TRUE, sep=",")



##get a route
r = route("University of California, San Francisco","Chinatown San Francisco",output="all")
r = route("Pier 39 San Francisco","Golden Gate Park San Francisco",output="all")
## getting the points on a route
x <- sapply(r$routes[[1]]$legs[[1]]$steps,function(s){c(s$start_location)})
lat<- x[rownames(x)=="lat", ]
lng <- x[rownames(x)=="lng", ]
lat

lat <- melt(lat)
lat$lat <- lat$value
lat$value <- NULL
lng <- melt(lng)
lng$lng <- lng$value
lng$value <- NULL
direction_points <- data.frame(lat,lng)



##get the coordinates of an address
geocode('Stanford University')

##get the map of San Francisco
SFMap <- qmap('San Francisco', zoom = 12, legend = 'topleft')


##map with crime points and direction points

SFMap +geom_point(aes(x = X, y = Y), data = crime_points, alpha=1/50 ) +
  geom_point(aes(x = lng, y = lat, color='directions'), data = direction_points )
##line with crime points and directions
SFMap +geom_point(aes(x = X, y = Y), data = crime_points, alpha=1/50 ) +
  geom_line(aes(x = lng, y = lat, color='directions'), data = direction_points )


##crime points by category
SFMap +geom_point(aes(x = X, y = Y, size=Category, color=Category), data = head(crime_points,100) )


##density plot of crime
SFMap +  
  stat_density2d(aes(x = X, y = Y, fill = ..level..),
                  size = 1, bins = 50, data = test, geom = 'polygon')



##testing it out

safeScore(c(direction_points$lng[1],direction_points$lat[1]), head(crime_points))
safeScore(c(direction_points$lng[4],direction_points$lat[4]), crime_points)

cat(safeScoreRoute(direction_points, crime_points))


##run group by crime type ( category) and then get the mean distances for each 
##category!! or other variables. LOTS OF EXPLORING TO DO TOMORROW!!!



##misc stuff
?runGitHub
runGitHub( "crime_map", "zherbst") 
install.packages('shinyapps')
library(shinyapps)
install.packages('devtools')
devtools::install_github('rstudio/shinyapps')
shinyapps::setAccountInfo(
  name="zherbst", 
  token="4FDE639F547BA3F858D762CD60A08377", 
  secret="L38bjeE1+epx3jvAsqf0vhMdBSOudCi1L1b5j+DC")
library(shinyapps)
shinyapps::setAccountInfo(name='zherbst', token='4FDE639F547BA3F858D762CD60A08377', secret='L38bjeE1+epx3jvAsqf0vhMdBSOudCi1L1b5j+DC')
library(shiny)
deployApp()

