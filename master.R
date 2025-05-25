## Libraries ##

# install.packages("tidyverse")
library(tidyverse) # Main tidyverse library. Many essential functions used throughout. 

# install.packages("lubridate")
library(lubridate) # Used for calculating / working with dates and functions such as as.duration etc. Included in tidyverse but sometimes easier to include separately.

# install.packages("ggthemes")
library(ggthemes) # More themes for ggplot. theme_clean and map.

# install.packages("fuzzyjoin")
library(fuzzyjoin) # Used for joining my regular expressions with main data frame. Acts as a normal join function, but with case searching.

# install.packages("gghighlight")
library(gghighlight) # Used for ggplots, highlighting specific values/cases.

# install.packages("rgeoboundaries")
library(rgeoboundaries) # Used to get the boundaries of countries.


# Source Data + Cleaning 
source("data.R")

# Source plots
source("plots.R")

# Call plots
plot1
plot2
plot3
plot4

# Save plots
ggsave("output/plot1.png", plot = plot1)
ggsave("output/plot2.png", plot = plot2)
ggsave("output/plot3.png", plot = plot3)
ggsave("output/plot4.png", plot = plot4)
