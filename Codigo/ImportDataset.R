# Cargar librerías necesarias
library(readr)
library(dplyr)
library(tidyr)
library(plotly)

# Leer correctamente el archivo descargado desde WDI
# IMPORTANTE:NO haberlo editado en Excel
WB_WDI <- read_csv("C:/Users/Usuario I 2025/Downloads/WB_WDI.csv", skip = 4)#AQUÍ YO LO HICE MANUALMENTE
#DELE IMPORT DATASET, Y EN SKIP 4

# Verificar las primeras filas
print(head(WB_WDI, 3))  # Solo imprime las 3 primeras filas

# Verificar nombres de columnas
print(colnames(WB_WDI))
#EL PROBLEMA ESQ NO LO ESTA LEYENDO BIEN