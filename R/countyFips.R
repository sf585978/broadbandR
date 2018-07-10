#' Latitude and longitude for U.S. counties
#' 
#' A dataset containing the latitude and longitude coordinates for U.S. 
#' counties
#' 
#' @format A data frame with 33144 rows and 3 variables:
#' \describe{
#' \item{State}{State abbreviation, as a character string}
#' \item{FIPS}{FIPS code, as a numeric}
#' \item{County}{County name, as a character string}
#' \item{County_Seat}{County seat name, as a character string}
#' \item{Population}{County population, as a numeric}
#' \item{lat}{Latitude of county center, as a numeric}
#' \item{lon}{Longitude of county center, as a numeric}
#' }
#' @source \url{https://en.wikipedia.org/wiki/User:Michael_J/County_table}
"countyFips"