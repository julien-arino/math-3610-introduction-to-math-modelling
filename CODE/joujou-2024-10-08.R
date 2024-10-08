f = function(x, r = 0.5) {
  return(r * x * (1 - x))
}

iter = function(r = 0.5, burn_in = 100, tf = 200) {
  N = c(0.5)
  for (i in 1:tf) {
    N = c(N, f(N[length(N)], r))
  }
  N2 = N[burn_in:length(N)]
  OUT = data.frame(rep(r, length(N2)), N = N2)
  return(OUT)
}


plot(iter(2.5), 
     type = "b", lwd = 2, col = "red",
     pch = 19, cex = 0.1,
     xlim = c(2.5, 4), ylim = c(0, 1),
     xlab = "Time", ylab = latex2exp::TeX("$N^*$"),
     main = "Logistic growth")
for (r in seq(2, 4, by = 0.005)) {
  points(iter(r), type = "p", lwd = 2, col = "red",
         pch = 19, cex = 0.1)
}
