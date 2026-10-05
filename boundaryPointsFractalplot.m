
xValues = linspace(-2, 1, 1001);
upperBoundary = NaN(size(xValues));

for k = 1:length(xValues)
    x = xValues(k);
    fn = indicator_fn_at_x(x);

    s = 0;  % bottom point: must be inside
    e = 2;  % top point: outside

    % Only bisect when this vertical line actually crosses the set
    if fn(s) < 0 && fn(e) > 0
        upperBoundary(k) = bisection(fn, s, e);
    end
end

figure
plot(xValues, upperBoundary, '.')
hold on
plot(xValues, -upperBoundary, '.')
axis equal
xlabel('Real part of c')
ylabel('Imaginary part of c')
title('Mandelbrot Fractal Boundary')