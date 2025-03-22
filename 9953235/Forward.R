install.packages("MASS")

library(MASS)

# Modelo nulo (sin predictores)
modelo_nulo <- lm(Ventas ~ 1, data = datos)

# Modelo completo (con todas las variables)
modelo_completo <- lm(Ventas ~ Toneladas + Inventario + Algodón + Poliéster + Energia + Productividad + Proteccion + Agua, data = datos)

# Forward Selection basado en AIC
modelo_forward <- step(modelo_nulo, 
                       scope = list(lower = modelo_nulo, upper = modelo_completo), 
                       direction = "forward")

# Resumen del mejor modelo encontrado
summary(modelo_forward)

# Backward
# Modelo completo con todas las variables
modelo_completo <- lm(Ventas ~ Toneladas + Inventario + Algodón + Poliéster + Energia + Productividad + Proteccion + Agua, data = datos)

# Backward Selection basado en AIC
modelo_backward <- step(modelo_completo, direction = "backward")

summary(modelo_backward)

