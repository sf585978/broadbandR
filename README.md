# broadbandR
An R package for interfacing with the FCC's National Broadband Map API.

## Installation
To get the current version of the pacakge from GitHub:
```r
# Install devtools
# install.packages("devtools")

# Load devtools
library(devtools)

# Install from GitHub
install_github("sf585978/broadbandR")

# Load the broadbandR package
library(broadbandR)
```

## Get Broadband Providers
The FCC's National Broadband Map API allows you to collect data on the mobile broadband providers in a given location. You can pull these data in R if you know either the latitude/longitude coordinates, the zipcode, or the county FIPS code of the location of interest and the time period of data you wish to pull from. The FCC currently provides access to the following periods:

| Label  | Period |
| ------------- | ------------- |
| jun2011  | June, 2011  |
| dec2011  | December, 2011  |
| jun2012  | June, 2012  |
| dec2012  | December, 2012  |
| jun2013  | June, 2013  |
| dec2013  | December, 2013  |
| jun2014  | June, 2014  |

To collect the providers in an area if you know the latitude and longitude, you can call:
```r
getProviders(lat = 39.958520, lon = -75.198857, time = "jun2014")
```

Instead, if you know the zipcode of the location, you can provide it directly:
```r
getProviders(zip = "19104", time = "jun2014")
```

And, if you know the FIPS code of the county:
```r
getProviders(fips = 42101, time = "jun2014")
```
