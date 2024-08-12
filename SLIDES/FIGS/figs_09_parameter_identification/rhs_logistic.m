function dN=rhs_logistic(t,N,p)
% This function returns the value of dN/dt 
% at the point (t,N), using parameters in the 
% structure p

dN=p.r*N*(1-N/p.K);
