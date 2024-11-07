require(deSolve)

rhs_logistic <- function(t, N, p) {
  with(as.list(p), {
    dN <- r * N * (1 - N/K)
    return(list(dN))
  })
}
rhs_logistic_2 <- function(t, N, p) {
  with(as.list(p), {
    dN <- N * (k - alpha*(N-eta)^2)
    return(list(dN))
  })
}
p = list(
  r = 0.1,
  K = 100,
  A = 50,
  b = 0.1,
  H = 0.05,
  k = 100,
  eta = 10,
  alpha = 5
)

IC = c(N = 10)

sol_1 = ode(IC, seq(0,100,0.5), rhs_logistic, parms = p)
sol_2 = ode(IC, seq(0,100,0.5), rhs_logistic_2, parms = p)

plot(sol_2[,"time"], sol_2[,"N"])

p$eta+sqrt(p$k/p$alpha)
