# Plot the trajectories of the KMK SIR system in the SI-plane
# 
# In this plot, the total population N is normalised to 1

# Load useful_functions.R, which contains the crop function
source("useful_functions.R")

gamma = 1/5
beta = 0.5

# Just to confirm the value of R_0
writeLines(paste0("R_0=", beta/gamma))

# Store the values of S and I in lists
S = list()
I = list()

i = 1
# Solutions starting on the S axis
for (S0 in seq(0.6, 1, 0.1)) {
  I0 = 0
  S[[i]] = seq(0.001, S0, 0.001)
  I[[i]] = S0+I0-S[[i]]+gamma/beta*log(S[[i]]/S0)
  i = i+1
}
# Solutions starting on the S+I=1 line
for (S0 in seq(1, 0.05, -0.1)) {
  I0 = 1-S0
  S[[i]] = seq(0.001, S0, 0.001)
  I[[i]] = S0+I0-S[[i]]+gamma/beta*log(S[[i]]/S0)
  i = i+1
}
# S+I=1 line
S[[i]] = seq(0, 1, 0.001)
I[[i]] = 1-S[[i]]
# Are we plotting for a dark background
plot_blackBG = TRUE
# Plot (and save) the result
png("../FIGS/KMK_planar_trajectories.png", width = 1000, height = 600)
if (plot_blackBG) {
  par(bg = 'black', fg = 'white') # set background to black, foreground white
  colour = "white"
} else {
  colour = "black"
}
for (i in 1:length(S)) {
  if (i == 1) {
    plot(S[[i]], I[[i]],
         type = "l", lwd = 3,
         col = ifelse((I[[i]][length(I[[i]])] < max(I[[i]])), "red", "white"),
         xlim = c(0,1), ylim = c(0,1),
         xaxs = "i", yaxs = "i",
         xlab = "S", ylab = "I",
         col.axis = colour, cex.axis = 2,
         col.lab = colour, cex.lab = 2,
         bty = "n")
    points(S[[i]][length(S[[i]])], I[[i]][length(I[[i]])],
          pch = 19, cex = 3, 
          col = ifelse((I[[i]][length(I[[i]])] < max(I[[i]])), "red", "white"))
  } else if (i<length(S)) {
    lines(S[[i]], I[[i]], 
          col = ifelse((I[[i]][length(I[[i]])] < max(I[[i]])), "red", "white"),
          lwd = 3)
    points(S[[i]][length(S[[i]])], I[[i]][length(I[[i]])],
           pch = 19, cex = 3, 
           col = ifelse((I[[i]][length(I[[i]])] < max(I[[i]])), "red", "white"))
  } else {
    lines(S[[i]], I[[i]])
  }
}
dev.off()
crop_figure("../FIGS/KMK_planar_trajectories.png")
