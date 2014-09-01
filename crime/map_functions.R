library(ggmap)
library(reshape2)


##function to calculate the "safeness" of a point
##take a point
safeScore <- function(direction_point,crime_points) {
  
  score <- 0
  
  for(i in 1:length(crime_points[[1]])) {
    score <- score + (sqrt(abs(crime_points$X[i] - direction_point[1])) +  sqrt(abs(crime_points$Y[i] - direction_point[2])) )
    
  }
  return(score)
  
}

##function to calculate the overall safeness of a route
safeScoreRoute <- function(route, crime_points) {
  routeScore <- 0
  
  for(i in 1:length(route[[1]])) {
    routeScore <- routeScore + safeScore(c(route$lng[i], route$lat[i]), crime_points )
    cat(routeScore)
    cat("\n")
  }
  return(routeScore/length(route[[1]]))
}

getRoutePoints <- function(p1, p2) {
  r = route(p1,p2,output="all")
  ## getting the points on a route
  x <- sapply(r$routes[[1]]$legs[[1]]$steps,function(s){c(s$start_location)})
  lat<- x[rownames(x)=="lat", ]
  lng <- x[rownames(x)=="lng", ]
  lat <- melt(lat)
  lat$lat <- lat$value
  lat$value <- NULL
  lng <- melt(lng)
  lng$lng <- lng$value
  lng$value <- NULL
  direction_points <- data.frame(lat,lng)
  
  return(direction_points)
  
}