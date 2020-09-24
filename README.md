# Hyperplane

A hyperplane divides a ***p-dimensional*** space into 2 parts. As the dimensions increase, the hyperplace also changes.
For exmaple, simple point for 1D, line for 2D, plane in 3D and so on.

# Maximal Margin Classifier

When a margin divides data, there are perpendicular distances to data points from this margin. The smallest distances ( or distances ) is called
the ***margin***.  In case of Maximal Margin Classsifier, we want maximum value of margins. Hence, it is the farthest closest point for a certain hyperplane.
Limitations:

              - Cannot be used when the data cannot be divided by a hyperplane
              - It is very sensitive to support vectors.

# Support Vectors

The points through wwhich the margin line passes are called ***support vectors***. These were the points from which margin was evaluated in the first place. Other points are not important anymore as classification is now done on the basis of these support vectors.

