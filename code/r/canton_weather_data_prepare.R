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

# Extracting daily canton max temperature --------------------------------------------------------------

canton_tmax_2018 <- 
    rast("data/weather/raw/tempmax/tmax.2018.nc")  %>% 
    rotate()

canton_ids <-
    st_transform(canton_ids, crs(canton_tmax_2018))

canton_tmax_2018 <-
    crop(canton_tmax_2018, canton_ids, mask = T)

names <- names(canton_tmax_2018)
time <- time(canton_tmax_2018)

canton_tmax_2018 <- extract(canton_tmax_2018, canton_ids, fun = mean, na.rm = T, weights = T, bind = T)

canton_tmax_2018 <- as_tibble(canton_tmax_2018)

names(canton_tmax_2018)[names(canton_tmax_2018) %in% names] <- as.character(as.Date(time))

# Compute an average temperature for each canton, for all days in 2018

canton_tmax_2018$tmax_mean <- rowMeans(canton_tmax_2018[,2:ncol(canton_tmax_2018)])
canton_tmax_2018 <- select(canton_tmax_2018, canton_id, tmax_mean)