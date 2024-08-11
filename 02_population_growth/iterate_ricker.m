f=inline('x.*exp(r.*(1-x))','x','r')

r=2.1;

x=[0.1];

for i=1:100,
    x=[x;f(x(end),r)];
end;