

if ~exist('boundaryValues', 'var')
    dataFile = 'mandelbrot_boundary_values.csv';
    if ~isfile(dataFile)
        error(['Create boundaryValues first, or place ', dataFile, ...
            ' in the current MATLAB folder.'])
    end
    boundaryValues = readmatrix(dataFile);
end

x = boundaryValues(:, 1);
y = boundaryValues(:, 2);




%I looked at the plot of the polynomial and the polynomial is close from
%x = -1.86 to x = 0.21
xMin = -1.86;
xMax = 0.24;

usePoint = isfinite(x) & isfinite(y) & y > 0 & x >= xMin & x <= xMax;

if nnz(usePoint) < 16
    error('At least 16 selected points are required for a degree-15 fit.')
end

polynomialOrder = 15;
p = polyfit(x(usePoint), y(usePoint), polynomialOrder);


% Estimate the polynomial length over the selected interval
%The polynomail approxmates the upper half
upperLength = poly_len(p, xMin, xMax);

%the mandrel set is symmetrical, so upper length is half the the length of
%the whole thing
fullLength = 2 * poly_len(p, xMin, xMax);

fprintf('Approxmate Length of fractal: %.6f\n',fullLength);