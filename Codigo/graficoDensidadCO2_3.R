library(tidyverse)

#columnas: 'CO2_per_capita' y 'Year'
data_co2 <- WB_WDI %>% filter(Year == 2022)

ggplot(data_co2, aes(x = CO2_per_capita)) +
  geom_density(fill = 'salmon', alpha = 0.6) +
  labs(title = "Densidad de emisiones de CO2 per cápita (2022)",
       x = "CO2 per cápita (toneladas)", y = "Densidad")