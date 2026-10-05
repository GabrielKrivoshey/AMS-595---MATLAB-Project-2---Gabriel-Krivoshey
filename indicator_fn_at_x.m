function fn = indicator_fn_at_x(x)

% returns an indicator function along a vertical line at a given x
% it uses equivalence of logical variables ( true - 1 , false - 0)
% to produce a value of 1 for divergence and -1 for no divergence



%{
The set being 
"Any point c for which z > 2.0 before 100 iterations is not in the set"


This function will return a 1 if the given x value is outside the set
and a -1 inside the set

This because if the  input into fractal function 
does not diverge i.e the function returns 0, then 0 > 0 will be false and 
evaluated as 0. and 0*2 - 1 is -1

And if the input into the fractal function does diverge i.e the # of
iterations is >0 the function will return a number >0 and 
thus fractal(x + 1i * y ) > 0 will be evaluated as 1
and 1*2 - 1 is 1

This function tests the 2d space a vertical line at a time 
%}
fn = @(y) (fractal(x + 1i * y) > 0) * 2 - 1;