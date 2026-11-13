# =================================================
# Script pour telecharger la derniere version du
# dataset depuis HDX
# =================================================
library(httr)
library(tools)

# URL de telechargement du fichier de donnees (csv)
url_hdx <- "https://data.humdata.org/dataset/wfp-food-prices-for-democratic-republic-of-the-congo#:~:text=More%20information-,Download%20(11.8M),-CSV"

fichier_local <- "wfp_food_prices_cod.csv"

# Telecharger dans un fichier temporaire
temp_file <- tempfile(fileext = ".csv")
GET(url_hdx, write_disk(temp_file, overwrite = TRUE))

# Verifier si le fichier a changer par rapport a la
# version locale (sur la machine)
if(!file.exists(fichier_local) || md5sum(fichier_local) != md5sum(temp_file)){
    file.copy(from = temp_file, to = fichier_local, overwrite = TRUE)
    cat("Le fichier a ete mis a jour !\n")
} else{
    cat("Aucun changement detecte, pas de mise a jour !\n")
}
















