# Cargar librerías necesarias
library(dplyr)
library(plotly)

# Filtrar el dataset para emisiones de CO2 per cápita en 2022
co2_2022 <- data_long %>%
  filter(`Series Name` == "Carbon dioxide (CO2) emissions excluding LULUCF per capita (t CO2e/capita)",
         Año == 2022,
         !is.na(Valor))

# Crear gráfico de densidad interactivo
print(
  plot_ly(type = "scatter", mode = "lines") %>%
    add_trace(
      x = density(co2_2022$Valor)$x,
      y = density(co2_2022$Valor)$y,
      fill = "tozeroy",
      fillcolor = "rgba(255, 127, 14, 0.5)",
      line = list(color = "orange"),
      name = "Densidad"
    ) %>%
    layout(
      title = "Distribución de emisiones de CO₂ per cápita (2022)",
      xaxis = list(title = "Emisiones per cápita (toneladas)"),
      yaxis = list(title = "Densidad estimada"),
      showlegend = FALSE
    )
)
