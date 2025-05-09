# Cargar librerías
library(tidyverse)
library(patchwork)
library(plotly)

# Filtrar los datos necesarios
paises_centroamerica <- c("Costa Rica", "Nicaragua", "Panama", "Guatemala", "Honduras", "El Salvador")

data_centroamerica <- data_long %>%
  filter(`Country Name` %in% paises_centroamerica,
         `Series Name` == "GDP per capita (current US$)",
         Año >= 2000)

# Gráfico 1: Líneas
g1 <- ggplot(data_centroamerica, aes(x = Año, y = Valor, color = `Country Name`)) +
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  labs(title = "Evolución del PIB per cápita (2000–2022)",
       x = "Año", y = "PIB per cápita (US$)", color = "País") +
  theme_minimal()

g1_int <- ggplotly(g1)

# Gráfico 2: Boxplot
g2 <- ggplot(data_centroamerica, aes(x = `Country Name`, y = Valor, fill = `Country Name`)) +
  geom_boxplot() +
  labs(title = "Distribución del PIB per cápita (2000–2022)",
       x = "País", y = "PIB per cápita (US$)") +
  theme_minimal() +
  theme(legend.position = "none")

g2_int <- ggplotly(g2)

# Gráfico 3: Heatmap
g3 <- ggplot(data_centroamerica, aes(x = Año, y = fct_rev(`Country Name`), fill = Valor)) +
  geom_tile(color = "white") +
  scale_fill_viridis_c(option = "plasma") +
  labs(title = "Mapa de calor del PIB per cápita",
       x = "Año", y = "País", fill = "PIB per cápita") +
  theme_minimal()

g3_int <- ggplotly(g3)

# Gráfico 4: Barras para 2022
data_2022 <- data_centroamerica %>% filter(Año == 2022)

g4 <- ggplot(data_2022, aes(x = reorder(`Country Name`, -Valor), y = Valor, fill = `Country Name`)) +
  geom_bar(stat = "identity") +
  labs(title = "PIB per cápita en Centroamérica (2022)",
       x = "País", y = "PIB per cápita (US$)") +
  theme_minimal() +
  theme(legend.position = "none")

g4_int <- ggplotly(g4)

# Combinar con subplot (2 filas, 2 columnas)
subplot(
  g1_int, g2_int,
  g3_int, g4_int,
  nrows = 2,
  margin = 0.05,
  titleX = TRUE,
  titleY = TRUE
)
