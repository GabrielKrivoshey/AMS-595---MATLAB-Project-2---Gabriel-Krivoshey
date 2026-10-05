
%after 0.25 no sampled vertical line reaches the fractal boundary

n = 1000;
xValues = linspace(-2, 0.25, n);
upperBoundary = NaN(size(xValues));

for k = 1:n
    fn = indicator_fn_at_x(xValues(k));

    if fn(0) < 0 && fn(2) > 0
        upperBoundary(k) = bisection(fn, 0, 2);
    end
end

% One row per sampled x: [x-coordinate, upper-boundary y-coordinate,lower boundary y coordinate]
boundaryValues = [xValues(:), upperBoundary(:),-upperBoundary(:)];

disp(boundaryValues)
writematrix(boundaryValues, 'mandelbrot_boundary_values.csv')