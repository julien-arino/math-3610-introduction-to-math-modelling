close all;

f=inline('r*N*(1-N/K)','N','r','K');

r=3.9;
K=100;
N0=51;

N=[N0];

tend=50;

for i=1:tend,
    Ntmp=f(N(end),r,K);
    N=[N;Ntmp];
end;

t=0:tend;

plot(t,N);