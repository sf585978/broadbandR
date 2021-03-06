#' A function to retrieve mobile broadband provider information
#'
#' A function for interfacing with the national broadband map API.
#' @param lat The latitude of the location of interest; optional if a zipcode is provided
#' @param long The longitude of the location of interest; optional if a zipcode is provided
#' @param zip The zipcode of the location of interest as a character string; an optional parameter when coordinates are not known
#' @param fips The county-level fips code of the location of interest as a numeric string with no leading zeros; an optional parameter when coordinates are not known
#' @param time The segment of data of interest; check the API documentation for options
#' @return A data frame of mobile broadband providers in a given location along with relevant technology performance metrics.
#' @import jsonlite
#' @import tidyr
#' @import noncensus
#' @keywords mobile broadband, API
#' @export
#' @examples
#' getProviders(lat = 39.958520, lon = -75.198857, time = "jun2014")
#' getProviders(zip = "19104", time = "jun2014")
#' getProviders(fips = 42101, time = "jun2014")

getProviders <- function(lat, lon, zip, fips, time) {
  require(jsonlite)
  require(tidyr)
  require(noncensus)
  data("zip_codes")
  if(missing(time)) {
    error("You need to supply the time period of data you wish to consider.")
  }
  if (missing(lat) & missing(lon)) {
    if(missing(zip)) {
      if(missing(fips)) {
        error("You need to supply either the latitude and longitude, zipcode, or fips code.")
      }
      else {
        lat <- mean(zip_codes$latitude[which(zip_codes$fips == fips)])
        lon <- mean(zip_codes$longitude[which(zip_codes$fips == fips)])
      }
    } else {
      lat <- zip_codes$latitude[which(zip_codes$zip == zip)]
      lon <- zip_codes$longitude[which(zip_codes$zip == zip)]
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
  n1 <- ncol(out$Results$wirelessServices)
  n2 <- (n1 - 1) + length(out$Results$wirelessServices$technologies[[1]])
  if (out$status == "OK") {
    l <- length(out$message)
    if (l != 0) {
      if (out$message == "No results found") {
        warning("No results found.")
        out2 <- "No results found."
        return(out2)
      }
    } else {
      out2 <- unnest(out$Results$wirelessServices)
      colnames(out2)[n1:n2] <- paste(colnames(out2)[n1:n2], time, sep = "_")
      cat("Providers pulled successfully.")
      return(out2)
    }
  } else {
    stop("Providers not pulled successfully.")
  }
}
