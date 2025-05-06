library(tidyverse)
library(plotly)

data_2022 <- WB_WDI %>% filter(Year == 2022)

p <- ggplot(data_2022, aes(x = PIB_per_capita, y = Esperanza_vida,
                           color = Region, text = Country)) +
  geom_point() +
  labs(title = "PIB per cápita vs. Esperanza de vida (2022)",
       x = "PIB per cápita (USD)", y = "Esperanza de vida")

ggplotly(p, tooltip = "text")
