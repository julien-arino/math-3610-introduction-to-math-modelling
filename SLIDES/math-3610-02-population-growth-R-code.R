# Load required libraries
library(ggplot2)
library(dplyr)
library(tidyr)
library(knitr)

# Load the data
USA_census <- read.csv("DATA/USA-census-1790-to-2020.csv", header=TRUE)
colnames(USA_census) <- c("Year", "Population")
USA_census_to_1910 = USA_census %>%
  filter(Year <= 1910)

tables = list()
nb_tables = ceiling(dim(USA_census_to_1910)[1] / 5)
for (i in 1:nb_tables) {
  tables[[i]] = USA_census_to_1910[(5*(i-1)+1):(5*i),]
  tables[[i]] = tables[[i]] %>%
    filter(!is.na(Population)) %>% 
    mutate(across(Population, ~ format(.x, big.mark = ",")))
}
kable(tables, 
      booktabs = TRUE,
      row.names = FALSE,
      escape = FALSE)
plot_USA_census_to_1910 = 
  ggplot(USA_census_to_1910, aes(x=Year, y=Population)) +
  geom_line() +
  geom_point() +
  labs(title="US population from 1790 to 1910",
       x="Year",
       y="Population") +
  theme_minimal() +
  scale_y_continuous(labels = label_comma())
print(plot_USA_census_to_1910)

tables = list()
nb_tables = ceiling(dim(USA_census_to_1910)[1] / 5)
for (i in 1:nb_tables) {
  tables[[i]] = USA_census_to_1910[(5*(i-1)+1):(5*i),]
  tables[[i]] = tables[[i]] %>%
    filter(!is.na(Population)) %>% 
    mutate(across(Population, ~ format(.x, big.mark = ",")))
}
kable(tables, 
      booktabs = TRUE,
      row.names = FALSE,
      escape = FALSE)
pop = USA_census_to_1910$Population
t = USA_census_to_1910$Year
t = t - 1790
A = matrix(c(13, sum(t), sum(t^2),
             sum(t), sum(t^2), sum(t^3),
             sum(t^2), sum(t^3), sum(t^4)),
           nrow=3,byrow=TRUE)
b = c(sum(pop),
      sum(pop * t),
      sum(pop * t^2))
sol = try(solve(A,b))
print(sol)
sol_plot = function(t, sol) {
  t = t - 1790
  return(sol[1] + sol[2]*t + sol[3]*t^2)
}

ggplot(USA_census_to_1910, aes(x=Year, y=Population)) +
  stat_function(fun = function(x) sol_plot(x, sol)) +
  geom_point() +
  labs(title="US population from 1790 to 1910",
       x="Year",
       y="Population") +
  theme_minimal() +
  scale_y_continuous(labels = label_comma())
print(plot_USA_census_to_1910)


t = USA_census_to_1910$Year
P = USA_census_to_1910$Population
E = sum((P - sol_plot(t, sol))^2)

format(sol_plot(2024, sol), big.mark = ",")
tables = list()
nb_tables = ceiling(dim(USA_census)[1] / 10)
for (i in 1:nb_tables) {
  tables[[i]] = USA_census[(10*(i-1)+1):(10*i),]
  tables[[i]] = tables[[i]] %>%
    filter(!is.na(Population)) %>% 
    mutate(across(Population, ~ format(.x, big.mark = ",")))
}
kable(tables, 
      booktabs = TRUE,
      row.names = FALSE,
      escape = FALSE)


plot_USA_census = 
  ggplot(USA_census, aes(x=Year, y=Population)) +
  geom_point() +
  labs(title="US population from 1790 to 2020",
       x="Year",
       y="Population") +
  theme_minimal() +
  scale_y_continuous(labels = label_comma())
print(plot_USA_census)

t = as.double(USA_census$Year)
pop = as.double(USA_census$Population)
t = t - 1790
A = matrix(c(length(t), sum(t), sum(t^2),
             sum(t), sum(t^2), sum(t^3),
             sum(t^2), sum(t^3), sum(t^4)),
           nrow=3,byrow=TRUE)
b = c(sum(pop),
      sum(pop * t),
      sum(pop * t^2))
sol_full = try(solve(A,b))

sol_plot = function(t, sol) {
  t = t - 1790
  return(sol[1] + sol[2]*t + sol[3]*t^2)
}

plot_USA_census = 
  ggplot(USA_census, aes(x=Year, y=Population)) +
  stat_function(fun = function(x) sol_plot(x, sol_full)) +
  geom_point() +
  labs(title="US population from 1790 to 2020 (with fit)",
       x="Year",
       y="Population") +
  theme_minimal() +
  scale_y_continuous(labels = label_comma())
print(plot_USA_census)

format(sol_plot(2024, sol_full), big.mark = ",")




t = c(0)
N = c(1)
b = 0.1
d = 0.05
h = 0.2
t_f = 50
while (t[length(t)] <= t_f) {
  N = c(N, (1+h*b-h*d)*N[length(N)])
  t = c(t, t[length(t)]+h)
}
plot(t,N, 
     type = "l", lwd = 2,
     main = "Solution of the birth-death ODE using Euler's method",
     xlab = "Time (days)")

