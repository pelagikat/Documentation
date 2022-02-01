library(tidyverse)

library(stringr)
library(dplyr)

ID_list <- ACCIDENT_LOCATION %>%
  filter(str_detect(ROAD_NAME, "FORR"))

results <- left_join(ID_list, ACCIDENT, by = "ACCIDENT_NO")
results

write.csv(results, file ="accident_stats")

accident_stats$YEAR <- format(as.Date(accident_stats$ACCIDENTDATE, format="%d/%m/%Y"),"%Y")

results <- left_join(accident_stats, VEHICLE, by = "ACCIDENT_NO")
results
write.csv(results, file = "accident_stats_2.csv")

accident_stats_2 %>% count(YEAR)
