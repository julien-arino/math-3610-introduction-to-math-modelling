close all; 
clear all;

% PARAMETERS
% Logistic growth
p.b=1;
p.d=.5;
p.K=100;

p.r=p.b-p.d;

% Delay
p.tau=4;

IC=[60];
tend=200;
tspan=[0,tend];

opts_dde=[];
opts_ode=odeset('RelTol',1e-8,'AbsTol',1e-12);

sol = dde23('logistic_dde_rhs',p.tau,IC,tspan,opts_dde,p);

plot(sol.x,sol.y)
xlabel('Time');
ylabel('N(t)','Rotation',0);