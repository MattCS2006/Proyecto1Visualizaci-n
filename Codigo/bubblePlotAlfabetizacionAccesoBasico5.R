library(tidyverse)
library(ggplot2)

# Columnas: Alfabetizacion, Acceso_agua, Poblacion, Region
data_2022 <- WB_WDI %>% filter(Year == 2022)

ggplot(data_2022, aes(x = Alfabetizacion, y = Acceso_agua, size = Poblacion, color = Region)) +
  geom_point(alpha = 0.7) +
  labs(title = "Tasa de alfabetización vs Acceso a servicios básicos (2022)",
       x = "Tasa de alfabetización (%)", y = "Acceso al agua básica (%)")