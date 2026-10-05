
%creates a 1000 evenly spaced points between -2 and 1
w = linspace(-2,1,1000);

%finds 10^3 boundary pts for the set
%This calculates the bisection of the indicator function for
%1000 evenly spaced pts between -2 and 1. 
%0 is the lower bound because it is insdie the fractal at every x value
%100 is chosen for the upper bound because it is above the fractal at every
%x value


boundaryPoints = bisection(indicator_fn_at_x(w), 0, 100);
disp(boundaryPoints);
