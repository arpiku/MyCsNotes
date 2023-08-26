[[AAAMLP.pdf]]

1. [[Clustering]] is one of the methods to  tackle unlabeled data.
2. To make sense of unsupervised we can use [[decomposition]] techniques.
3.  Supervised problems are easier in the sense that they can be evaluated easily.
4. [[Cross_Validation]] :
 # Cross Validation:
 1. cross-validation is a step in the process of building a machine learning model which  
helps us ensure that our models fit the data accurately and also ensures that we do  
not #overfit.

5. [[t-SNE]] [[Principal Component Analysis]].
6. [[decision trees]], can be used as a classifier as seen in the code of red-wine.ipy [[Code/]]
7. Issues raised during the coding part. Handling NaN values in the data is a major issue.
8. We see that the best score for test data is obtained when max_depth has a value of . As we keep increasing the value of this parameter, test accuracy remains the  
same or gets worse, but the training accuracy keeps increasing. It means that our  
simple decision tree model keeps learning about the training data better and better  
with an increase in max_depth, but the performance on test data does not improve  
at all.:
- This is amazing, it means there's a sweet spot when it comes to training your model and getting useful information out of it, too much training will only lead to overfitting.
- *Another definition of overfitting would be when the  
test loss increases as we keep improving training loss*

9. **Whenever we train a neural network, we must monitor loss during the training time  
for both training and test set. If we have a very large network for a dataset which is  
quite small (i.e. very less number of samples), we will observe that the loss for both  
training and test set will decrease as we keep training. However, at some point, test  
loss will reach its minima, and after that, it will start increasing even though training  
loss decreases further. We must stop training where the validation loss reaches its  
minimum value.**

10. ***Occam’s razor* in simple words states that one should not try to complicate things  
that can be solved in a much simpler manner**

# Cross Validation
1. There are many different ways one can do cross-validation, and it is the most critical  
step when it comes to building a good machine learning model which is  
generalizable when it comes to unseen data.

2. However, there are a few types of cross-validation techniques which are the most popular and widely used :
	1. [[K-Fold Cross Validation]]
	2. [[Stratified K-Fold Cross Validation]]
	3. [[Hold Out Based Validation]]
	4. [[Leave One Out Validation]]
	5. [[Group K-Fold Validation]]

3. One can seperate the data set into multiple sets, **test**, **train**, **validation**.
4. **We can split any data into k-equal parts using [[KFold from scikit-learn]]. Each sample  
is assigned a value from 0 to k-1 when using k-fold cross validation.**

5. When using very scewed dataset the simple K-Fold cross validation scheme is not that great, as one might end up with all the bias in a sinlge fold, using stratified KFold is bette since it will keep the number of positive and negative examples uniform across the board.
6. 