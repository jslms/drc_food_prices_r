# 1. Charger les librairies
library(tidyverse)
library(lubridate)

# 2. Importer les donnees
df <- read_csv("wfp_food_prices_cod.csv")

# 3. Nettoyer et filtrer pour Kinshasa
df_clean <- df %>% 
    rename(
        province = admin1,
        marche = market,
        produit = commodity,
        prix = price,
        devise = currency
    ) %>% 
    filter(province == "Kinshasa") %>% 
    filter(!is.na(prix), prix > 0)

# Mettre les colonnes renommees en premier 
df_clean <- df_clean %>% 
    relocate(province,
             marche,
             produit,
             prix,
             devise)

# Verifier le resultat
glimpse(df_clean)






















