close all;

% In general, avoid global variables. Here, however, the optimization
% routine does not accept parameters, so we have to give p global scope.
% Note that this is done in every function/script that needs access to p
% using the global scope, before any reference to p is made
global p;

p.tspan=[0 14]; %The time span of the solution (not used at first)

% Set the parameters gmax and C. Not really useful here, since they will be
% changed by the optimizer, but these can be taken as initial guesses. Note
% that the order in the call to wrapper is gmax,C.
p.gmax=10;
p.C=1;

p.D=1;
p.s0=0.5;

p.K=1; %Conversion factor

p.Ch=25;

% Input the data
p.dates=0:14; %Dates are easy
height_tomato=[21.7;22.7;24.1;25.5;26.4;27.5;28.7;30.1;31.5;33.4;34.4;35.5;36.3;37.5;38.6];
height_mum=[11.1;12.1;12.9;13.9;15.5;15.3;16.0;16.8;17.6;18.3;19.1;19.9;20.3;20.8;21.5];
height_lobelia=[7.7;7.9;8.4;9.2;9.7;10.2;10.4;10.7;11.0;12.3;12.0;12.5;13.2;13.7;14.1];

% Choose the plant you want
p.height=height_mum;

p.ICs=1;
p.IC=[p.height(1);p.ICs];          %The initial condition (in t=0)

% Search using regular routine. 
% The vector params_searched contains the parameters to identify. Remember to modify the order 
% accordingly in wrapper_2d.m
param_searched=[p.gmax;p.C;p.s0;p.K;p.ICs];
options=optimset('Display','iter');
result=fminsearch(@wrapper_2d,param_searched,options);
% Search using genetic algorithm. Be careful: in this case, the procedure
% is a maximization routine, so wrapper must be adapted.
%parspace=[zeros(1,nb_betas);ones(1,nb_betas)*10];
%[be,st]=gagordy('wrapper',parspace,[20,-1,0.15,2,20000,500,0.5,50,0])

% We now compute a solution for the parameter values found. We set the
% values of r and K to the values found by the minimization.
p.gmax=result(1);
p.C=result(2);
p.s0=result(3);
p.K=result(4);
% Set more stringent error control
%options=odeset('RelTol',5e-4,'AbsTol',5e-7);
options=[];
% We compute the solution over tspan, not only at the know dates
[t,x]=ode45(@rhs_growth,[0 14],p.IC,options,p);
% We plot the solution and the data
plot(t,x(:,1),p.dates,p.height,'*')
xlabel('Time (days)');
ylabel('Height (centimetres)');
%xlim([t(1) t(end)])
