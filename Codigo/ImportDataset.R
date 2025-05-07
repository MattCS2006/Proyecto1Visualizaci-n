# Cargar librerías necesarias
library(readr)
library(dplyr)
library(tidyr)
library(stringr)  # <- Necesaria para str_extract

# Cargar el archivo
data <- read_csv("Data/Data.csv", na = c("..", "", "NA"))

# Vista rápida del dataset, esto es temporal 
glimpse(data)

# Transformar a formato largo
data_long <- data %>%
  pivot_longer(
    cols = matches("^\\d{4}"),  # columnas con nombres de años (2000, 2001, ...)
    names_to = "Año",
    values_to = "Valor"
  ) %>%
  mutate(
    Año = as.integer(str_extract(Año, "^\\d{4}"))  # extraer y convertir a entero directamente
  )
