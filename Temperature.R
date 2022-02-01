library(ggplot2)
library(scales)
library(ggthemes)
library(tidyverse)
library(gridExtra)
library(lubridate)
library(mgcv)

temps <- Mt_Gellibrand
#temps$date <- dmy(temps$t)

temps

temp_plot <- ggplot(Mt_Gellibrand, aes(date, tMax)) + 
  geom_point(na.rm = TRUE)
temp_plot

temp_trend <- temp_plot + stat_smooth(colour="green")
temp_trend

library(xts)
library(hydroTSM)

temps_xts <- xts(temps[, -1], order.by = temps$date)
hydroplot(temps_xts, pfreq = "dma", var.type = "Temperature")

# Weekly average
temps_weekly <- apply.weekly(temps_xts, FUN = mean)
plot(temps_weekly)

# Monthly average
temps_monthly <- daily2monthly(temps_xts, FUN = mean, na.rm = TRUE)
plot.zoo(temps_monthly, xaxt = "n", xlab = "", main = "Monthly temperature averages")
lines(ma(temps_monthly, win.len=12), col="blue")
axis.Date(1, at = pretty(index(temps_monthly)),
          labels = format(pretty(index(temps_monthly)), format = "%b-%Y"),
          las = 1, cex.axis = 1.1)

# Seasonal average: need to specify the months
temps_seasonal <- dm2seasonal(temps_xts, season = "DJF", FUN = mean, na.rm = TRUE)
plot(temps_seasonal, main = "Summer seasonal averages")
lines(ma(temps_seasonal, win.len=3), col="blue")

# Annual average
temps_annual <- daily2annual(temps_xts, FUN = mean, na.rm = TRUE)
plot(temps_annual, main = "Annual average temperatures")
lines(ma(temps_annual, win.len=8), col="blue")
temps_annual
mean(temps_annual)

require(astsa)
require(ggfortify)
require(tidyverse)
require(ggpmisc)
require(strucchange)
require(changepoint)
require(lubridate)
require(oce)


## define the total number of days in a year
days = 1:365
#define the total number of years as indicated by the data
years = 2000:2020


## make a matrix using the origin temperature values
all.mat = matrix(Mt_Gellibrand$tMax, nrow = length(days)) 
## plot the matrix
imagep(x = years, y = days, z = all.mat %>% t(), filledContour = F, 
       ylim = c(365,0),
       ylab = "Day", 
       col = oceColors9A(120),
       zlab = expression(Temperature~(degree *C)))
## add contour
contour(x = years, y = days, z = all.mat %>% t(), add = TRUE, col = 1, nlevels = 3)

mtg.tb = Mt_Gellibrand %>% mutate(year = year(date), day.year = yday(date))

## interpolate the missing values
interpolated.temperature = interpBarnes(x = mtg.tb$day.year, 
                                        y = mtg.tb$year, 
                                        z = mtg.tb$tMax, 
                                        xgl = 365, 
                                        ygl = 21)

#create time series object
daily.ts = ts(data = Mt_Gellibrand$tMax, 
              start = c(2001,1), 
              frequency = 365)

#plot time series object
autoplot(daily.ts) + 
  ggtitle("Mt Gellibrand Max Temps 2001-2020") + 
  xlab("Year") + 
  ylab("Degrees C")

library(forecast)

#plot seasonal plot
ggseasonplot(daily.ts, year.labels = TRUE, year.labels.left = TRUE) + 
  ylab("Degrees C") + 
  ggtitle("Seasonal plot: Mt Gellibrand Max Temps 2001-2020")

#plot polar seasonal plot
ggseasonplot(daily.ts, polar = TRUE) + 
  ylab("Degrees C") + 
  ggtitle("Polar season plot: Mt Gellibrand Max Temps 2001-2020")

#plot subseries plot
ggsubseriesplot(daily.ts) +
  ylab("Degrees C") + 
  ggtitle("Seasonal subseries plot: Mt Gellibrand Max Temps 2001-2020")

#lag plots
lagtemps <- window(daily.ts, start=2001)
gglagplot(lagtemps)

ggAcf(lagtemps, lag = 48)

#forecasting methods
temp_forecast_1 <- window(daily.ts,start=2001,end=c(2020,4))

autoplot(temp_forecast_1) +
  autolayer(meanf(temp_forecast_1, h=1825),
            series="Mean", PI=FALSE) +
  autolayer(naive(temp_forecast_1, h=1825),
            series="Naïve", PI=FALSE) +
  autolayer(snaive(temp_forecast_1, h=1825),
            series="Seasonal naïve", PI=FALSE) +
  ggtitle("Forecasts for daily temperatures") +
  xlab("Year") + ylab("Degrees C") +
  guides(colour=guide_legend(title="Forecast"))

summary(Forrest_Modelled_Temps)
avg.ts <- ts(data = Forrest_Modelled_Temps$Avg, 
             start = c(2001,1), 
             frequency = 1)
autoplot(Forrest_Modelled_Temps$Avg) + 
  ggtitle("Mt Gellibrand Max Temps 2001-2020") + 
  xlab("Year") + 
  ylab("Degrees C")
str(Forrest_Modelled_Temps)

### Linear model

library(tidyverse)
library(ggpubr)

RCP_45 <- Forrest_Modelled_Temps$Mod_45
RCP_60 <- Forrest_Modelled_Temps$Mod_60

ggplot(Forrest_Modelled_Temps, aes(x = Year)) + 
  geom_point(aes(y = Avg), col = "blue") +
  geom_point(aes(y = RCP_45), col = "red") +
  geom_point(aes(y = RCP_60), col = "forestgreen") +
  geom_smooth(aes(y = Avg),  method = "lm", col = "blue") +
  geom_smooth(aes(y = RCP_45), method = "lm", col = "red") +
  geom_smooth(aes(y = RCP_60),  method = "lm", col = "forestgreen")

plot(Forrest_Modelled_Temps$'Modelled Avg'~Forrest_Modelled_Temps$Year)
lm(Forrest_Modelled_Temps$'Mod_45'~Forrest_Modelled_Temps$Year)

(2000*0.02308)-29.899

library(lubridate)

Cape_Otway_Daily$date <-
Cape_Otway_Daily %>% 
  mutate(date = make_datetime(Year, Month, Day))

str(Cape_Otway_Daily)

library(dplyr)

temp.year.sum <- Cape_Otway_Daily %>% 
  group_by(Year) %>% 
  dplyr::summarise(mean(tMax, na.rm = TRUE))


temp.year.sum

baseline <- temp.year.sum %>% 
  filter(Year < 1980)
mean(baseline$`mean(tMax, na.rm = TRUE)`)

# remodel with 1990-2020 data

temp30yr <- temp.year.sum %>% 
  filter(between(Year, 1990, 2020 ))
temp30yr

ggplot(temp30yr, aes(x = Year)) + 
  geom_point(aes(y = `mean(tMax, na.rm = TRUE)`), col = "blue") +
  geom_smooth(aes(y = `mean(tMax, na.rm = TRUE)`),  method = "lm", col = "blue")


plot(temp30yr$`mean(tMax, na.rm = TRUE)`~ temp30yr$Year)
temp.lm <- lm(temp30yr$`mean(tMax, na.rm = TRUE)`~ temp30yr$Year)
abline(temp.lm, col = "red")
temp.lm
