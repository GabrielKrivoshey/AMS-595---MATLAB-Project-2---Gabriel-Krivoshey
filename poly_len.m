function l = poly_len(p, s, e) 

%first derative of p 
dp = polyder(p);% Coefficients of the derivative polynomial



% Parameterize the arc length integrand from the polynomial derivative
%This function gives you a function that is equal to indefinite 
%intergal of ds

ds = @(x) sqrt(1 + polyval(dp, x).^2);
% Define the accumulated arc length from the parameter origin to x





% Arc length must be nonnegative, even if inputs are reversed
l = integral(ds, min(s, e), max(s, e));
end
