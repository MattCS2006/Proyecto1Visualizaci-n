library(tidyverse)
library(plotly)

#'PIB_per_capita' y 'Country'
# Filtrado del año 2022
data_2022 <- WB_WDI %>% filter(Year == 2022)

p <- ggplot(data_2022, aes(x = PIB_per_capita)) +
  geom_histogram(bins = 30, fill = 'skyblue', color = 'white') +
  labs(title = "Distribución del PIB per cápita (2022)",
       x = "PIB per cápita (USD)", y = "Frecuencia")

ggplotly(p)
