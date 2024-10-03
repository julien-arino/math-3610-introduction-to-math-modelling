f = function(x, r = 0.5) {
  return(r * x * (1 - x))
}

f2 = function(x, r = 0.5) {
  return(r^2*x-(r^2+r^3)*x^2+2*r^3*x^3-r^3*x^4)
}

#curve(f(x), from = 0, to = 1, xlab = "N", ylab = "N", main = "Logistic growth")


N = c(0.8)
tf = 100

r = 3.5

for (i in 1:tf) {
  N = c(N, f(N[length(N)], r))
}

plot(0:tf, N, type = "b", lwd = 2, col = "red")

x = seq(0, 1, 0.01)
plot(x, f(x, r), type = "l", xlab = "N", ylab = "N",
     ylim = c(0,1),
     main = "Logistic growth")
lines(x,x)
lines(x, f2(x, r), col = "blue")

nb_points = 50
colour = viridis::viridis(nb_points)

for (i in 1:nb_points) {
  points(x = N[i], y = f2(N[i], r), col = colour[i], pch = 16)
}

