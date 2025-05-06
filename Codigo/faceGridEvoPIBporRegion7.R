library(tidyverse)

# Columnas: PIB_per_capita, Region, Year
ggplot(WB_WDI, aes(x = Year, y = PIB_per_capita)) +
  geom_line(aes(group = Country), alpha = 0.5) +
  facet_wrap(~Region) +
  labs(title = "Evolución del PIB per cápita (2000–2022)",
       x = "Año", y = "PIB per cápita (USD)")

