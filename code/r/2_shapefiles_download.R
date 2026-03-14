# R Script: Ecuador Map Shapefiles Download
# Laboratorio de Investigación para el Desarrollo del Ecuador 
# Description: This script downloads the map shapefiles for Ecuador.
# Source: INEC (https://www.ecuadorencifras.gob.ec/documentos/web-inec/Geografia_Estadistica/Micrositio_geoportal/index.html)
# Inputs: None
# Outputs: Shapefiles for Ecuador @data/shp/ecuador_shapefiles

# Preliminaries ----------------------------------------------------------------

# Downloading the files ---------------------------------------------------------

# Declare download URLs

shapefile_url <- "https://www.ecuadorencifras.gob.ec//documentos/web-inec/Cartografia/Clasificador_Geografico/2012/SHP.zip"

metadata_url <- "https://www.ecuadorencifras.gob.ec//documentos/web-inec/Cartografia/Clasificador_Geografico/2012/LISTADOS.zip"

# Download the zip file containing the shapefiles

download.file(shapefile_url, "data/shp/ecuador_shapefiles.zip")

# Download the zip file containing metadata and DPA (División Política Administrativa) metadata

download.file(metadata_url, "data/shp/ecuador_dpa_metadata.zip")

# Unzip the files --------------------------------------------------------------

# Unzip the shapefiles

unzip("data/shp/ecuador_shapefiles.zip", exdir = "data/shp/ecuador_shapefiles")

# Unzip the metadata

unzip("data/shp/ecuador_dpa_metadata.zip", exdir = "data/shp/ecuador_dpa_metadata")

# Delete unnecessary files ------------------------------------------------------


file.remove("data/shp/ecuador_shapefiles.zip")

file.remove("data/shp/ecuador_dpa_metadata.zip")

