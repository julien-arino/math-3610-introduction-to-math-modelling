close all;
clear all;

beta=0.5;
gamma=1/7;

N0=1000;
I0=1;
S0=N0-I0;

S=1:S0;

hold on;
axes([0 N0 0 200])
for var=0:0.1:2,
    beta=var;
    plot(S,S-gamma/beta*log(S)+I0-(S0-gamma/beta*log(S0)));
end;