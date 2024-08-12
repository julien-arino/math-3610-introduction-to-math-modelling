close all;

P=[3.929,5.308,7.240,9.638,12.866,17.069,23.192,31.443,38.558,50.156,...
    62.948,76.212,92.228,106.021,123.202,132.164,151.325,179.323,...
    203.302,226.542,248.709,281.421];

t=1790:10:2000;

format long g

plot(t,P,'*');

x0 = [1, 1,300]                    % Starting guess
[x,resnorm] = lsqcurvefit(@logistic_optim,x0,t,P);

plot(t,P,t,x(2)./(exp(-x(1).*t)+x(3)))

figure;
x0 = [50, 50,300]                    % Starting guess
options=optimset('MaxFunEvals',5000,'MaxIter',600);
[x,resnorm] = lsqcurvefit(@logistic_optim,x0,t,P,[],[],options);

plot(t,P,t,x(2)./(exp(-x(1).*t)+x(3)))
