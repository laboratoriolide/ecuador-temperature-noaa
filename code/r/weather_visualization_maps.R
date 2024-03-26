# R Script: Canton weather data preparation
# Laboratorio de Investigación para el Desarrollo del Ecuador 

# This script visualizes weather data in maps for Ecuador. 
# As an example, we show how to compute average maximum, minimum and precipitation values for
# cantons in Ecuador using raster data and shapefiles.

# Preliminaries ----------------------------------------------------------------

# Download and install required packages if not already installed

if (!require(sf)) install.packages("sf")
if (!require(terra)) install.packages("terra")
if (!require(dplyr)) install.packages("dplyr")

# Load libraries

library(sf, warn.conflicts = F)
library(terra, warn.conflicts = F)
library(dplyr, warn.conflicts = F)

# Load data -----------------------------------------------------------

# Maximum temperature 

tmax_2023 <- rast("data/weather/raw/tempmax/tmax.2023.nc")

# Minimum temperature

tmin_2023 <- rast("data/weather/raw/tempmin/tmin.2023.nc")

# Precipitation

precip_2023 <- rast("data/weather/raw/precip/precip.2023.nc")

# Canton shapefile 

canton_shp <- 
    st_read("data/shp/ecuador_shapefiles/SHP/nxcantones.shp")  %>% 
    st_simplify(preserveTopology = T, dTolerance = 100) %>% 
    rename(prov_id = DPA_PROVIN) %>% 
    filter(!prov_id %in% "20") # Filter out Galápagos Islands since there are no relevant data for these canton

# Reproject the canton shapefile to match the raster's CRS

canton_shp <- st_transform(canton_shp, crs(tmax_2023))

# Computation of averages  ---------------------------------------

tmax <- tmax_2023 %>% 
    rotate() %>% 
    crop(canton_shp, mask = T) %>% 
    app(mean)

tmin <- tmin_2023 %>%
    rotate() %>% 
    crop(canton_shp, mask = T) %>% 
    app(mean)

precip <- precip_2023 %>%
    rotate() %>% 
    crop(canton_shp, mask = T) %>% 
    app(mean)

# Plotting ----------------------------------------------------------------

layout(matrix(c(1,1,2,2,0,3,3,0),nrow = 2, ncol = 4, byrow = TRUE))

# Maximum temperature

plot(tmax, main = "Average Maximum Temperature (°C)", axes = T, col = terrain.colors(100), legend = T)
plot(canton_shp$geometry, add = T)

# Minimum temperature

plot(tmin, main = "Average Minimum Temperature (°C)", axes = T, col = terrain.colors(100), legend = T)
plot(canton_shp$geometry, add = T)

# Precipitation

plot(precip, main = "Average Precipitation (mm)", axes = T, col = terrain.colors(100), legend = T)
plot(canton_shp$geometry, add = T)