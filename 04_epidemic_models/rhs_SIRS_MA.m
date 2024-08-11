function xprime=rhs_SIRS_MA(t,x,p)
% Vector field of the SIRS epidemic model with mass action incidence

% Inputs: 
% t, the time (only needed for nonautonomous systems, but required 
% for the call to the function. 
% x, the state of the system.
% p, the parameter structure.
% Outputs:
% xprime, vector that contains the value of f(x)

S=x(1);
I=x(2); %Matlab is okay with variables called I. Be careful, though,
%if going from matlab to maple, since the latter thinks I=sqrt(-1).
R=x(3);

xprime=zeros(3,1);

xprime(1) = p.Pi+p.nu*R-p.beta*S*I-p.d*S;
xprime(2) = p.beta*S*I-(p.d+p.delta+p.gamma)*I;
xprime(3) = p.gamma*I-(p.d+p.nu)*R;