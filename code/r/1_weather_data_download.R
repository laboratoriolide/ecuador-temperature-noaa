# R Script: Ecuador NOAA Data Download
# Laboratorio de Investigación para el Desarrollo del Ecuador 
# Description: This script downloads NOAA data for Ecuador.
# Inputs: None
# Outputs: NetCDF files with temperature and precipitation data @data/weather/raw

# Preliminaries ----------------------------------------------------------------

# Download and install required packages if not already installed

if (!require(dplyr)) install.packages("dplyr")

# Load libraries

library(dplyr)

# Set a larger timeout option

options(timeout = 300)

# Data download -----------------------------------------------------------

## Temperature data --------------------------------------------------------

# Obtain the URLs for the max temperature data

max_temperature_urls <- c(
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmax.2024.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmax.2023.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmax.2022.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmax.2021.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmax.2020.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmax.2019.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmax.2018.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmax.2017.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmax.2016.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmax.2015.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmax.2014.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmax.2013.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmax.2012.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmax.2011.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmax.2010.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmax.2009.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmax.2008.nc"
)

# Obtain the URLs for the min temperature data

min_temperature_urls <- c(
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmin.2024.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmin.2023.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmin.2022.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmin.2021.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmin.2020.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmin.2019.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmin.2018.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmin.2017.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmin.2016.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmin.2015.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmin.2014.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmin.2013.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmin.2012.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmin.2011.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmin.2010.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmin.2009.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_temp/tmin.2008.nc"
)

## Precipation (rain) data -----------------------------------------------------

precip_urls <- c(
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_precip/precip.2024.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_precip/precip.2023.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_precip/precip.2022.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_precip/precip.2021.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_precip/precip.2020.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_precip/precip.2019.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_precip/precip.2018.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_precip/precip.2017.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_precip/precip.2016.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_precip/precip.2015.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_precip/precip.2014.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_precip/precip.2013.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_precip/precip.2012.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_precip/precip.2011.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_precip/precip.2010.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_precip/precip.2009.nc",
  "https://downloads.psl.noaa.gov//Datasets/cpc_global_precip/precip.2008.nc"
)

## Data download ------------------------------------

# File path definition

max_temp_paths <- file.path("data/weather/raw/tempmax", basename(max_temperature_urls))

min_temp_paths <- file.path("data/weather/raw/tempmin", basename(min_temperature_urls))

precip_paths <- file.path("data/weather/raw/precip", basename(precip_urls))

# Download the files

mapply(download.file, max_temperature_urls, max_temp_paths, MoreArgs = list(mode = "wb"))

mapply(download.file, min_temperature_urls, min_temp_paths, MoreArgs = list(mode = "wb"))

mapply(download.file, precip_urls, precip_paths, MoreArgs = list(mode = "wb"))
