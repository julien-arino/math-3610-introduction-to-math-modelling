require(deSolve)

rhs_logistic_Allee <- function(t, N, p) {
  with(as.list(p), {
    dN <- r * N * (N/A - 1) * (1 - N/K)
    return(list(dN))
  })
}
p = list(
  r = 0.1,
  K = 100,
  A = 50,
  b = 0.1,
  H = 0.05
)
IC = c(N = 1)

sol = list()
i = 1
for (ic in 0:120) {
  IC = (N = ic)
  tspan = seq(0, 100, by = 0.1)
  sol[[i]] = ode(y = IC, times = tspan, func = rhs_logistic_Allee, parms = p)
  colnames(sol[[i]]) = c("time", "N")
  sol[[i]] = as.data.frame(sol[[i]])
  i = i + 1
}

y_max = max(sapply(sol, function(x) max(x[,2])))

plot(sol[[1]][,"time"], 
     sol[[1]][,"N"], 
     type = "l", ylim = c(0, y_max), 
     xlab = "Time", ylab = "Population size", col = "black", lwd = 0.5)
for (i in 2:length(sol)) {
  lines(sol[[i]][,"time"], sol[[i]][,"N"], 
        col = ifelse(sol[[i]]$N[dim(sol[[i]])[1]] < p$A, "black", "red"),
        lwd = 0.5)
}
