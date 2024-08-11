chdir('G:/Hannah/Diff_Evol')
getf('DiffEvol.sci')    // Differential Evolution function [adapt PATH]
getf('hannah.sci')       // Function to minimize            [adapt PATH]

// Initialization and run of differential evolution optimizer.
// A simpler version with fewer explicit parameters is in run0.m
//
// Change relevant entries to adapt to your personal applications
//

// VTR		"Value To Reach" (stop when function value < VTR)
// Hannah: you will have to change this. A low value means a better fit, but 
// might not work.
		VTR = 3; 

// D		number of parameters of the objective function 
		D = 2; 

// XVmin,XVmax  column vector of lower and upper bounds of an initial population
//    		the algorithm seems to work well only if [XVmin,XVmax] 
//    		covers the region where the global minimum is expected
//               *** note: these are no bound constraints!! ***
		XVmin = [0;0]; 
		XVmax = [1;1];

// Give p global scope
		global p;
		
		p.tspan=[0 14]; // The time span of the solution (not used at first)
p.IC=[21.7;2];      // The initial condition (in t=0)

// Set the parameters r and K. Not really useful here, since they will be
// changed by the optimizer, but these can be taken as initial guesses. Note
// that the order in the call to wrapper is r,K.
p.r=0.05;
p.K=30;           

p.C=1;
p.D=1;
p.s0=0.4;
p.Ch=5;

// Input the data
p.dates=0:14; //Dates are easy
p.dates=[p.dates,20];
p.population=[21.7,22.7,24.1,25.5,26.4,27.5,28.7,30.1,31.5,33.4,34.4,35.5,36.3,37.5,38.6];
p.population=[p.population,50];

		
// y		problem data vector (will be passed to the user's function
//                                   transparently)
		y=p.population; 

// NP           number of population members
		NP = 15; 

// itermax      maximum number of iterations (generations)
		itermax = 200; 

// F            DE-stepsize F ex [0, 2]
//              this has 2 components for stragies 3 and 8
		F = 0.8;

// CR           crossover probabililty constant ex [0, 1]
		CR = 0.8; 

// strategy       1 --> DE/best/1/exp           6 --> DE/best/1/bin
//                2 --> DE/rand/1/exp           7 --> DE/rand/1/bin
//                3 --> DE/rand-to-best/1/exp   8 --> DE/rand-to-best/1/bin
//                4 --> DE/best/2/exp           9 --> DE/best/2/bin
//                5 --> DE/rand/2/exp           else  DE/rand/2/bin

		strategy = 7

// report       intermediate output will be produced after "report"
//              iterations. No intermediate output will be produced
//              if report is < 1
		report = 10; 

[x,f,nf] = DiffEvol(hannah,VTR,D,XVmin,XVmax,y,NP,itermax,F,CR,strategy,report)

