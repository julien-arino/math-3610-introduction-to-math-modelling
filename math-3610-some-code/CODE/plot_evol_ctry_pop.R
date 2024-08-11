# Plot the evolution of the population of a country, using data from the World
# Bank

library(wbstats)
source("useful_functions.R")

# Set the country for use in the code
ctry = "CAN"
# Get the country population information
pop_data_CTRY <- wb_data(country = ctry, indicator = "SP.POP.TOTL",
                         mrv = 100, return_wide = FALSE)
# Use a function in useful_functions.R to make the y-axis labels human readable
y_range = range(pop_data_CTRY$value)
y_axis <- make_y_axis(y_range)
# Note that after using this function, the y-axis is changed and thus data must
# be scaled, on the y-axis, by the factor y_axis$factor

# Are we plotting for a dark background
plot_blackBG = TRUE
# Are we saving the figure to a file
plot_file = TRUE

# Make the plot
if (plot_file) {
  png(file = sprintf("pop_%s.png", ctry), 
      width = 800, height = 400)
}
if (plot_blackBG) {
  par(bg = 'black', fg = 'white') # set background to black, foreground white
  colour = "white"
} else {
  colour = "black"
}
plot(pop_data_CTRY$date, pop_data_CTRY$value * y_axis$factor,
     xlab = "Year", ylab = "Population", type = "b", lwd = 2,
     col.axis = colour, cex.axis = 2,
     col.lab = colour, cex.lab = 1.5,
     yaxt = "n")
axis(2, at = y_axis$ticks, labels = y_axis$labels, 
     las = 1,
     col.axis = colour,
     cex.lab = 2)
if (plot_file) {
  dev.off()
}
# Crop the figure (using a function in useful_functions.R)
# if (plot_file) {
#   crop_figure(sprintf("pop_%s.png", ctry))
# }