// We go to the directory where the .sci files are located (adapt to your case)
chdir('/windows_home/Textes/Cours/math3820/Winter2008/Hannah')

// In scilab, functions must be loaded into memory before they are used.
getf('wrapper_2d.sci')
getf('rhs_growth.sci')

// In general, avoid global variables. Here, however, the optimization
// routine does not accept parameters, so we have to give p global scope.
// Note that this is done in every function/script that needs access to p
// using the global scope, before any reference to p is made
global p;

p.tspan=[0,14]; // The time span of the solution (not used at first)
p.IC=[21.7;2];      // The initial condition (in t=0)

// Set the parameters r and K. Not really useful here, since they will be
// changed by the optimizer, but these can be taken as initial guesses. Note
// that the order in the call to wrapper is gmax,C.
p.C=1;
p.gmax=1;
p.D=1;
p.s0=0.4;
p.Ch=5;

// Input the data
p.dates=0:14; //Dates are easy
p.dates=[p.dates,20];
p.population=[21.7,22.7,24.1,25.5,26.4,27.5,28.7,30.1,31.5,33.4,34.4,35.5,36.3,37.5,38.6];
p.population=[p.population,50];

// Search using regular routine
[error_size,result]=optim(wrapper_2d,[p.gmax,p.C]);

// We now compute a solution for the parameter values found. We set the
// values of r and K to the values found by the minimization.
p.r=result(1);
p.K=result(2);
// We compute the solution over tspan, not only at the know dates
[t,N]=ode45(@rhs_logistic,p.tspan,p.IC,[],p);
// We plot the solution and the data
plot(t,N,p.dates,p.population,'*')
xlabel('Time (days)');
ylabel('Height (centimetres)');
xlim([t(1) t(end)])
