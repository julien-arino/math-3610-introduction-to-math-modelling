close all;
clear all;

% Fill up the p structure that contains the parameters
% Demographic parameters
p.Pi=0.0351;
p.d=1/(78*365);
% Disease related parameters
p.beta=0.5;
p.gamma=1/7;
p.nu=1/365;
p.delta=1/100;


tspan=[0 100];
IC=[100,1,0];

[t,x]=ode45(@rhs_SIRS_MA,tspan,IC,[],p);

figure;
plot(t,x);
legend('S','I','R');
xlabel('Time (days)');
ylabel('Number of individuals');

figure;
plot3(x(:,1),x(:,2),x(:,3));
xlabel('S');
ylabel('I');
zlabel('R');

