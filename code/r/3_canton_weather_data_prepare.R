# R Script: Canton weather data preparation
# Laboratorio de Investigación para el Desarrollo del Ecuador 
# Description: This script prepares daily weather data at the canton level for Ecuador.
# Inputs: 1_weather_data_download.R, 2_shapefiles_download.R
# Outputs: data/weather/processed/min_temperature.csv, data/weather/processed/max_temperature.csv, data/weather/processed/precipitation.csv

# Preliminaries ----------------------------------------------------------------

# Download and install required packages if not already installed

if (!require(dplyr)) install.packages("dplyr")
if (!require(sf)) install.packages("sf")
if (!require(terra)) install.packages("terra")
if (!require(haven)) install.packages("haven")
if (!require(janitor)) install.packages("janitor")
if(!require(stringr)) install.packages("stringr")
if(!require(tidyr)) install.packages("tidyr")
if(!require(lubridate)) install.packages("lubridate")
if(!require(readr)) install.packages("readr")

# Load libraries

library(dplyr)
library(sf)
library(terra)
library(janitor)
library(haven)
library(stringr)
library(readr)
library(tidyr)
library(lubridate)

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

extract_weather_data <- function(x){
    # Load the NetCDF file and reproject the SpatRaster to standard coordinates between -180 and 180 degrees
    x <- rast(x) %>% rotate()
    
    # Reproject the canton shapefile to the same coordinate system as the NetCDF file
    canton_ids <- st_transform(canton_ids, crs(x))
    
    # Mask the SpatRaster using the shapefile
    x <- crop(x, canton_ids, mask = T)

    # Extract the time and layer dimensions from the SpatRaster
    time <- time(x)
    names <- names(x)

    # Extract the weighted mean temperature for each canton
    x <- terra::extract(x, canton_ids, fun = mean, na.rm = T, weights = T, bind = T)

    # Transform the SpatRaster to a tibble

    x <- as_tibble(x)

    # Rename the columns to show the dates

    names(x)[names(x) %in% names] <- as.character(as.Date(time))

    # Pivot the tibble to long format and add a new column for the year

    x <- 
        pivot_longer(x, cols = -canton_id, names_to = "date", values_to = "value", names_transform = list(date = as.Date))  %>% 
        mutate(year = year(date))

    return(x)
}

# Applying the function to the NetCDF files ------------------------------------

# Getting the path to the the nc files for the minimum temperature, maximum temperature, and precipitation

min_temperature_files <- list.files("data/weather/raw/tempmin",full.names = T)
max_temperature_files <- list.files("data/weather/raw/tempmax",full.names = T)
precipitation_files <- list.files("data/weather/raw/precip",full.names = T)

# List apply the function to the NetCDF files for the minimum temperature, maximum temperature, and precipitation

min_temperature_data <- lapply(min_temperature_files, extract_weather_data)

min_temperature_df <- bind_rows(min_temperature_data)

max_temperature_data <- lapply(max_temperature_files, extract_weather_data)

max_temperature_df <- bind_rows(max_temperature_data)

precipitation_data <- lapply(precipitation_files, extract_weather_data)

precipitation_df <- bind_rows(precipitation_data)

# Exporting the data ------------------------------------------------------------

# Export all data to different csv files

write_csv(min_temperature_df, "data/weather/processed/min_temperature.csv")

write_csv(max_temperature_df, "data/weather/processed/max_temperature.csv")

write_csv(precipitation_df, "data/weather/processed/precipitation.csv")

