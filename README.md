# AMS-595---MATLAB-Project-2---Gabriel-Krivoshey
# Mandelbrot Boundary Project

This project uses the Mandelbrot iteration

\[
z_{n+1} = z_n^2 + c, \qquad z_0 = 0,
\]

to locate points on the fractal boundary, approximate the upper boundary with
a degree-15 polynomial, and calculate the arc length of that approximation.

## Files and grading requirements


## 1. Escape-iteration function: `fractal.m`

```matlab
it = fractal(c)
```

**Input**

- `c` — a complex number representing a point in the complex plane.

**Output**

- `it` — the iteration number at which `abs(z)` first becomes greater than
  `2.0`.
- Return `0` when the point does not diverge within 100 iterations.

For example, `fractal(3)` returns `1`, `fractal(1)` returns `3`, and
`fractal(1i)` returns `0` because its orbit stays bounded for the allowed
iterations.

## 2. Bisection function: `bisection.m`

```matlab
m = bisection(fn_f, s, e)
```

**Inputs**

- `fn_f` — an indicator function that is negative at `s` and positive at `e`.
- `s` — lower endpoint, inside the Mandelbrot set.
- `e` — upper endpoint, outside the Mandelbrot set.

**Output**

- `m` — an approximation to the boundary point where the indicator changes
  sign.

At every step, bisection evaluates the midpoint. If that midpoint is outside
the set, it becomes the new upper endpoint; otherwise it becomes the new
lower endpoint. The process continues until the interval is close to machine
precision.

## 3. Indicator function and boundary points

Use `indicator_fn_at_x.m` to make an indicator function along a vertical
line at a fixed real coordinate `x`:

```matlab
function fn = indicator_fn_at_x(x)
    fn = @(y) (fractal(x + 1i*y) > 0) * 2 - 1;
end
```

Here, `x + 1i*y` represents the complex point \(c = x + iy\). The indicator
returns `-1` for a non-diverging point (inside the set) and `+1` for a
diverging point (outside the set).

For each selected `x`, use `s = 0` and `e = 2` only when `s` is inside and
`e` is outside. Store the result as an `(x,y)` pair. The set is symmetric
about the real axis, so an upper-boundary value `y` also gives a lower point
at `-y`.

The boundary data should have two columns:

```text
x-coordinate, upper-boundary y-coordinate
```

Points to the right of approximately `x = 0.25` do not have an upper
Mandelbrot boundary point on their vertical line. They should be excluded or
stored as `NaN`, rather than passed to bisection without a sign-change
bracket.

## 4. Degree-15 polynomial fit

Run [`fit_fractal_boundary.m`](fit_fractal_boundary.m) after creating the
boundary data. The script accepts either:

- a two-column matrix named `boundaryValues` in the MATLAB workspace, or
- a two-column CSV file named `mandelbrot_boundary_values.csv` in MATLAB's
  current folder.

It first plots all boundary data. Then it selects the actual curved boundary
using hand-tuned limits (`xMin` and `xMax`), calls

```matlab
p = polyfit(x(usePoint), y(usePoint), 15);
```

and plots the resulting degree-15 polynomial together with the selected data.
The selected range must exclude flat or non-boundary points. The supplied
starting range is `-1.95 <= x <= 0.24`; inspect the plot and adjust it if
needed for the generated data.

## 5. Polynomial arc length: `poly_len.m`

```matlab
l = poly_len(p, s, e)
```

**Inputs**

- `p` — coefficient vector returned by `polyfit`.
- `s` and `e` — left and right `x` limits of the same region used for the
  polynomial fit.

**Output**

- `l` — numerical arc length of the fitted polynomial.

The function uses `polyder(p)` to calculate the polynomial derivative and
evaluates

\[
L = \int_s^e \sqrt{1 + (p'(x))^2}\,dx.
\]

Example:

```matlab
upperLength = poly_len(p, xMin, xMax);
fullLength = 2 * upperLength;
```

`fullLength` uses symmetry to estimate the length of both the upper and lower
fitted boundaries. It is the length of the polynomial approximation, not the
exact Mandelbrot boundary, whose shape is fractal.

## Suggested run order

1. Save the functions as `fractal.m`, `bisection.m`, `indicator_fn_at_x.m`,
   and `poly_len.m`.
2. Run the boundary-point script to calculate at least 1,000 `(x,y)` data
   rows and save them as `boundaryValues` or
   `mandelbrot_boundary_values.csv`.
3. Run `fit_fractal_boundary.m` and inspect its plots. Adjust `xMin` and
   `xMax` if flat points are included.
4. Use the returned coefficient vector `p` with `poly_len(p, xMin, xMax)`.
