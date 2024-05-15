# Arbol elemental con libreria  rpart
# Debe tener instaladas las librerias  data.table  ,  rpart  y  rpart.plot

# cargo las librerias que necesito
require("data.table")
require("rpart")
require("rpart.plot")

# Aqui se debe poner la carpeta de la materia de SU computadora local
setwd("~/itba/mineria/") # Establezco el Working Directory

file = "ejerClase" #  "K101_012"

# cargo el dataset
dataset = fread('~/itba/mineria/buckets/b1/exp/HT2020/gridsearch2.txt')        

# dataset <- fread('./datasets/ejerClase.csv') # fread("./datasets/dataset_pequeno.csv")
# dataset=dataset[,-1]
# dataset$cp = as.numeric(dataset$cp)
# dataset$ganancia_promedio = as.numeric(dataset$ganancia_promedio)
# dataset$ganancia_promedio = dataset$ganancia_promedio / 1e6
# 
# dtrain <- dataset[foto_mes == 202107] # defino donde voy a entrenar
# dapply <- dataset[foto_mes == 202109] # defino donde voy a aplicar el modelo

# genero el modelo,  aqui se construye el arbol
# quiero predecir clase_ternaria a partir de el resto de las variables
modelo <- rpart(
        formula = "ganancia_promedio ~ .",
        data = dataset, # los datos donde voy a entrenar
        xval = 0,
        cp = -1, # esto significa no limitar la complejidad de los splits
        minsplit = 100, # minima cantidad de registros para que se haga el split
        minbucket = 20, # tamaño minimo de una hoja
        maxdepth = 6 # profundidad maxima del arbol
) # profundidad maxima del arbol


# grafico el arbol
prp(modelo,
        extra = 101, digits = -5,
        branch = 1, type = 4, varlen = 0, faclen = 0
)

pdf(paste0('~/itba/mineria/outArbol', file, '.pdf'))

prp(modelo,
    extra = 101, digits = -5,
    branch = 1, type = 4, varlen = 0, faclen = 0
)

dev.off()
