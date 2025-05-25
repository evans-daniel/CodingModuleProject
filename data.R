## DATA IMPORTING, CLEANING, PROCESSING ## 

orcas_raw <- read_csv("input/orcas.csv") # Import raw CSV data file. Downloaded from github.

orcas_raw <- orcas_raw %>% select(year, date, begin_time, end_time, vessel, begin_latitude, begin_longitude)
# Selecting only the columns I need for the following analyses/plots. Better readability.

orcas <- orcas_raw %>% mutate(
  dur_sec = if_else(
    as.numeric(end_time) < as.numeric(begin_time),
    as.numeric(end_time) + 86400 - as.numeric(begin_time),
    as.numeric(end_time) - as.numeric(begin_time)),
  duration = dur_sec / 60)
# Creating the duration column. Data set came with one, but it was incorrect, not 
# accounting for changes in days (e.g. 11pm to 2am next day). It was also awfully formatted 
# for plotting. Using an If_else loop to compute.

regexes <- tribble(~ regex, ~ VesselName,
                   "Mike 1", "Mike 1",
                   "Orcinus", "Orcinus",
                   "Morning Star", "Morning Star",
                   "Morningstar", "Morning Star",
                   "KCB", "KCB III",
                   "Chimo", "Chimo")
# Creating a data frame for the regular expressions. regex is the case to search for, 
# VesselName is the category to assign for any values matching the regex. 
# Also could use stringr::str_detect, srt_replace etc. 

orcas <- orcas %>% 
  select(year, date, vessel, begin_latitude, begin_longitude, duration) %>% 
  regex_left_join(regexes, c(vessel = "regex")) %>% 
  drop_na()
# Selecting more columns I need, joining the regex df with main. 
# A regex_left_join is from fuzzyjoin, it does a left_join, but with regexes - so assigning 
# values from x with y, keeping all x values and returning NA for vessels without 
# regex. Drop NA to remove the ships with no regex. Could also just assign these
# NA to 'other' category.

canada <- gb_adm0("CAN")
# Using rgeoboundaries to create an object that contains Canada's level 0 borders.
# Just the country outline for use in ggplot. 
