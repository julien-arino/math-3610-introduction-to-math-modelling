tspan=[1790 2000]; %The time span of the solution
IC=3.929;          %The initial condition (in 1790)
global p;
p.K=300;           %Set the parameters
p.r=0.5;
opt=odeset('InitialStep',0.05,'MaxStep',1);
[t,N]=ode45(@rhs_logistic_octave,tspan,IC,opt,p);
plot(t,N);
xlim([t(1) t(end)]);
ylim([N(1) N(end)+10]);