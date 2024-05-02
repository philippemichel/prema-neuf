

#  ------------------------------------------------------------------------
#
# Title : import
#    By : PhM
#  Date : 2024-05-02
#
#  ------------------------------------------------------------------------

import <- function() {
  library(tidyverse)
  library(janitor)
  library(readODS)
  library(labelled)
  library(baseph)
#
tt <- read_ods("datas/PREMA-NEUF.ods", sheet = "data", na = c("", " ", "nk", "na", "non renseigné", "rdv non raté","NA", "nd")) |>
  clean_names() |>
  mutate_if(is.character, as.factor) |>
  mutate(id = as.factor(id))
bb <- read_ods("datas/PREMA-NEUF.ods", sheet = "nom", na = c("", " ", "nk", "na"))
var_label(tt) <- bb$nom
#
# Motif d'admission
#

#
save(tt, bb, file = "datas/premaneuf.RData")
}

load(file = "datas/premaneuf.RData")

