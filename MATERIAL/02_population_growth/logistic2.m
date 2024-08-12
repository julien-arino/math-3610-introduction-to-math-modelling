function xdot=logistic(t,x)

r=2;
K=100;

xdot=r*x*(1-x/K);