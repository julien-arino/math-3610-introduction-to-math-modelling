function ydot = logistic_dde_rhs(t,y,Z,p)

% p is the parameter structure. Elements are accessed by "dotting"; e.g.,
% p.r is r.


N=y(1);
% Vector of delays. As we have only one delay, it takes the form
Nlag = Z(:,1);

% Allocate result vector
ydot = zeros(1,1);

ydot(1) = p.r*N*(1-Nlag/p.K);
