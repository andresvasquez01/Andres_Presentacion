# Instalar librerías
install.packages("readxl")      # Para leer archivos Excel
install.packages("ggplot2")     # Para gráficos
install.packages("dplyr")       # Para manipulación de datos
install.packages("tidyverse")   # Para el uso de pivot_longer()
install.packages("corrplot")  # Instalar solo si no lo tienes

# Cargar librerías
library(readxl)
library(ggplot2)
library(dplyr)
library(tidyverse)
library(corrplot)

# Cargar el dataset desde el archivo Excel
datos <- read_excel("Textil.xlsx")

# Ver la estructura de los datos
str(datos)

# Resumen estadístico de las variables numéricas
summary(datos)

# Relación entre desechos y ventas
ggplot(datos, aes(x = Ventas, y = Toneladas)) +
  geom_point(color = "red") +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  theme_minimal() +
  labs(title = "Relación entre Ventas y Desechos Textiles",
       x = "Ventas (miles de dólares)",
       y = "Toneladas de desechos")

# Transformar los datos al formato largo y graficar histogramas
datos %>%
  select_if(is.numeric) %>%
  pivot_longer(cols = everything(), names_to = "variable", values_to = "valor") %>%
  ggplot(aes(x = valor)) +
  geom_histogram(bins = 20, fill = "blue", alpha = 0.5) +
  facet_wrap(~variable, scales = "free") +
  theme_minimal() +
  labs(title = "Distribución de las Variables")
  
# Identificación de valores atípicos
ggplot(datos, aes(y = Ventas)) +
  geom_boxplot(fill = "lightblue", outlier.color = "red") +
  theme_minimal() +
  labs(title = "Boxplot de Ventas",
       y = "Ventas (miles de dólares)")

# Exploración de correlaciones entre variables clave
correlaciones <- datos %>%
  select_if(is.numeric) %>%
  cor(use = "complete.obs")

# Visualización de la matriz de correlaciones
corrplot(correlaciones, method = "color", type = "lower",
         tl.col = "black", tl.srt = 45, diag = FALSE)

#De esto podemos con cluir que es posible que las toneladas se
#reduscan si se disminulle el uso de materiales como el poliestre y
#se usa mas el algodon, pot oreo lado el uso eficiente de la energia
#como productividad también seria muy influyente respecto a la baja
#de generación de toneladas. esta conclusión debía a su correlación
#negativa ft El Vasquez