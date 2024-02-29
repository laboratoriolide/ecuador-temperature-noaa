# R Script: Canton weather data preparation
# Laboratorio de Investigación para el Desarrollo del Ecuador 

# This script prepares daily weather data at the canton level for Ecuador.

# Preliminaries ----------------------------------------------------------------

# Download and install required packages if not already installed

if (!require(dplyr)) install.packages("dplyr")
if (!require(sf)) install.packages("sf")
if (!require(terra)) install.packages("terra")
if (!require(haven)) install.packages("haven")
if (!require(janitor)) install.packages("janitor")

# Load libraries

library(dplyr)
library(sf)
library(terra)
library(janitor)
library(haven)

# Loading shapefile -----------------------------------------------------------

# Load the Ecuador map shapefile to extract the canton identifiers

canton_shp <- 
    st_read("data/shp/ecuador_shapefiles/SHP/nxcantones.shp")  %>% 
    st_simplify(preserveTopology = T, dTolerance = 100) 

# Select the canton identifier and gemoetry (kept by default by the sf class)

canton_ids <-
    canton_shp %>% 
    clean_names() %>% 
    select(canton_id = dpa_canton)

# Function to extract daily weather data ---------------------------------------

# Create a function to extract daily weather data for any given NetCDF file
# The argument is the path to the NetCDF file

extract_min_temp_data <- function(x){
    # Load the NetCDF file and reproject the SpatRaster to standard coordinates between -180 and 180 degrees
    x <- rast(x) %>% rotate()
    
    # Reproject the canton shapefile to the same coordinate system as the NetCDF file
    canton_ids <- 
        st_transform(canton_ids, crs(x))
    
    # Mask the SpatRaster using the shapefile
    x <- crop(x, canton_ids, mask = T)

    # Extract the time and layer dimensions from the SpatRaster
    time <- time(x)
    names <- names(x)

    # Extract the weighted mean temperature for each canton
    x <- extract(x, canton_ids, fun = mean, na.rm = T, weights = T, bind = T)

    # Transform the SpatRaster to a tibble

    x <- as_tibble(x)
  
    return(x)
}

# Applying the function to the NetCDF files ------------------------------------

# 