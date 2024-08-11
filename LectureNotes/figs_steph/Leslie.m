L=[2 3;2 1];x0=[1;1];
X=zeros(2,21);
X(:,1)=x0;
%simulations
for k=2:21, X(:,k)=L*X(:,k-1); end
t=0:20;
plot(t,X);
xlabel('Time');
ylabel('Population');
legend('First variable', 'Second variable');
% limiting behavior


% L=[0 4 3;.5 0 0;0 .25 0];x0=[10;10;10];
% X=zeros(3,11);
% X(:,1)=x0;
% %simulations
% for k=2:11, X(:,k)=L*X(:,k-1); end
% t=0:10;
% plot(t,X);
% xlabel('Time');
% ylabel('Population');
% legend('First age class', 'Second age class', 'Third age class')
% % limiting behavior
% L=[0 4 3;.5 0 0;0 .25 0];
% [V,D]=eig(L);
