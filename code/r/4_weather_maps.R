# R Script: Canton weather data preparation
# Laboratorio de Investigación para el Desarrollo del Ecuador 
# Inputs: 1_weather_data_download.R, 2_shapefiles_download.R, 3_canton_weather_data_prepare.R
# Outputs: none
# Description: This script visualizes weather data in maps for Ecuador. 

# ========================== Data visualization ============================================================

# As an example, we show how to compute average maximum, minimum and precipitation values for
# cantons in Ecuador using raster data and shapefiles.

# Preliminaries ----------------------------------------------------------------

# Download and install required packages if not already installed

if (!require(sf)) install.packages("sf")
if (!require(terra)) install.packages("terra")
if (!require(dplyr)) install.packages("dplyr")
if (!require(rnaturalearth)) install.packages("rnaturalearth")
if (!require(rnaturalearthdata)) install.packages("rnaturalearthdata")

# Load libraries

library(sf, warn.conflicts = F)
library(terra, warn.conflicts = F)
library(dplyr, warn.conflicts = F)
library(rnaturalearth, warn.conflicts = T)
library(rnaturalearthdata, warn.conflicts = T)

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

# Extract the world map from rnaturalearth

world <- ne_countries(scale = "medium", returnclass = "sf")

# Reproject the world map to match the raster's CRS

world <- st_transform(world, crs(tmax_2023))

# Computation of averages for Ecuador ---------------------------------------

# Rotate the raster, then crop it to the canton shapefile and compute the mean

mean_tmax_ecu <- 
    tmax_2023 %>% 
    rotate() %>% 
    crop(canton_shp, mask = T) %>% 
    app(mean)

mean_tmin_ecu <- 
    tmin_2023 %>%
    rotate() %>% 
    crop(canton_shp, mask = T) %>% 
    app(mean)

mean_precip_ecu <- 
    precip_2023 %>%
    rotate() %>% 
    crop(canton_shp, mask = T) %>% 
    app(mean)

# Plotting ----------------------------------------------------------------

layout(matrix(c(1,1,2,2,0,3,3,0),nrow = 2, ncol = 4, byrow = TRUE))

# Maximum temperature

plot(mean_tmax_ecu, main = "Average Maximum Temperature (°C)", axes = T, col = terrain.colors(100), legend = T)
plot(canton_shp$geometry, add = T)

# Minimum temperature

plot(mean_tmin_ecu, main = "Average Minimum Temperature (°C)", axes = T, col = terrain.colors(100), legend = T)
plot(canton_shp$geometry, add = T)

# Precipitation

plot(mean_precip_ecu, main = "Average Precipitation (mm)", axes = T, col = terrain.colors(100), legend = T)
plot(canton_shp$geometry, add = T)

# Also can calculate mean values for the whole map (the world) and plot it

mean_tmax_world <- 
    tmax_2023 %>% 
    rotate() %>%
    crop(world, mask = T) %>%
    app(mean)

# Change the layout to plot the world map (only one plot in the layout)

layout(matrix(1, nrow = 1, ncol = 1))

plot(mean_tmax_world, main = "Average Maximum Temperature (°C)", axes = T, col = terrain.colors(100), legend = T)

plot(world$geometry, add = T)

# Export the plots

dev.copy(png, "img/weather_maps/average_max_temp_ecu.png")