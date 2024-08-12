function ydot = logistic_ode_rhs(t,y,Z,p)

% p is the parameter structure. Elements are accessed by "dotting"; e.g.,
% p.gamma is gamma.

% Allocate result vector
ydot = zeros(1,1);

% N=y(1)

ydot(1) = p.gamma*y(1)-p.mu*y(1)-p.kappa*y(1)^2;
