function dN=rhs_logistic_octave(t,N)
% This function returns the value of dN/dt 
% at the point (t,N), using parameters in the 
% structure p

global p;

dN=p.r*N*(1-N/p.K);
