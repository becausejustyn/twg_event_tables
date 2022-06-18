

# make the tables
# mkdir data

# zombies
# heist
# 

library(tidyverse)
library(kableExtra)

# heist
heist_df <- tibble(
  'Level' = 1:100,
  'FE' = Level * 10000, 
  'EXP' = Level * 1000, 
  'FE ' = cumsum(FE), 
  'EXP ' = cumsum(EXP), 
  'WP' = Level * 500
) 

write_csv(heist_df, "data/heist.csv")

heist_df %>%
  kbl(
    format.args = list(big.mark = ","),
    caption = 'Heist Event Rewards'
  ) %>%
  add_header_above(c(" " = 1, "Level Reward" = 2, "Cumulative Reward" = 3)) %>%
  kable_styling(
    bootstrap_options = c('striped', 'hover', 'condended'),
    fixed_thead = TRUE) 

# zombie rewards
# add node that you get TP == the level
zombie_df <- tibble(
  Level = 1:100,
  'FE' = 119700 + (Level * 13300), 
  'EXP' = 14400 + (Level * 1600),
  'FE ' = cumsum(FE), 
  'EXP ' = cumsum(EXP),
  'WP' = Level * 250,
  'TP' = Level * (Level + 1) / 2
)

write_csv(zombie_df, "data/zombie.csv")

# could add the option to filter between K and ,000

zombie_df %>%
  kbl(
    format.args = list(big.mark = ","),
    caption = 'Zombie Event Rewards'
  ) %>%
  add_header_above(c(" " = 1, "Level Reward" = 2, "Cumulative Reward" = 4)) %>%
  kable_styling(
    bootstrap_options = c('striped', 'hover', 'condended'),
    fixed_thead = TRUE) %>%
  footnote(
    general = 'Each wave you gain TP equal to the wave you completed, e.g. Wave 8 gives you 8 TP.'
  )