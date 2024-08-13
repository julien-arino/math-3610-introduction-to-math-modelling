% In general, avoid global variables. Here, however, the optimization
% routine does not accept parameters, so we have to give p global scope.
% Note that this is done in every function/script that needs access to p
% using the global scope, before any reference to p is made
global p;

p.tspan=[0 14]; %The time span of the solution (not used at first)
p.IC=21.7;          %The initial condition (in t=0)

% Set the parameters r and K. Not really useful here, since they will be
% changed by the optimizer, but these can be taken as initial guesses. Note
% that the order in the call to wrapper is r,K.
p.r=0.05;
p.K=30;           

% Input the data
p.dates=0:14; %Dates are easy
p.dates=[p.dates,20];
p.population=[21.7;22.7;24.1;25.5;26.4;27.5;28.7;30.1;31.5;33.4;34.4;35.5;36.3;37.5;38.6];
p.population=[p.population;50];

e=wrapper([p.r;p.K]); %Example output.

% Search using regular routine
options=optimset('Display','iter');
result=fminsearch(@wrapper,[p.r;p.K],options);
% Search using genetic algorithm. Be careful: in this case, the procedure
% is a maximization routine, so wrapper must be adapted.
%parspace=[zeros(1,nb_betas);ones(1,nb_betas)*10];
%[be,st]=gagordy('wrapper',parspace,[20,-1,0.15,2,20000,500,0.5,50,0])

% We now compute a solution for the parameter values found. We set the
% values of r and K to the values found by the minimization.
p.r=result(1);
p.K=result(2);
% We compute the solution over tspan, not only at the know dates
[t,N]=ode45(@rhs_logistic,p.tspan,p.IC,[],p);
% We plot the solution and the data
plot(t,N,p.dates,p.population,'*')
xlabel('Time (days)');
ylabel('Height (centimetres)');
xlim([t(1) t(end)])