clear;
set(0,'DefaultAxesFontSize',18);
time=40;
beta=.3;%.3
b=.2;%.2
gamma=b;
N=100;
s(1)=70;
i(1)=30;
for t=1:time
    s(t+1)=s(t)-beta*i(t)*s(t)/N+b*(N-s(t));
    i(t+1)=i(t)*(1-gamma-b)+beta*i(t)*s(t)/N;
    r(t+1)=N-s(t+1)-i(t+1);
end
plot([0:1:time],s,'bo',[0:1:time],i,'rx',[0:1:time],r,'c:','LineWidth',2);
xlabel('t');
legend('S','I','R');