L=[0 0.0043 0.1123 0;.9775 0.9111 0 0;0 .0736 0.9534 0;0 0 0.0452 0.9804];
% primitivity
M=L*L
N=M*L
T=N*L
W=T*L
x0=[10;60;110;70];
X=zeros(4,51);
X(:,1)=x0;
%simulations
for k=2:51, X(:,k)=L*X(:,k-1); end
t=0:50;
plot(t,X);
xlabel('Time');
ylabel('Population');
legend('Yearlings', 'Juveniles', 'Mature females','Post-reproductive females')
% limiting behavior
L=[0 0.0043 0.1123 0;.9775 0.9111 0 0;0 .0736 0.9534 0;0 0 0.0452 0.9804];
Value=eig(L);
dominating=max(Value)
[V,D]=eig(L)
