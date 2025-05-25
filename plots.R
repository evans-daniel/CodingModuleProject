source("data.R")
source("funs.R") # Sourcing my function script for the themes and fonts of my plots.

## Plot 1 ## 
## Length of Orca Encounters over time. ## 

plot1 <- orcas %>% 
  ggplot(aes(x = date, y = duration, colour = VesselName)) + # ggplot creation
  geom_point() + # point geometry layer
  labs(title = 'Length of Orca Encounters over time',
       subtitle = 'Duration of encounters significantly increase after 2020.',
       x = 'Year',
       y = 'Encounter Duration (minutes)') + # Labels
  scale_colour_discrete("Vessel Name") +
  theme_clean() +
  theme(plot.background = element_rect(fill = "#d6f5ff", color = "darkgrey"),
        legend.position = 'right', 
        legend.background = element_rect(fill = "#c7e7f2", colour = "black", linewidth = .3),
        legend.key = element_rect(fill = 'white'), 
        plot.title = element_text(margin = margin(b = 5), family = "Times New Roman"),
        plot.subtitle = element_text(size = 10, margin = margin(b = 10), hjust = 0, face = "italic", family = "Times New Roman"),
        axis.title.y = element_text(margin = margin(r = 7), family = "Times New Roman"),
        axis.title.x = element_text(margin = margin(t = 7), family = "Times New Roman"),
        axis.text = element_text (family = "Times New Roman"),
        legend.title = element_text(face = "bold", size = 12, family = "Times New Roman"),
        legend.text = element_text(size = 10, family = "Times New Roman"))
         #Changing plot label dtails (sizes, positions)

## Plot 2 ##
## Location of Orca Encounters by Vessel ##

plot2 <- orcas %>%
  ggplot() + # calling ggplot
  geom_sf(data = canada, color = "#545454", fill = "#daffd6") + # adding simple figures (sf) layer for canada map. adding colour to this.
  geom_point(aes(y = begin_latitude, x = begin_longitude, colour = VesselName), alpha = .35) + # adding layer for points, points are longitudes and latitudes of encounters, coloured by vessel
  ylim(48, 49.5) + xlim(-126, -122) + # adding limits to the plot. geom_sf will make the full map of longitudes and latitudes, we need to focus in on the salish sea
  labs(title = 'Location of Orca Encounters by Vessel', 
       subtitle = 'Starting location in the Salish Sea, Canada', 
       x = 'Latitude',
       y = 'Longitude') + # Labels
  scale_colour_discrete("Vessel Name") + 
  map_theme() + # Calling function from funs script - all the texts and formatting details for my maps.
  map_fonts() # Applying fonts to all labels

## Plot 3 ##
## Location of encounters by vessel, size by duration ##

plot3 <- orcas %>%
  ggplot() +
  geom_sf(data = canada, color = "#545454", fill = "#daffd6") +
  geom_point(aes(x = begin_longitude, y = begin_latitude, colour = VesselName, size = duration), alpha = .4) + # size of points by duration 
  ylim(48, 49.5) + 
  xlim(-126, -122) + # limits
  scale_size_continuous(range = c(0 , 4), "Duration (mins)") + # setting a limit for the size, if they are too big its unreadable, plus label name
  labs(title = 'Location of Orca Encounters by Vessel',
       subtitle = 'Starting location in the Salish Sea, Canada', 
       x = 'Latitude',
       y = 'Longitude') + # labels
  scale_colour_discrete("Vessel Name") + # legend name 
  map_theme() + 
  map_fonts()

## Plot 4 ##
## location by vessel, duration, highlighting longest encounters ##

plot4 <- orcas %>% ungroup() %>% 
  ggplot() +
  geom_sf(data = canada, color = "#545454", fill = "#daffd6") + 
  geom_point(aes(x = begin_longitude, y = begin_latitude, colour = VesselName, size = duration), alpha = .45) + 
  gghighlight(duration >= 1020, use_direct_label = TRUE,
              label_params = list(max.overlaps = 20, family = "Times New Roman", size = 4),
              unhighlighted_params = list(colour = NULL, alpha = .075)) + # using library/function gghighlight to highlight cases according to a rule (duration > 1020). 
  ylim(48, 49.5) + 
  xlim(-126, -122) +
  scale_size_continuous(range = c(0 , 5)) + # size limits
  labs(title = 'Location of Orca Encounters by Vessel',
       subtitle = 'Starting location in the Salish Sea, Canada', 
       x = 'Latitude',
       y = 'Longitude',
       caption = 'Highlighted locations of durations over 17 hours') + # labels
  map_theme() +
  map_fonts() +
  theme(plot.caption = element_text(family = "Times New Roman", face = "italic")) + # aspect of theme not included in funs
  guides(size = 'none') # removing duration legend for size - info is in caption (>17 hours, 1020 minutes)

# Notes on the warnings:
# There are some warnings thrown, mainly by the y and xlims which is removing some points as they are outside the bounds. 
# gghighlight seems to throw some warnings regarding its group_by() process and predicates.
# Could not caclulate predicated for layer 1 is due to the geom_sf layer (1) not having a duration object, 
# the group_by warning I can't solve

