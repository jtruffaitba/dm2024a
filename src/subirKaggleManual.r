carpeta = "ZZ-0006"

files = list.files(path = paste0("~/buckets/b1/expw/", carpeta, "/"), pattern = "*.csv", full.names = TRUE)
files = files[grep("ZZ-0006_", files)]

l1 <- "#!/bin/bash \n"
l2 <- "source ~/.venv/bin/activate  \n"
envio = vector()
for (i in 1:length(files)) {
  
  l3 <- paste0( "kaggle competitions submit -c itba-data-mining-2024-a")
  l3 <- paste0( l3, " -f ", files[i] )
  l3 <- paste0( l3,  " -m ",  "\"", carpeta,  " , ",  files[i] , "\"",  "\n")
  envio = c(envio, paste0(l3))
}
l4 <- "deactivate \n"
sh = c(l1, l2, envio, l4)
cat( sh , file = "subirJuan.sh" )
Sys.chmod( "subirJuan.sh", mode = "744", use_umask = TRUE)

system( "./subirJuan.sh" )