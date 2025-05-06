library(plotly)

# Columnas: PIB_per_capita, CO2_per_capita, Esperanza_vida, Region, Poblacion
data_2022 <- WB_WDI %>% filter(Year == 2022)

plot_ly(data_2022, x = ~PIB_per_capita, y = ~CO2_per_capita, z = ~Esperanza_vida,
        color = ~Region, size = ~Poblacion, text = ~Country, type = "scatter3d", mode = "markers") %>%
  layout(title = "3D: PIB, CO2 y Esperanza de vida")
