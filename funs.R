# Theme for maps, saves writing it out every time.

map_theme <- function() {
  ggthemes::theme_map() + # theme map
    theme(plot.background = element_rect(fill = "#d6f5ff", color = "darkgrey"), # background light blue, border grey
          legend.position = 'right', 
          legend.background = element_rect(fill = "#c7e7f2", colour = "black", linewidth = .3), # legend colouring
          legend.key = element_rect(fill = 'white'))
}

# Fonts for maps 
map_fonts <- function(){
  theme(plot.title = element_text(face = "bold", family = "Times New Roman", size = 14),
        plot.subtitle = element_text(face = "italic", family = "Times New Roman", size = 10),
        legend.title = element_text(face = "bold", size = 8, family = "Times New Roman"),
        legend.text = element_text(size = 6, family = "Times New Roman"))
} # setting all fonts to Times New Roman, varying size. Not APA guided as plots look different depending on many factors.