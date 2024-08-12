% In general, avoid global variables. Here, however, the optimization
% routine does not accept parameters, so we have to give p global scope.
% Note that this is done in every function/script that needs access to p
% using the global scope, before any reference to p is made
global p;

p.tspan=[1790 2000]; %The time span of the solution (not used at first)
p.IC=3.929;          %The initial condition (in 1790)

% Set the parameters r and K. Not really useful here, since they will be
% changed by the optimizer, but these can be taken as initial guesses. Note
% that the order in the call to wrapper is r,K.
p.r=0.5;
p.K=300;           

% Input the data
p.dates=1790:10:2000; %Dates are easy, from 1790 to 2000 by steps of 10
p.population=[3.929;5.308;7.240;9.638;12.866;17.069;23.192;31.443; ...
    38.558;50.156;62.948;76.212;92.228;106.021;123.202;132.164;151.325; ...
    179.323;203.302;226.542;248.709;281.421];

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
xlabel('Time (years)');
ylabel('Population (millions)');
xlim([t(1) t(end)])