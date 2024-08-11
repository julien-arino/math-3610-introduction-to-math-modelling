# Illustrate simple data wrangling using the SARS-CoV-1 data

library(sqldf)
library(dplyr)
library(EpiCurve)

SARS = read.csv("SARS-CoV-1_data.csv")

## Three ways to keep only the data for one country
ctry = "Canada"
# The basic one
idx = which(SARS$country == ctry)
SARS_selected = SARS[idx,]
# The sqldf way
SARS_selected = sqldf(paste0("SELECT * FROM SARS WHERE country = '", 
                             ctry, "'"))
# The dplyr way
SARS_selected = SARS %>%
  filter(country == ctry)

# Create incidence for the selected country. diff does difference one by one,
# so one less entry than the vector on which it is being used, thus we pad with a 0.
SARS_selected$incidence = c(0, diff(SARS_selected$totalNumberCases))
# Keep only positive incidences (discard 0 or negative adjustments)
SARS_selected = SARS_selected %>%
  filter(incidence > 0)

# Before plotting, we need to make the dates column we will use be actual dates..
SARS_selected$toDate = lubridate::ymd(SARS_selected$toDate)

# Plot the result
png(file = "../FIGS/SARS-CoV-1_cases_CAN.png", 
    width = 800, height = 400)
EpiCurve(SARS_selected,
         date = "toDate", period = "day",
         freq = "incidence",
         title = "SARS-CoV-1 incidence in Canada in 2003")
# Crop the figure (using a function in useful_functions.R)
crop_figure("../FIGS/SARS-CoV-1_cases_CAN.png")
