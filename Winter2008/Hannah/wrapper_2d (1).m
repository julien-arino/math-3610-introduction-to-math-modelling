function error_value=wrapper_2d(v)
% This function returns the error_value, i.e., the square of the distances
% between data points and simulation points, given the vector v of 
% parameters to optimize with respect to.

% Note that this function is called every time a solution is being tested.
% So the only parameters that are changed in this function are the ones
% that really need to, i.e., r and K. All other parameters should be set
% once and for all in the main program.

% The optimization routine does not accept parameters, so the parameter
% structure p must be given global scope (when calling wrapper, not for
% running simulations).
global p;

% Set the values of r and K
p.gmax=v(1);
p.C=v(2);

% Call the numerical solver. Note that we want the values at the exact same
% dates as provided in the data. So instead of calling with the classical
% time span, we provide a vector of dates for which we want values. We have
% these dates: they are the ones in the data, p.dates
% Set more stringent error control
%options=odeset('RelTol',1e-4,'AbsTol',1e-7);
options=[];
[t,x]=ode45(@rhs_growth,p.dates,p.IC,options,p);

s=(x(:,1)-p.population).^2; %This is the vector of square of differences
error_value=sum(s);    %And the sum of elements of this vector (the error)