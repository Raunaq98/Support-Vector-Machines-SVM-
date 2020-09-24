# Hyperplane

A hyperplane divides a ***p-dimensional*** space into 2 parts. As the dimensions increase, the hyperplace also changes.
For exmaple, simple point for 1D, line for 2D, plane in 3D and so on.

# Maximal Margin Classifier

When a margin divides data, there are perpendicular distances to data points from this margin. The smallest distances ( or distances ) is called
the ***margin***.  In case of Maximal Margin Classsifier, we want maximum value of margins. Hence, it is the farthest closest point for a certain hyperplane.
Limitations:

              - Cannot be used when the data cannot be divided by a hyperplane
              - It is very sensitive to support vectors. For this we use support vector classifiers.

# Support Vectors

The points through wwhich the margin line passes are called ***support vectors***. These were the points from which margin was evaluated in the first place. Other points are not important anymore as classification is now done on the basis of these support vectors.

# Support Vector Classifiers

These are ***soft margin classsifiers*** that can handle cases where data cannot be separated by a hyperplane. The model too becomes less sensitive to margins.
As it is soft margin, two cases arise :

            - The datapoint is on the wrong side of the margin but on the correct side of
              the hyperplane    = currectly classified
            - The datapoint is on the wrong side of the margin and the opposite side of
              the hyperplane    = incorrect classification
             
Support Vector Classifiers   =    Maximal Margin Classifiers +  B
                                    wheree, B is the misclassification budget.
                                    
              sum of distancees of points on wrong side of margin < B
              
In R, we us Cost C which is inversely related to Budget B.    **C = 1/B**              
