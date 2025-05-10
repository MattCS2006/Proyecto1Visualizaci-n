# Cargar librerías necesarias
library(dplyr)
library(plotly)
library(countrycode)

# Filtrar y preparar los datos de 2022
multidimensional_2022 <- data_long %>%
  filter(`Series Name` %in% c(
    "GDP per capita (current US$)",
    "Carbon dioxide (CO2) emissions excluding LULUCF per capita (t CO2e/capita)",
    "Life expectancy at birth, total (years)",
    "Population, total"
  ),
  Año == 2022,
  !`Country Name` %in% agregados,
  !is.na(Valor)) %>%
  select(`Country Name`, `Series Name`, Valor) %>%
  pivot_wider(names_from = `Series Name`, values_from = Valor) %>%
  rename(
    País = `Country Name`,
    PIB_per_capita = `GDP per capita (current US$)`,
    CO2_per_capita = `Carbon dioxide (CO2) emissions excluding LULUCF per capita (t CO2e/capita)`,
    Esperanza_vida = `Life expectancy at birth, total (years)`,
    Poblacion = `Population, total`
  ) %>%
  mutate(
    Region = countrycode(País, origin = "country.name", destination = "region")
  ) %>%
  filter(!is.na(PIB_per_capita), !is.na(CO2_per_capita),
         !is.na(Esperanza_vida), !is.na(Poblacion), !is.na(Region))

# Crear gráfico interactivo 3D
print(
  plot_ly(
    data = multidimensional_2022,
    x = ~PIB_per_capita,
    y = ~CO2_per_capita,
    z = ~Esperanza_vida,
    type = "scatter3d",
    mode = "markers",
    color = ~Region,
    colors = "Set2",
    size = ~Poblacion,
    sizes = c(5, 50),
    text = ~paste("País:", País,
                  "<br>Región:", Region,
                  "<br>PIB per cápita: $", round(PIB_per_capita, 0),
                  "<br>CO₂ per cápita:", round(CO2_per_capita, 2), "t",
                  "<br>Esperanza de vida:", round(Esperanza_vida, 1), "años",
                  "<br>Población:", format(Poblacion, big.mark = ",")),
    marker = list(opacity = 0.7)
  ) %>%
    layout(
      title = "Gráfico 3D: PIB per cápita, CO₂ per cápita y Esperanza de vida (2022)",
      scene = list(
        xaxis = list(title = "PIB per cápita (US$)"),
        yaxis = list(title = "CO₂ per cápita (t CO₂e)"),
        zaxis = list(title = "Esperanza de vida (años)")
      )
    )
)