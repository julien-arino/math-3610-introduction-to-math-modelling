L=[1 4;.1 0];
% primitivity
M=L*L
N=M*L
T=N*L
W=T*L
x0=[10;6];
X=zeros(2,3);
X(:,1)=x0;
%simulations
for k=2:3, X(:,k)=L*X(:,k-1); end
t=0:2;
plot(t,X);
xlabel('Time');
ylabel('Population');
legend('0-year', '1-year')
% limiting behavior
L=[1 4;.1 0];
Value=eig(L);
dominating=max(Value)
[V,D]=eig(L)
