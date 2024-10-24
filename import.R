

#  ------------------------------------------------------------------------
#
# Title : import
#    By : PhM
#  Date : 2024-05-02
#
#  ------------------------------------------------------------------------

importph <- function() {
  library(tidyverse)
  library(janitor)
  library(readODS)
  library(labelled)
  library(baseph)
#
tt <- read_ods("datas/PREMA-NEUF.ods", sheet = "data", na = c("", " ", "nk", "na", "non renseigné", "rdv non raté","NA", "nd")) |>
  clean_names() |>
  mutate_if(is.character, as.factor) |>
  mutate(id = as.factor(id)) |>
  ## Réordonnancement de nb_hospitalisations
  mutate(nb_hospitalisations =
  fct_relevel(nb_hospitalisations,
    "0", "1", "2", "3", ">3"
  )) |>
  mutate(across(ends_with("zscore"), ~.x *-1)) |>
  mutate(across(ends_with("zscore"), as.factor)) |>
mutate(poids_sortie_zscore = fct_relevel(poids_sortie_zscore,
    "0", "-1", "-2", "-3"
  )) |>
mutate(taille_sortie_zscore = fct_relevel(taille_sortie_zscore,
                                         "0", "-1", "-2", "-3", "-4"
)) |>
mutate(pc_sortie_zscore = fct_relevel(pc_sortie_zscore,
                                          "0", "-1", "-2","-4"
))

aa <- which(tt$kine_prescrite == "non")
tt$kine_faite[aa] <- NA
aa <- which(tt$psychomot_prescrite == "non")
tt$psychomot_faite[aa] <- NA
tt <- tt |>
  mutate(psychomot_faite = factor(psychomot_faite)) |>
  mutate(kine_faite = factor(kine_faite))

bb <- read_ods("datas/PREMA-NEUF.ods", sheet = "nom", na = c("", " ", "nk", "na"))
var_label(tt) <- bb$nom
#
# Motif d'admission
#

#
save(tt, bb, file = "datas/premaneuf.RData")
}

importph()
load(file = "datas/premaneuf.RData")

