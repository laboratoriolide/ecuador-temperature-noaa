# R Script: Canton weather data preparation
# Laboratorio de Investigación para el Desarrollo del Ecuador 

# This script prepares daily weather data at the canton level for Ecuador.

# Preliminaries ----------------------------------------------------------------

# Download and install required packages if not already installed

if (!require(dplyr)) install.packages("dplyr")
if (!require(sf)) install.packages("sf")
if (!require(terra)) install.packages("terra")
if (!require(haven)) install.packages("haven")

# Load libraries

library(dplyr)
library(sf)
library(terra)
library(haven)

# Loading shapefile -----------------------------------------------------------

# Load the Ecuador map shapefile to extract the canton identifiers.
# Source: INEC (https://www.ecuadorencifras.gob.ec/documentos/web-inec/Geografia_Estadistica/Micrositio_geoportal/index.html)
