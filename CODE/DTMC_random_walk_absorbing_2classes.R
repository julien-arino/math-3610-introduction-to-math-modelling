# Example simulation of a simple SIS model
library(markovchain)

# Let us make a slightly more interesting chain
# Total population
nb_states = 11
# Parameters
proba_left = 0.4
proba_right = 0.6

# Make the transition matrix
T = mat.or.vec(nr = nb_states, nc = nb_states)
for (row in 2:(nb_states-1)) {
  T[row,(row-1)] = proba_left
  T[row,(row+1)] = proba_right
}
# States 1 and 2 communicate but cannot go to the rest of the chain
T[1,1] = 1
# State nb_states is absorbing
T[nb_states, nb_states] = 1

mcRW <- new("markovchain", 
            states = sprintf("S_%d", 1:nb_states),
            transitionMatrix = T,
            name = "RW_abs2")

# Show some info about the chain
summary(mcRW)

# We can also easily plot
plot(mcRW)

canonicForm(mcRW)

meanAbsorptionTime(mcRW)

# Note that for S1 and S2, here, the absorption probabilities are shared:
# this should be read as probability of being absorbed in the {S1,S2} recurrent class
absorptionProbabilities(mcRW)

hittingProbabilities(mcRW)


require(DTMCPack)
IC = rep(0, nb_states)
IC[6] = 1
DTMC(T, IC, 50, trace=TRUE)

