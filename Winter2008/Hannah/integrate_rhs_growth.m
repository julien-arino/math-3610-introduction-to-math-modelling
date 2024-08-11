% Set initial conditions
h0=0;
s0=1;
IC=[h0;s0];

% Set time span in the form [begin_time end_time]
tspan=[0 21];

% Call the numerical integrator
[t,x]=ode45(@rhs_growth,tspan,IC);

% Plot the solution
plot(t,x);
legend('h','s')