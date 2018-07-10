#' A function to retrieve mobile broadband provider information
#' 
#' A function for interfacing with the national broadband map API.
#' @param lat The latitude of the location of interest; optional if a zipcode is provided
#' @param long The longitude of the location of interest; optional if a zipcode is provided
#' @param zip The zipcode of the location of interest as a character string; an optional parameter when coordinates are not known
#' @param time The segment of data of interest; check the API documentation for options
#' @return A data frame of mobile broadband providers in a given location along with relevant technology performance metrics.
#' @keywords mobile broadband, API
#' @export
#' @examples
#' getProviders(39.958520, -75.198857, "jun2014")
#' getProviders("19104", "jun2014")

getProviders <- function(lat, lon, zip, time) {
  require(jsonlite)
  require(tidyr)
  if(missing(time)) {
    error("You need to supply the time period of data you wish to consider.")
  }
  if (missing(lat) & missing(lon)) {
    if(missing(zip)) {
      error("You need to supply either the latitude and longitude or a zip code.")
    } else {
      lat <- zips$lat[which(zips$zip == zip)]
      lon <- zips$lon[which(zips$zip == zip)]
    }
  }
  url <- paste("https://www.broadbandmap.gov/broadbandmap/broadband/",
               time,
               "/wireless?latitude=",
               lat,
               "&longitude=",
               lon,
               "&maxResults=1000&format=json",
               sep = "")
  out <- fromJSON(url)
  if (test$status == "OK") {
    out2 <- unnest(out$Results$wirelessServices)
    colnames(out2)[7:22] <- paste(colnames(out2)[7:22], time, sep = "_")
    cat("Providers pulled successfully.")
    return(out2)
  } else {
    error("Providers not pulled successfully.")
  }
}
