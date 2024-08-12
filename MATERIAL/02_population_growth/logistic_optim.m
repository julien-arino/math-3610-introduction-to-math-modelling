function F=logistic_optim(x,xdata)

F=x(2)./(exp(-x(1).*xdata)+x(3));