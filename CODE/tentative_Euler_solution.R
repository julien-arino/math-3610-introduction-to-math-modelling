# The function we use to compute the right hand side

rhs_logistic = function(y, t=0, par) {
  OUT = par$r * y * (1 - y/par$K)
  return(OUT)
}

par = list(r = 0.1, K = 100)
N_0 = 10

h = 1
t_f = 50
times = seq(0, t_f, by = h)

N = N_0

for (t in times) {
  current_N = N[length(N)]
  tmp = current_N + h*rhs_logistic(current_N, par = par)
  N = c(N, tmp)
}

# We do go one step too far, so we remove the last computed value of N.
# Note, we could also run to times[length(times)-1]
N = N[1:(length(N)-1)]

plot(times,N,
     ylim = c(0, max(N)+5))
abline(h = par$K, lty = 3)
abline(h = 0, lty = 3)
