library(dplyr)
library(plotly)
library(countrycode)

# Paso 2: Filtrar datos y asignar región
vida_2022 <- data_long %>%
  filter(`Series Name` == "Life expectancy at birth, total (years)",
         Año == 2022,
         !`Country Name` %in% agregados,
         !is.na(Valor)) %>%
  mutate(Region = countrycode(`Country Name`, origin = "country.name", destination = "region")) %>%
  filter(!is.na(Region))  # Por si hay países sin región asignable

# Paso 3: Boxplot interactivo
print(
  plot_ly(vida_2022,
          x = ~Region,
          y = ~Valor,
          type = "box",
          color = ~Region,
          colors = "Set2") %>%
    layout(
      title = "Esperanza de vida al nacer por región (2022)",
      xaxis = list(title = "Región"),
      yaxis = list(title = "Esperanza de vida (años)")
    )
)

