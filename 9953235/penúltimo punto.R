set.seed(123)  # Para reproducibilidad

# Dividir los datos en 70% entrenamiento y 30% prueba
n <- nrow(datos)
train_idx <- sample(1:n, size = 0.7 * n)  
datos_train <- datos[train_idx, ]
datos_test <- datos[-train_idx, ]

# Modelos usando backward selection
modelo_completo <- lm(Ventas ~ Toneladas + Inventario + Algodón + Poliéster + 
                        Energia + Productividad + Proteccion + Agua, data = datos_train)

modelo_backward <- step(modelo_completo, direction = "backward", trace = FALSE)

# Extraer modelos intermedios de backward selection
modelos <- list(
  lm(Ventas ~ Toneladas, data = datos_train),
  lm(Ventas ~ Toneladas + Inventario, data = datos_train),
  lm(Ventas ~ Toneladas + Inventario + Algodón, data = datos_train),
  lm(Ventas ~ Toneladas + Inventario + Algodón + Poliéster, data = datos_train),
  lm(Ventas ~ Toneladas + Inventario + Algodón + Poliéster + Productividad, data = datos_train),
  lm(Ventas ~ Toneladas + Inventario + Algodón + Poliéster + Productividad + Proteccion, data = datos_train),
  lm(Ventas ~ Toneladas + Inventario + Algodón + Poliéster + Productividad + Proteccion + Energia, data = datos_train),
  modelo_backward  # Modelo final con menor AIC
)

# Calcular el MSE en el conjunto de prueba
calcular_mse <- function(modelo, datos_test) {
  predicciones <- predict(modelo, newdata = datos_test)
  mean((datos_test$Ventas - predicciones)^2)
}

# Obtener MSE para cada modelo
mse_valores <- sapply(modelos, calcular_mse, datos_test = datos_test)

# Encontrar el modelo con el menor MSE
mejor_modelo_idx <- which.min(mse_valores)
mejor_modelo <- modelos[[mejor_modelo_idx]]

# Mostrar resultados
cat("El modelo con el menor MSE tiene un MSE de:", mse_valores[mejor_modelo_idx], "\n")
summary(mejor_modelo)
