# Cargar librerías
library(dplyr)
library(ggplot2)
library(countrycode)
library(plotly)

# Filtrar y transformar los datos
pib_por_region <- data_long %>%
  filter(`Series Name` == "GDP per capita (current US$)",
         Año >= 2000, Año <= 2022,
         !`Country Name` %in% agregados,
         !is.na(Valor)) %>%
  rename(País = `Country Name`, PIB_per_capita = Valor) %>%
  mutate(
    Region = countrycode(País, origin = "country.name", destination = "region")
  ) %>%
  filter(!is.na(Region))

# Crear gráfico con ggplot
p <- ggplot(pib_por_region, aes(x = Año, y = PIB_per_capita, group = País, text = País)) +
  geom_line(alpha = 0.5, color = "steelblue") +
  facet_wrap(~Region, scales = "free_y") +
  labs(
    title = "Evolución del PIB per cápita por región (2000–2022)",
    subtitle = "Cada línea representa un país.",
    x = "Año",
    y = "PIB per cápita (US$)"
  ) +
  theme_minimal() +
  theme(
    strip.text = element_text(face = "bold"),
    plot.title = element_text(size = 16, face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

# Convertir el gráfico en interactivo
print(
ggplotly(p, tooltip = "text")
)
