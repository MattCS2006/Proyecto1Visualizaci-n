library(tidyverse)

# columnas: 'Region', 'Esperanza_vida' y 'Year'
data_vida <- WB_WDI %>% filter(Year == 2022)

ggplot(data_vida, aes(x = Region, y = Esperanza_vida)) +
  geom_boxplot(fill = 'lightgreen') +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Esperanza de vida al nacer por región (2022)",
       x = "Región", y = "Esperanza de vida")