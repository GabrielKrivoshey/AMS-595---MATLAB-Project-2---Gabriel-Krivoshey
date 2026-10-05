% FIT_FRACTAL_BOUNDARY
% Script: fit a 15th-order polynomial to the curved, upper boundary of the
% Mandelbrot data calculated in the previous part of the project.
%
% Expected input: a two-column matrix called boundaryValues, or the CSV file
% mandelbrot_boundary_values.csv.  Column 1 is x and column 2 is the upper
% boundary y.  NaN values are allowed for x values with no boundary point.

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

% Plot all calculated points before choosing the fitting interval.
figure
plot(x, y, '.', 'DisplayName', 'All calculated upper-boundary data')
grid on
xlabel('Real part, x')
ylabel('Upper boundary, y')
title('Mandelbrot boundary data: choose the curved region')

% Hand tuned limits: exclude the flat/non-boundary portions at the ends.
% Adjust these after inspecting the plot if your boundary data differs.
xMin = -1.86;
xMax = 0.21;

usePoint = isfinite(x) & isfinite(y) & y > 0 & x >= xMin & x <= xMax;

if nnz(usePoint) < 16
    error('At least 16 selected points are required for a degree-15 fit.')
end

polynomialOrder = 15;
p = polyfit(x(usePoint), y(usePoint), polynomialOrder);

xFit = linspace(min(x(usePoint)), max(x(usePoint)), 2000);
yFit = polyval(p, xFit);

% Compare the selected fractal points with the polynomial approximation.
figure
plot(x(usePoint), y(usePoint), '.', ...
    'DisplayName', 'Selected fractal-boundary points')
hold on
plot(xFit, yFit, 'r-', 'LineWidth', 1.5, ...
    'DisplayName', '15th-order polynomial fit')
grid on
axis equal
xlabel('Real part, x')
ylabel('Upper boundary, y')
title('Degree-15 polynomial approximation of the Mandelbrot boundary')
legend('Location', 'best')

% p contains the 16 polynomial coefficients, highest power first.
disp('Degree-15 polynomial coefficients:')
disp(p)