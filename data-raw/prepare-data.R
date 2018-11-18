library(tidyverse)
library(usethis)

stimuli <- read_csv("data-raw/stimuli.csv")

ita_egg <- read_csv("data-raw/measurements.csv", na = "--undefined--") %>%
  full_join(y = stimuli) %>%
  mutate(
    v1_duration = (c2_ons - v1_ons) * 1000,
    c2_clos_duration = (c2_rel - c2_ons) * 1000,
    rel_voff = (c2_ons - c1_rel) * 1000,
    sent_duration = sentence_off - sentence_ons,
    speech_rate = 8 / sent_duration,
    speech_rate_c = speech_rate - mean(speech_rate),
    voice_duration = (voice_off - voice_ons) * 1000,
    vot = (voice_ons - c1_rel) * 1000,
    voi_clo = (voice_off - c2_ons) * 1000,
    rel_rel = (c2_rel - c1_rel) * 1000,
    vowel = factor(vowel, levels = c("i", "e", "a", "o", "u")),
    height = factor(height, levels = c("low", "mid-low", "mid-high", "high")),
    c1_place = factor(c1_place, levels = c("labial", "coronal", "velar")),
    c2_place = factor(c2_place, levels = c("labial", "coronal", "velar"))
  )

use_data(ita_egg, overwrite = TRUE)
