# Asegurarse de tener plotly instalado
# install.packages("plotly")

library(dplyr)
library(plotly)

# Filtrar el indicador de PIB per cápita para 2022
gdp_2022 <- data_long %>%
  filter(`Series Name` == "GDP per capita (current US$)",
         Año == 2022,
         !is.na(Valor))

# Crear histograma interactivo
plot_ly(gdp_2022,
        x = ~Valor,
        type = "histogram",
        nbinsx = 30,
        marker = list(color = "steelblue")) %>%
  layout(
    title = "Distribución del PIB per cápita (2022)",
    xaxis = list(title = "PIB per cápita (USD)"),
    yaxis = list(title = "Cantidad de países"),
    bargap = 0.05
  )
