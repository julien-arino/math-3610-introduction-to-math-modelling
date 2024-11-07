f = function(x, r = 0.5) {
  return(r * x * (1 - x))
}

curve(f(x), from = 0, to = 1, xlab = "N", ylab = "N", main = "Logistic growth")

N = c(0.5)
N2 = c(0.5000001)
tf = 100

for (i in 1:tf) {
  N = c(N, f(N[length(N)], 3.2))
  # N2 = c(N2, f(N2[length(N2)], 3.8))
}

plot(0:tf, N, type = "b", lwd = 2, col = "red")
#lines(0:tf, N2, type = "b", lwd = 2, col = "blue")

f = function(x) {
  return(x + 0.0001*(5000-x)*(x-100))
}
  