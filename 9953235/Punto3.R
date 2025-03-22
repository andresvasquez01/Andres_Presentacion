# Instalar y cargar las librerías necesarias
install.packages("caret")
install.packages("boot")
library(caret)
library(boot)

set.seed(123)  # Para reproducibilidad

# Validación con Validation Set (Hold-out)
trainIndex <- createDataPartition(datos$Ventas, p=0.7, list=FALSE)  
trainData <- datos[trainIndex, ]  
testData  <- datos[-trainIndex, ]  

modelo_train <- lm(Ventas ~ Toneladas + Inventario + Algodón + Poliéster + Energia + Productividad + Proteccion + Agua, data = trainData)

# Evaluamos en test set
pred_test <- predict(modelo_train, newdata=testData)
mse_test <- mean((pred_test - testData$Ventas)^2)
cat("MSE con Validation Set:", mse_test, "\n")

# Validación con K-Fold Cross Validation (k=10)
k_fold <- trainControl(method="cv", number=10)
modelo_kfold <- train(Ventas ~ Toneladas + Inventario + Algodón + Poliéster + Energia + Productividad + Proteccion + Agua, 
                      data=datos, method="lm", trControl=k_fold)

cat("MSE con K-Fold (10):", modelo_kfold$results$RMSE^2, "\n")

