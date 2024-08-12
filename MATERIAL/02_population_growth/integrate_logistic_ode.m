% This vector contains the time span, that is, the interval of time over
% which we are computing the solution.
tspan=[0;5];

% The parameters of the equation. In order to be able to change send them
% from this context to the RHS (right hand side) function, we use a
% structure. The alternative would be to declare them directly in the RHS
% function, but in that case, we would not be able to change the value from
% here.
p.r=2;
p.K=100;

% The following command freezes the display. This way, all of the figures
% produced in the loop that follows are ploted on the same figure. Without
% this command, only the last figure would appear.
hold on;
% The following is a loop on the value of IC, the initial condition.
% The command takes the form
% for value=initial_value:step:final_value,
%   command or commands to be repeated;
% end;

%for IC=10:10:150,
    % This is the call to the numerical integration routine.
%    [t,y]=ode45(@logistic,tspan,IC,[],p);
    % This plots the result. Since "hold on" was issued before the loop,
    % all the results appear on the same figure.
%    plot(t,y);
%end;

for K=10:10:100,
    p.K=K;
    [t,y]=ode45(@logistic,tspan,15,[],p);
    plot(t,y);
end;