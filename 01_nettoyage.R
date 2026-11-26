# 1. Charger les librairies
library(tidyverse)
library(lubridate)

# 2. Importer les donnees
df <- read_csv("./datasets/wfp_food_prices_cod.csv")

# 3. Nettoyer et filtrer pour Kinshasa
df_clean <- df %>% 
    rename(
        province = admin1,
        marche = market,
        produit = commodity,
        prix_cdf = price,
        prix_usd = usdprice,
        devise = currency,
        unite_mesure = unit
        
    ) %>% 
    filter(province == "Kinshasa", pricetype == "Retail") %>% 
    filter(!is.na(prix_cdf), prix_cdf > 0)

# Mettre les colonnes renommees en premier 
df_clean <- df_clean %>% 
    relocate(province,
             marche,
             produit,
             prix_cdf,
             prix_usd,
             devise,
             unite_mesure
             )

# Verifier le resultat
glimpse(df_clean)






















