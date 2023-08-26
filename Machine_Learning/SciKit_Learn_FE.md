# SciKet-Learn
https://archive.ics.uci.edu/ml/datasets/Car+Evaluation


~~~python
#Simple ploting of graph
import matplotlib.pyplot as plt
x = [i for i in range (10)]
y = [i*i for i in range (10)]
plt.plot(x,y)
plt.xlabel('testX')
plt.ylabel('testY')
~~~

### Features :
1. They are independent variables, that act as the input to the machine learning model, and the correct answers are the **labels**, they are also can be called *attributes*.
### Labels :
1. They are the dependent variables or the output that we get from features, they are also called *classes*
2. Features and labels are in a matrix form, where the flow from left to right show the dependicies. 
## Supervised learning - Classification

1. In *classification* the algorithms goes through the data and looks for similarites in attributes and seprates them in *classes*, the method presented here will use KNN to perform the classifcation.
### KNN
1. The 'K' values is defined, it looks into the cluster of points and finds the nearest neighbours and then cluster them together, there is also a parameter 'w', that can give a bias to the clustering, here the division is between 'distance' and 'uniform', with 'distance', the closer points will get higher 