t0 = 0
N0 = 100
tf = 500
b = 0.05
d = 0.02

r = b-d
K = 100

# t = c(t0)
# N = c(N0)
# 
# while(t[length(t)] <= tf) {
#   xi_t = N[length(N)] * (b+d)
#   if (xi_t<1e-12) {
#     break
#   }
#   tau_t = rexp(1, rate = xi_t)
#   t = c(t, t[length(t)] + tau_t)
#   pi_t = runif(1)
#   if(pi_t <= b/(b+d)) {
#     N = c(N, N[length(N)] + 1)
#   } else {
#     N = c(N, N[length(N)] - 1)
#   }
# }
# 
# plot(t[1:length(N)],N, type = "l")
# 
# 
t = c(t0)
N = c(N0)

while(t[length(t)] <= tf) {
  xi_t = r*N[length(N)] + r*N[length(N)]^2/K
  if (xi_t<1e-12) {
    break
  }
  tau_t = rexp(1, rate = xi_t)
  t = c(t, t[length(t)] + tau_t)
  pi_t = runif(1)
  if(pi_t <= 1/(1+N[length(N)]/K)) {
    N = c(N, N[length(N)] + 1)
  } else {
    N = c(N, N[length(N)] - 1)
  }
}

plot(t[1:length(N)],N, type = "l")
abline(h = K, col = "red")
