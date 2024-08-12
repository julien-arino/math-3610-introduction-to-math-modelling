
### Data
years <- seq(1790,2000
             ,10)

pop = c(3.92, 5.308, 7.240,9.638, 12.866, 17.069, 23.192, 31.443, 38.558 , 50.156, 
        62.948, 76.212, 92.228, 106.021, 123.202, 132.164, 151.325, 179.323, 203.302, 226.542, 248.709, 281.421)


plot(years,pop,
     xlab="Year",ylab="Population (in millions)",
     col="red", pch=16)


### function
sum_tkl = function(t,l=1) {
  s = sum(t^l)
  return(s)
}

sum_Pk_tkl = function(P,t,l=1) {
  s = sum(P*t^l)
  return(s)
}

sum_logPk_tkl = function(P,t,l=1) {
  s = sum(log(P)*t^l)
  return(s)
}

###

A = mat.or.vec(3,3)
d = mat.or.vec(3,1)
A[1,1] = sum_tkl(years,0)
A[1,2] = sum_tkl(years,1)
A[1,3] = sum_tkl(years,2)
A[2,1] = sum_tkl(years,1)
A[2,2] = sum_tkl(years,2)
A[2,3] = sum_tkl(years,3)
A[3,1] = sum_tkl(years,2)
A[3,2] = sum_tkl(years,3)
A[3,3] = sum_tkl(years,4)
d[1] = sum_Pk_tkl(pop,years,0)
d[2] = sum_Pk_tkl(pop,years,1)
d[3] = sum_Pk_tkl(pop,years,2)

solve(A,d)


###
years_shift = years - 1790

A[1,1] = sum_tkl(years_shift,0)
A[1,2] = sum_tkl(years_shift,1)
A[1,3] = sum_tkl(years_shift,2)
A[2,1] = sum_tkl(years_shift,1)
A[2,2] = sum_tkl(years_shift,2)
A[2,3] = sum_tkl(years_shift,3)
A[3,1] = sum_tkl(years_shift,2)
A[3,2] = sum_tkl(years_shift,3)
A[3,3] = sum_tkl(years_shift,4)
d[1] = sum_Pk_tkl(pop,years_shift,0)
d[2] = sum_Pk_tkl(pop,years_shift,1)
d[3] = sum_Pk_tkl(pop,years_shift,2)

solve(A,d)

x = solve(A,d)
a = x[1]
b = x[2]
c = x[3]

years_cont = seq(min(years_shift),max(years_shift),0.1)
plot(years,pop,
     xlab="Year",ylab="Population",
     col="red", pch=16, lwd=5,bg = "red",xaxt = "n",yaxt = "n")
lines(years_cont+1790,a+b*years_cont+c*years_cont^2)


###Exponential
sum_logPk_tkl = function(P,t,l=1) {
  s = sum(log(P)*t^l)
  return(s)
}

A_ = mat.or.vec(2,2)
d_ = mat.or.vec(2,1)

A_[1,1] = sum_tkl(years,0)
A_[1,2] = sum_tkl(years,1)
A_[2,1] = sum_tkl(years,1)
A_[2,2] = sum_tkl(years,2)

d_[1] = sum_logPk_tkl(pop,years,0)
d_[2] = sum_logPk_tkl(pop,years,1)

solve(A_,d_)

x_ = solve(A_,d_)
a_ = x_[1]
b_ = x_[2]



plot(years,pop,
     xlab="Year",ylab="Population",
     col="red", pch=16, lwd=5,bg = "red",xaxt = "n",yaxt = "n")
lines(years_cont+1790,a+b*years_cont+c*years_cont^2)
lines(years,exp(a_)*exp(b_*years),col="blue")



###Using R function
a = 1
b = 1
c = 1
fit = nls(pop ~ a+b*years_shift+c*years_shift^2,start=list(a=a,b=b,c=c))
summary(fit)
a = coef(fit)["a"]
b = coef(fit)["b"]
c = coef(fit)["c"]
