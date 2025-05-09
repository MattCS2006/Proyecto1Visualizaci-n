library(dplyr)
library(plotly)
library(countrycode)

# Paso 1: Filtrar solo países (excluir agregados)
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

