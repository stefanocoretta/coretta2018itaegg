library(tidyverse)

stimuli <- read_csv("data-raw/stimuli.csv")

ita_egg <- read_csv("data-raw/measurements.csv", na = "--undefined--") %>%
  full_join(y = stimuli)
