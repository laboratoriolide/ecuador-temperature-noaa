# Datos de Temperatura del Ecuador del NOAA

Este repositorio contiene el código necesario para descargar y procesar los datos diarios de temperatura para Ecuador del Physical Sciences Laboratory del [National Oceanic and Atmospheric Administration (NOAA)](https://www.noaa.gov/), una agencia del gobierno de los Estados Unidos. Los datos sin procesar se pueden descargar en un formato NetCDF (`.nc`) [desde aquí](https://psl.noaa.gov/data/gridded/data.cpc.globaltemp.html). El código prepara datos diarios para diferentes agregaciones, incluyendo cantones y parroquias del país.  

Se utiliza R para procesar los archivos `.nc` y obtener los datos de temperatura diaria, procesando la información geoespacial a un formato rectangular, amigable con sistemas de bases de datos relacionales. El algoritmo de procesamiento se basa en el trabajo de [Quijano-Ruiz (2023)](https://github.com/aquijanoruiz/Weather_HealthPerception).

# NOAA Ecuador Temperature Data

This repository contains code to download and process daily temperature data for Ecuador from the Physical Sciences Laboratory of the [National Oceanic and Atmospheric Administration (NOAA)](https://www.noaa.gov/), an agency of the United States government. The data can be downloaded in NetCDF format (`.nc`) [here](https://psl.noaa.gov/data/gridded/data.cpc.globaltemp.html). The code prepares daily data for different aggregations, including cantons and parishes of the country.

R is used to process the `.nc` files and obtain daily temperature data, processing the geospatial information into a rectangular format, friendly with relational database systems. The processing algorithm is based on the work of [Quijano-Ruiz (2023)](https://github.com/aquijanoruiz/Weather_HealthPerception).

## Referencias / References

Quijano-Ruiz, A. (2023). [Assessing the Reliability of Self-rated Health: The effects of Transient Weather Fluctuations on Perceived Health](https://github.com/aquijanoruiz/Weather_HealthPerception). [Working Paper].