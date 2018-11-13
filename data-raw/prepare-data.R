library(tidyverse)
library(usethis)

stimuli <- read_csv("data-raw/stimuli.csv")

ita_egg <- read_csv("data-raw/measurements.csv", na = "--undefined--") %>%
  full_join(y = stimuli) %>%
  mutate(
    v1_duration = (c2_ons - v1_ons) * 1000,
    rel_voff = (c2_ons - c1_rel) * 1000,
    sent_duration = sentence_off - sentence_ons,
    speech_rate = 8 / sent_duration,
    voice_duration = (voice_off - voice_ons) * 1000,
    vot = (voice_ons - c1_rel) * 1000,
    voi_clo = (voice_off - c2_ons) * 1000
  )

use_data(ita_egg, overwrite = TRUE)
