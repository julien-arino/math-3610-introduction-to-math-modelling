function dx=rhs_growth(t,x,p)

// Set h=x(1) and s=x(2) for clarity
h=x(1);
s=x(2);

// Compute g(s)
g=p.gmax*s/(p.C+s);

// First form of the equations
// dx=[h',s']
//dx=[g*p.K;-g];
// Second form of the equations
// dx=[h',s']
dx=[g*p.K*(1-h/(p.Ch+h));p.D*(p.s0-s)-g];

endfunction
