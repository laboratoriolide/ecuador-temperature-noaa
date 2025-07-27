# Datos de Temperatura del Ecuador del NOAA

Este repositorio contiene el código necesario para descargar y procesar los datos diarios de temperatura para Ecuador del Physical Sciences Laboratory del [National Oceanic and Atmospheric Administration (NOAA)](https://www.noaa.gov/), una agencia del gobierno de los Estados Unidos. Los datos sin procesar se pueden descargar en un formato NetCDF (`.nc`) [desde aquí](https://psl.noaa.gov/data/gridded/data.cpc.globaltemp.html). El código prepara datos diarios al nivel de cantones y parroquias del país.  

Se utiliza R para procesar los archivos `.nc` y obtener los datos de temperatura diaria, procesando la información geoespacial a un formato rectangular, amigable con sistemas de bases de datos relacionales. El algoritmo de procesamiento se basa en el trabajo de [Quijano-Ruiz (2023)](https://github.com/aquijanoruiz/Weather_HealthPerception).

# NOAA Ecuador Temperature Data

This repository contains code to download and process daily temperature data for Ecuador from the Physical Sciences Laboratory of the [National Oceanic and Atmospheric Administration (NOAA)](https://www.noaa.gov/), an agency of the United States government. The data can be downloaded in NetCDF format (`.nc`) [here](https://psl.noaa.gov/data/gridded/data.cpc.globaltemp.html). The code prepares daily data at the canton level (second administrative level below province). 

R is used to process the `.nc` files and obtain daily temperature data, processing the geospatial information into a rectangular format, friendly with relational database systems. The processing algorithm is based on the work of [Quijano-Ruiz (2023)](https://github.com/aquijanoruiz/Weather_HealthPerception).

# Documentación / Documentation

1. [Requisitos / Requirements](#requisitos--requirements)

R y RStudio son necesarios para ejecutar el código. Se recomienta una conexión a internet estable para descargar los archivos `.nc` de NOAA asi como un computador con suficiente memoria RAM para procesar los datos (al menos 4GB). 

R and RStudio are required to run the code. A stable internet connection is recommended to download the NOAA `.nc` files as well as a computer with enough RAM to process the data (at least 4GB).

2. [Instrucciones / Instructions](#instrucciones--instructions)

El producto final del código son tres archivos `.csv` con los datos de temperatura y precipitación diaria para Ecuador. El primer archivo contiene datos de temperatura máxima, el segundo datos de temperatura mínima y el tercero datos de precipitación. Los archivos contienen información a nivel de cantón. 

El script de bash `ecuador-noaa.sh` ejecuta todos los script en orden, pero se recomienda ejecutar los scripts de R por separado para ahorrar tiempo en caso de errores o de tiempos de ejecución largos debido a la cantidad de datos del NOAA.

The final product of the code are three `.csv` files with daily temperature and precipitation data for Ecuador. The first file contains maximum temperature data, the second minimum temperature data, and the third precipitation data. The files contain information at the canton level.

The bash script `ecuador-noaa.sh` runs all the scripts in order, but it is recommended to run the R scripts separately to save time in case of errors or long execution times due to the amount of NOAA data.

3. Estructura del Repositorio / Repository Structure

-`code/`: Contiene scripts de R y bash para descargar y procesar los datos de temperatura.
    - `code/r/`
        -`code/r/1_weather_data_download.R`: Descarga los archivos `.nc` de NOAA. No es necesario ejecutar este script puesto que los archivos `.nc` ya están en el repositorio (ver `data/weather/raw/`).
        -`code/r/2_shapefiles_download.R`: Descarga los shapefiles de Ecuador.
        -`code/r/3_weather_data_processing.R`: Procesa los archivos `.nc` y los shapefiles de Ecuador.
        - `code/r/4_weather_maps.R`: Crea mapas de temperatura y precipitación.

- `data/`: Contiene datos procesados y sin procesar de shapefiles y datos climáticos.
    - `data/shp`
        - `ecuador_dpa_metadata/LISTADOS/`: Contiene metadatos de los Shapefiles de Ecuador.
        - `ecuador_shapefiles/`: Contiene los Shapefiles de Ecuador.
    - `data/weather`
        - `processed/`: Contiene los archivos `.csv` con los datos diarios de temperatura y precipitación procesados.
        - `raw/`: Contiene los archivos `.nc` descargados de NOAA.

## Referencias / References

Quijano-Ruiz, A. (2023). [Assessing the Reliability of Self-rated Health: The effects of Transient Weather Fluctuations on Perceived Health](https://github.com/aquijanoruiz/Weather_HealthPerception). [Working Paper].
