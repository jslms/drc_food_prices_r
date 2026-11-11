# On recharge le script de nettoyage
source("01_nettoyage.R")

# On charge les librairie pour les graphiques
library(ggplot2)
library(scales)

# ===========================================================
# Graphique 1 : Evolution des prix (Serie temporelle)
# ===========================================================
produits_choisis <- c("Rice (local)", "Cassava flour",
                      "Beans", "Oil (palm)")

# On filtre les donnees pour les ces produits
df_graph1 <- df_clean %>% 
    filter(produit %in% produits_choisis)

# On cree le graphique
ggplot(data = df_graph1, aes(x = date, y = prix, color = produit)) +
    geom_line(linewidth = 1) +
    labs(title = "Evolution des prix des denrees de base a Kinshasa",
         subtitle = "Donnees mensuelles du PAM (WFP)",
         x = "Annee", y = "Prix (selon la devise locale)",
         color = "Produit :") +
    theme_minimal() +
    theme(
        legend.position = "bottom",
        plot.title = element_text(face = "bold", size = 14)
    )
    
# ===========================================================
# Graphique 2 : Top 10 de l'inflation
# ===========================================================

# On calcul la variation en % pour chaque produit
inflation_produit <- df_clean %>% 
    group_by(produit) %>% 
    arrange(date) %>% 
    summarise(
        prix_debut = first(prix),
        prix_fin = last(prix),
        variation_pct = (prix_fin - prix_debut) / prix_debut
    ) %>% 
    filter(!is.na(variation_pct)) %>% 
    arrange(desc(variation_pct)) %>% 
    slice_head(n = 10)

# Graphique a barre horizontale
ggplot(inflation_produit, aes(x = reorder(produit, variation_pct),
                              y = variation_pct)) +
    geom_col(fill = "#2c3e50") +
    coord_flip() +
    scale_y_continuous(labels = percent_format()) +
    labs(
        title = "Top 10 des produits les plus inflationistes a Kinshasa",
        subtitle = "Variation totale sur la periode analysee",
        x = NULL, y = "Variation des prix (%)"
    ) +
    theme_minimal() +
    theme(plot.title = element_text(face = "bold", size = 14))
    






















