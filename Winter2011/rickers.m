close all;
k=1:100;
N=k*0;
N(1)=2;

K=100;
r=2.1;

for i=k,
	N(i+1)=N(i)*exp(r*(1-N(i)/K));
end;

plot([k,101],N)