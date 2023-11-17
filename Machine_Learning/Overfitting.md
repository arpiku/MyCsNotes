
# Overfitting

1. This is when the trained model tries too hard to stick to the training data and is very strict in it's classification.
2. For exmple a model trained on a singular model of car would refuse to recoganize any other car as a car.
3. **When our model fails to generalize well.**
![[Overfitting.png]]
### Similar
1. Similar to this there is the concept of underfitting where the model is way to forgiving, and gives results that are not at all closed to the what is required.

## How to detect and resolve it.
1. Divide the dataset into training, validation, and test dataset.
2. [[K-Fold Cross Validation]]
3. Start with a simple model that underfits or fits well and then add features and functionality as you go, do the oposite if starting with a rather complex model already.
4. Stop just when the error between validation and test is low.
5. Prevent neurons from having very large positive or negative weights.
6. We can randomaly kill these neurons in order to force other neurons to adapt to those changes.
7. 