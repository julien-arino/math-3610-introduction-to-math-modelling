t=0:0.01:10;

lambda=5;

alpha=10;
omega=2;

d1=alpha*sin(omega*t);

Psi= alpha.*(omega-omega*exp(lambda*t).*cos(omega*t)+lambda.*exp(lambda*t).*sin(omega*t)) ...
    ./(lambda^2+omega^2);
Phi=alpha.*(lambda^3.*t+lambda*t*omega^2-lambda^2+omega^2).*sin(omega*t).*exp(lambda*t) ...
    ./((lambda^2+omega^2)^2) ...
    -(alpha*omega*cos(omega*t).*(t*lambda^2+t*omega^2-2*lambda).*exp(lambda*t) ...
    +2*alpha*lambda*omega)./((lambda^2+omega^2)^2);


d2=lambda.*exp(-lambda*t).*Psi;
d3=lambda^2.*exp(-lambda*t).*(t.*Psi-Phi);


plot(t,d1,t,d2,':',t,d3,'-.');
legend('Driver 1','Driver 2','Driver 3');