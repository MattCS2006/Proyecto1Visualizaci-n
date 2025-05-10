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

#Carga agregados para graficas futuras.
agregados <- c(
  "Africa Eastern and Southern", "Africa Western and Central", "Arab World", "Caribbean small states",
  "Central Europe and the Baltics", "Early-demographic dividend", "East Asia & Pacific",
  "East Asia & Pacific (excluding high income)", "East Asia & Pacific (IDA & IBRD countries)",
  "Euro area", "Europe & Central Asia", "Europe & Central Asia (excluding high income)",
  "Europe & Central Asia (IDA & IBRD countries)", "European Union",
  "Fragile and conflict affected situations", "Heavily indebted poor countries (HIPC)",
  "High income", "IBRD only", "IDA & IBRD total", "IDA blend", "IDA only", "IDA total",
  "Late-demographic dividend", "Latin America & Caribbean", "Latin America & Caribbean (excluding high income)",
  "Latin America & the Caribbean (IDA & IBRD countries)", "Least developed countries: UN classification",
  "Low & middle income", "Low income", "Lower middle income", "Middle East & North Africa",
  "Middle East & North Africa (excluding high income)", "Middle East & North Africa (IDA & IBRD countries)",
  "Middle income", "North America", "Not classified", "OECD members", "Other small states",
  "Pacific island small states", "Post-demographic dividend", "Pre-demographic dividend", "Small states",
  "South Asia", "South Asia (IDA & IBRD)", "Sub-Saharan Africa", "Sub-Saharan Africa (excluding high income)",
  "Sub-Saharan Africa (IDA & IBRD countries)", "Upper middle income", "World"
)

#Guarda paises centroamericanos especificamente para la grafica compuesta.
paises_centroamerica <- c("Costa Rica", "Nicaragua", "Panama", "Guatemala", "Honduras", "El Salvador")
