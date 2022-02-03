### CO2 data analysis
### Use datafile "CapeGrim_CO2_data_download"

library(tidyverse)

co2 <- CapeGrim_CO2_data_download

co2 <- co2 %>% 
  filter(YYYY %in% (1976:2020))

co2

co2_plot <- ggplot(co2, aes(`DATE`, `CO2(ppm)`)) + 
  geom_point(na.rm = TRUE)
co2_plot

co2_trend <- co2_plot + stat_smooth(colour="green")
co2_trend

ggplot(co2, aes(x = `DATE`)) + 
  geom_point(aes(y = `CO2(ppm)`), col = "blue") +
  geom_smooth(aes(y = `CO2(ppm)`),  method = "lm", col = "blue") +
  ggtitle("CO2 observations from Cape Grim 1976-2020")

mean(co2$`CO2(ppm)`)

lm(co2$`CO2(ppm)`~co2$DATE)

### Temperature data analysis
### Use datafile "Cape_Otway_Daily"

library(tidyverse)

Cape_Otway_Daily$date <-
  Cape_Otway_Daily %>% 
  mutate(date = make_datetime(Year, Month, Day))

str(Cape_Otway_Daily)

temp.year.sum <- Cape_Otway_Daily %>% 
  group_by(Year) %>% 
  dplyr::summarise(mean(tMax, na.rm = TRUE))

temp.year.sum

# remodel with 1990-2020 data

temp30yr <- temp.year.sum %>% 
  filter(between(Year, 1990, 2020 ))
temp30yr

ggplot(temp30yr, aes(x = Year)) + 
  geom_point(aes(y = `mean(tMax, na.rm = TRUE)`), col = "blue") +
  geom_smooth(aes(y = `mean(tMax, na.rm = TRUE)`),  method = "lm", col = "blue") +
  ggtitle("Mean annual max temperature at Cape Otway weather station") + 
  ylab("°C")


plot(temp30yr$`mean(tMax, na.rm = TRUE)`~ temp30yr$Year)
temp.lm <- lm(temp30yr$`mean(tMax, na.rm = TRUE)`~ temp30yr$Year)
abline(temp.lm, col = "red")
temp.lm
