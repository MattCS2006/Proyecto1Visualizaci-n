# Cargar librerías necesarias
library(dplyr)
library(tidyr)
library(plotly)

# Filtrar y preparar el dataset para alfabetización, acceso a agua y población en 2022
alfabetizacion_agua_poblacion_2022 <- data_long %>%
  filter(`Series Name` %in% c("Literacy rate, adult total (% of people ages 15 and above)",
                              "People using at least basic drinking water services (% of population)",
                              "Population, total"),
         Año == 2022,
         !is.na(Valor)) %>%
  select(`Country Name`, `Series Name`, Valor) %>%
  pivot_wider(names_from = `Series Name`, values_from = Valor) %>%
  rename(
    País = `Country Name`,
    Alfabetizacion = `Literacy rate, adult total (% of people ages 15 and above)`,
    Acceso_agua = `People using at least basic drinking water services (% of population)`,
    Poblacion = `Population, total`
  ) %>%
  filter(!is.na(Alfabetizacion), !is.na(Acceso_agua), !is.na(Poblacion))

# Crear el bubble plot interactivo
plot_ly(
  data = alfabetizacion_agua_poblacion_2022,
  x = ~Alfabetizacion,
  y = ~Acceso_agua,
  size = ~Poblacion,
  type = 'scatter',
  mode = 'markers',
  text = ~paste("País:", País,
                "<br>Alfabetización:", round(Alfabetizacion, 1), "%",
                "<br>Acceso a agua:", round(Acceso_agua, 1), "%",
                "<br>Población:", round(Poblacion, 0)),
  marker = list(opacity = 0.5),
  sizes = c(10, 100)
) %>%
  layout(
    title = "Relación entre Alfabetización, Acceso a agua y Población (2022)",
    xaxis = list(title = "Alfabetización (% de adultos)"),
    yaxis = list(title = "Acceso a agua básica (% de población)"),
    showlegend = FALSE
  )