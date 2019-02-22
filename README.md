# gen_fractal
A Processing file that draws any regular polygon and runs the following algorithm:
1. draws a random point
2. chooses a random vertex on the polygon
3. moves point coordinates to a position halfway between random vertex and last location
4. draws a new point at location
5. repeats steps 2-4 indefinetely

Inspired by the fact that if the polygon is an equilateral triangle, the pattern formed is a Sierpinski Triangle.
