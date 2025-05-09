# Cargar librerías
library(dplyr)
library(ggplot2)
library(countrycode)
library(plotly)

# Vector de países agregados (los que no queremos en el análisis)
agregados <- c(
  "Africa Eastern and Southern", "Africa Western and Central", "Arab World", "Caribbean small states",
  "Central Europe and the Baltics", "East Asia & Pacific",
  "East Asia & Pacific (excluding high income)", "East Asia & Pacific (IDA & IBRD countries)",
  "Euro area", "Europe & Central Asia", "Europe & Central Asia (excluding high income)",
  "Europe & Central Asia (IDA & IBRD countries)", "European Union", "Latin America & Caribbean", "Latin America & Caribbean (excluding high income)",
  "Latin America & the Caribbean (IDA & IBRD countries)", "Middle East & North Africa",
  "Middle East & North Africa (excluding high income)", "Middle East & North Africa (IDA & IBRD countries)",
  "North America", "South Asia", "South Asia (IDA & IBRD)", "Sub-Saharan Africa", "Sub-Saharan Africa (excluding high income)",
  "Sub-Saharan Africa (IDA & IBRD countries)", "Upper middle income", "World",
  "Early-demographic dividend", "Fragile and conflict affected situations", "Heavily indebted poor countries (HIPC)",
  "High income", "IBRD only", "IDA & IBRD total", "IDA blend", "IDA only", "IDA total",
  "Late-demographic dividend", "Least developed countries: UN classification",
  "Low & middle income", "Low income", "Lower middle income", "Middle income", "OECD members",
  "Other small states", "Pacific island small states", "Post-demographic dividend", "Pre-demographic dividend",
  "Small states"
)

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
