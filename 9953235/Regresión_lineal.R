install.packages("lmtest")
install.packages("car")

library(lmtest)
library(car)

# Ajustar el modelo de regresión lineal múltiple
modelo <- lm(Ventas ~ Toneladas + Inventario + Algodón + Poliéster + Energia + Productividad + Proteccion + Agua, data = datos)
summary(modelo)

# Graficamos las predicciones vs los residuos
plot(modelo$fitted.values, modelo$residuals, main="Residuos vs Predicciones")
abline(h=0, col="red")

# Normalidad de los residuos
hist(modelo$residuals, main="Histograma de residuos", breaks=30)
shapiro.test(modelo$residuals)

# Homocedasticidad
bptest(modelo)


# Multicolinealidad
vif(modelo)