Euler_approximation_Malthus = function(p, 
                                       t_0 = 0, N_0 = 1, 
                                       h = 0.5, t_f = 50) {
  t = c(t_0)
  N = c(N_0)
  while (t[length(t)] <= t_f) {
    N = c(N, (1+h*p$b-h*p$d)*N[length(N)])
    t = c(t, t[length(t)]+h)
  }
  OUT = data.frame(t = t, N = N)
  return(OUT)
}
p = list()
p$b = 0.1
p$d = 0.05



sol1 = Euler_approximation_Malthus(p, h = 0.01)
sol2 = Euler_approximation_Malthus(p)
sol3 = Euler_approximation_Malthus(p, h = 1)
sol4 = Euler_approximation_Malthus(p, h = 5)
plot(sol1$t, sol1$N,
     type = "l", lwd = 2,
     main = "Solution of the birth-death ODE using Euler's method",
     xlab = "Time (days)")
lines(sol2$t, sol2$N, type = "l", lwd = 2, col = "red")
lines(sol3$t, sol3$N, type = "l", lwd = 2, col = "darkgreen")
lines(sol4$t, sol4$N, type = "l", lwd = 2, col = "blue")
legend("topleft",
       legend = c("h=0.01", "h=0.5", "h=1", "h=5"),
       lty = 1, lwd = 2,
       col = c("black", "red", "darkgreen", "blue"))

if (!require(deSolve)) {
  install.packages("deSolve")
  library(deSolve)
}
rhs_Malthus <- function(t, N, p) {
  with(as.list(p), {
    dN <- (b-d) * N
    return(list(dN))
  })
}
p = list()
p$b = 0.1
p$d = 0.05
IC = c(N = 1)
tspan = 0:100
sol = ode(y = IC, times = tspan, func = rhs_Malthus, parms = p)



sol = ode(y = IC, times = tspan, func = rhs_Malthus, parms = p)
head(sol, 5)



if (!require(deSolve)) {
  install.packages("deSolve")
  library(deSolve)
}
rhs_Malthus <- function(t, N, p) {
  with(as.list(p), {
    dN <- (b-d) * N
    return(list(dN))
  })
}
p = list()
p$b = 0.1
p$d = 0.05
IC = c(N = 1)
tspan = 0:100
sol = ode(y = IC, times = tspan, func = rhs_Malthus, parms = p)


rhs_logistic <- function(t, N, p) {
  with(as.list(p), {
    dN <- r * N * (1 - N/K)
    return(list(dN))
  })
}
rhs_logistic_Allee <- function(t, N, p) {
  with(as.list(p), {
    dN <- r * N * (N/A - 1) * (1 - N/K)
    return(list(dN))
  })
}
rhs_Gompertz <- function(t, N, p) {
  with(as.list(p), {
    dN <- r * N * log(K/N)
    return(list(dN))
  })
}
rhs_tumor_growth <- function(t, N, p) {
  with(as.list(p), {
    dN <- r * N * exp(-b * N)
    return(list(dN))
  })
}
rhs_logistic_harvesting <- function(t, N, p) {
  with(as.list(p), {
    dN <- r * N * (1 - N/K) - H
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

tspan = 0:100
sol_Malthus = 
  ode(y = IC, times = tspan, func = rhs_Malthus, parms = p)
sol_logistic =
  ode(y = IC, times = tspan, func = rhs_logistic, parms = p)
sol_logistic_Allee =
  ode(y = IC, times = tspan, func = rhs_logistic_Allee, parms = p)
sol_Gompertz =
  ode(y = IC, times = tspan, func = rhs_Gompertz, parms = p)
sol_tumor_growth =
  ode(y = IC, times = tspan, func = rhs_tumor_growth, parms = p)
sol_logistic_harvesting =
  ode(y = IC, times = tspan, func = rhs_logistic_harvesting, parms = p)
max_y = max(c(
  max(sol_Malthus[,"N"]),
  max(sol_logistic[,"N"]),
  max(sol_logistic_Allee[,"N"]),
  max(sol_Gompertz[,"N"]),
  max(sol_tumor_growth[,"N"]),
  max(sol_logistic_harvesting[,"N"])))

plot(sol_Malthus[,"time"], sol_Malthus[,"N"],
     type = "l", lwd = 2,
     main = "Solutions of a few ODE models",
     ylim = c(0, max_y),
     xlab = "Time (days)", ylab = "Population size")
lines(sol_logistic[,"time"], sol_logistic[,"N"],
      type = "l", lwd = 2, col = "darkred")
lines(sol_logistic_Allee, sol_logistic_Allee, 
      type = "l", lwd = 2, col = "darkgreen")
lines(sol_Gompertz, sol_Gompertz, 
      type = "l", lwd = 2, col = "darkblue")
lines(sol_tumor_growth, sol_tumor_growth, 
      type = "l", lwd = 2, col = "blue")
lines(sol_logistic_harvesting, sol_logistic_harvesting, 
      type = "l", lwd = 2, col = "red")
legend("topleft",
       legend = c("Malthus", 
                  "Logistic", 
                  "Logistic Allee", 
                  "Gompertz", 
                  "Tumor growth", 
                  "Logistic harvesting"),
       lty = 1, lwd = 2,
       col = c("black", "darkred", "darkgreen", 
               "darkblue", "blue", "red"))

