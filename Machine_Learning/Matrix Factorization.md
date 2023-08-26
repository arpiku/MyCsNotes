# Matrix Factorization
https://medium.com/radon-dev/als-implicit-collaborative-filtering-5ed653ba39fe

The idea is basically to take a large (or potentially huge) matrix and factor it into some smaller representation of the original matrix. You can think of it in the same way as we would take a large number and factor it into two much smaller primes. We end up with two or more lower dimensional matrices whose product equals the original one.

## Reducing dimensions
When we talk about collaborative filtering for recommender systems we want to solve the problem of our original matrix having millions of different dimensions, but our “tastes” not being nearly as complex. Even if i’ve viewed hundreds of items they might just express a couple of different tastes. Here we can actually use matrix factorization to mathematically reduce the dimensionality of our original “all users by all items” matrix into something much smaller that represents “all items by some taste dimensions” and “all users by some taste dimensions”. These dimensions are called **_latent or hidden features_** and we learn them from our data.

**The idea is to basically take the large matrix with a rank in millions and representing it in something that more digestable**

**If we can express each user as a vector of their taste values, and at the same time express each item as a vector of what tastes they represent.** You can see we can quite easily make a recommendation. This also gives us the ability to find connections between users who have no specific items in common but share common tastes.