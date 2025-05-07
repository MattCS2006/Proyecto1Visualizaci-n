# Cargar librerías necesarias
library(dplyr)
library(tidyr)
library(plotly)

# Filtrar y preparar el dataset para PIB per cápita y esperanza de vida en 2022
vida_pib_2022 <- data_long %>%
  filter(`Series Name` %in% c("GDP per capita (current US$)",
                              "Life expectancy at birth, total (years)"),
         Año == 2022,
         !is.na(Valor)) %>%
  select(`Country Name`, `Series Name`, Valor) %>%
  pivot_wider(names_from = `Series Name`, values_from = Valor) %>%
  rename(
    País = `Country Name`,
    PIB_per_capita = `GDP per capita (current US$)`,
    Esperanza_vida = `Life expectancy at birth, total (years)`
  ) %>%
  filter(!is.na(PIB_per_capita), !is.na(Esperanza_vida))

# Crear el scatterplot interactivo
plot_ly(
  data = vida_pib_2022,
  x = ~PIB_per_capita,
  y = ~Esperanza_vida,
  type = 'scatter',
  mode = 'markers',
  text = ~paste("País:", País,
                "<br>PIB per cápita: $", round(PIB_per_capita, 0),
                "<br>Esperanza de vida:", round(Esperanza_vida, 1), "años"),
  marker = list(size = 10, color = 'blue', opacity = 0.7)
) %>%
  layout(
    title = "Relación entre PIB per cápita y Esperanza de vida (2022)",
    xaxis = list(title = "PIB per cápita (US$)", type = "log"),
    yaxis = list(title = "Esperanza de vida (años)")
  )
