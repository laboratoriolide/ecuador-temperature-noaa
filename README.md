# Datos de Temperatura del Ecuador del NOAA

Este repositorio contiene los códigos necesarios para extraer los datos de temperatura diaria para Ecuador del Physical Sciences Laboratory del [National Oceanic and Atmospheric Administration (NOAA)](https://www.noaa.gov/), una agencia del gobierno de los Estados Unidos. Los datos se pueden descargar en un formato NetCDF (`.nc`) [aquí](https://psl.noaa.gov/data/gridded/data.cpc.globaltemp.html).

Se utiliza R para procesar los archivos `.nc` y obtener los datos de temperatura diaria para diferentes agregaciones geográficas del país, procesando la información geoespacial a un formato rectangular, amigable con sistemas de bases de datos relacionales. El algoritmo de procesamiento se basa en el trabajo de [Quijano-Ruiz (2023)](https://github.com/aquijanoruiz/Weather_HealthPerception).

# NOAA Ecuador Temperature Data

This repository contains the necessary code to extract daily temperature data for Ecuador from the Physical Sciences Laboratory of the [National Oceanic and Atmospheric Administration (NOAA)](https://www.noaa.gov/), an agency of the United States government. The data can be downloaded in NetCDF format (`.nc`) [here](https://psl.noaa.gov/data/gridded/data.cpc.globaltemp.html).

R is used to process the `.nc` files and obtain daily temperature data for different geographical aggregations of the country, processing the geospatial information into a rectangular format, friendly with relational database systems. The processing algorithm is based on the work of [Quijano-Ruiz (2023)](https://github.com/aquijanoruiz/Weather_HealthPerception).