clear all;
close all;
rmin = input('Enter the minimum value of r (0 < r < 4): ');
rmax = input('Enter the maximum value of r (0 < r < 4): ');
figure(1);
axis([rmin rmax 0 1]); hold on;

mMax = 501; % the number of points between rmin and rmax
for m = 1 : mMax
    r = rmin + (rmax-rmin)*(m-1)/(mMax-1);
    x = 0.5; % the starting value in a sequence
    n = 1000; % the number of elements in a sequence
    for k = 1:n
        x = r*x*(1 - x); % running n iterations to settle at a stationary regime
    end
    X(1) = x;
    for k = 1:n
        X(k+1) = r*X(k)*(1-X(k)); % running another n iterations to display a stationary regime
    end
    R = r*ones(1,n+1); % the vector R has the same structure as the vector X
    plot(R,X,'.r','MarkerSize',3); % plot the values of a sequence xk in a stationary regime
end
xlabel('\mu'); ylabel('x^*'); hold off;
