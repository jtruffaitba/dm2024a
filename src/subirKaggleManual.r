carpeta = "ZZ-0007"

files = list.files(path = paste0("~/buckets/b1/expw/", carpeta, "/"), pattern = "*.csv", full.names = TRUE)
files = files[grep(paste0(carpeta ,"_"), files)]

l1 <- "#!/bin/bash \n"
l2 <- "source ~/.venv/bin/activate  \n"
envio = vector()
for (i in 1:length(files)) {
  
  l3 <- paste0( "kaggle competitions submit -c itba-data-mining-2024-a")
  l3 <- paste0( l3, " -f ", files[i] )
  l3 <- paste0( l3,  " -m ",  "\"", carpeta,  " , ",  files[i] , "\"",  "\n")
  l4 = paste0("sleep ", sample(1:5, 1), "\n")
  envio = c(envio, l3, l4)
}
l5 <- "deactivate \n"
sh = c(l1, l2, envio, l5)
cat( sh , file = "subirJuan.sh" )
Sys.chmod( "subirJuan.sh", mode = "744", use_umask = TRUE)

system( "./subirJuan.sh" )