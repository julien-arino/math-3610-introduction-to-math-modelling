function xdot=logistic(t,x,p)

xdot=p.r*x*(1-x/p.K);