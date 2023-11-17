# Naive Bayes Filtering
![[Gaussian_Naive_Bayes_Classifier_print-3080416416.png]]
For [[Research _ RE]]
[[Simple Singular value decomposition]]
[[Alternating least squares]] is one the best methods for optimization.
[[ALS Implicit Collaborative Filtering]]
### Basics
## **Implicit data**

Implicit data is nothing but the feedback that we collect from customers in the form of clicks, purchases, number of views e.t.c. Main features of implicit data are

1.  **No Negative feedback :** In explicit data, customers express both their positive and negative feedback explicitly. Rest of the data points where there is no value are treated as missing values. But in implicit data, we have only positive feedback like clicks, purchases e.t.c and there is no way to tell if the missing data is because the customer did not like the item or is not aware of that
2.  **Inherently noisy :** Although implicit data is inherently noisy, the sheer volume of it compensates for this drawback and helps in building robust recommender systems.
3.  **Preference vs confidence :** In explicit data, ratings exclusively refer to customer’s preference with the numerical value showing the magnitude of preference. In case of implicit data, numerical value often refers to a frequency which might not necessarily reflect the magnitude of customer’s preference. Hence, there is a need to deduce a confidence metric that shows customer’s confidence

