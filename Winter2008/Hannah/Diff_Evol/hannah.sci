function result = hannah(x,y);
// Objective function for Differential Evolution
//
// Input Arguments:   
// ---------------
// x                  : parameter vector to be optimized
// y                  : data vector (remains fixed during optimization)
//
// Output Arguments:
// ----------------
// result              : objective function value
//

global p;

// Set the values of r and K
p.gmax=x(1);
p.C=x(2);

// Call the numerical solver. Note that we want the values at the exact same
// dates as provided in the data. So instead of calling with the classical
// time span, we provide a vector of dates for which we want values. We have
// these dates: they are the ones in the data, p.dates
x=ode("rkf",p.IC,0,p.dates,list(rhs_growth,p));

s=(x(1,:)-p.population).^2, //This is the vector of square of differences
result=sum(s);    //And the sum of elements of this vector (the error)

endfunction
