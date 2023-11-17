# Basics in ML
https://machinelearningmastery.com/basic-concepts-in-machine-learning/

1. Machine learning on the very basic level is getting the computers to program themselves, if programming does automation, then ML automates that process of automation itself.
- One can see writing software as a bottleneck, why not let data(that we have a lot of now) do the the work, ML is the way to make programming scalable.
- A very simple picture differentiating ML with traditional programming: 
- ![[Traditional-Programming-vs-Machine-Learning-768x545.webp]]
## Application of machine learning
-   **Web search**: ranking page based on what you are most likely to click on.
-   **Computational** biology: rational design drugs in the computer based on past experiments.
-   **Finance**: decide who to send what credit card offers to. Evaluation of risk on credit offers. How to decide where to invest money.
-   **E-commerce**:  Predicting customer churn. Whether or not a transaction is fraudulent.
-   **Space exploration**: space probes and radio astronomy.
-   **Robotics**: how to handle uncertainty in new environments. Autonomous. Self-driving car.
-   **Information extraction**: Ask questions over databases across the web.
-   **Social networks**: Data on relationships and preferences. Machine learning to extract value from data.
-   **Debugging**: Use in computer science problems like debugging. Labor intensive process. Could suggest where the bug could be.


## Key Elements to machine learning
Every mahcine learning algorithm has three components: 
1. **Representation** : How the data is represneted. Ex. [[decision trees]], [[set of rules]], [[instances]], [[graphical models]], [[neural network]], [[support vector machines]], [[model ensemble]], [[etc_ml_models]]. Is machine learning compression in some sense? 
2. **Evaluation** : How the resulting candidate program is going to be tested. Ex. [[accuracy]], [[predication and recalll]], [[squared error]], [[likelihood]], [[posterior probability]], [[cost]], [[margin]], [[entropy]], [[k-L divergence]].
3. **Optimization** The way the candidate programs are generated. Ex. [[combinatorial optimization]], [[convex optimization]], [[constrained optimization]].
All machine learning algorithms are combinations of these three components. A framework for understanding all algorithms.

## Methods of learning
- **Supervised learning** : Training with labeled data, i.e data that has already been labeled, and letting the program figure out the pattern. This has training data with the desired output.
- **Unsupervised learning** : In this training data does not have desired output, e.g would include something like clustering. It is a bit more difficult to learn what is good learning and what is not.
- **Semi-supervised learning** : Training data has some desired data, i.e labeled information.
- **Reinforcement learning** : Rewards from a sequence of acitons. The most 'AI' in all of these learnings, and the most ambitious one too.

NOTE : Supervised learning is the most mature, the most studied and the type of learning used by most machine learning algorithms. Learning with supervision is much easier than learning without supervision.

## Inductive learning 
Here we will focus on this, this the main concept behind supervised learning.
In this we are given the domain and range of a function f(x), and the programs job is to figure out the f(x'), where x' is new data, which was not there in the training domain, the method can be divided into three sub-fields[[Induction in maths]]:

- **Classification** : Where the function is discrete.
- **Regression** : Where the funciton is continous.
- **Probabilty** **Estimation** : When the output of the fuction is a probability.


### Understanding Inductive learning
As explained before it takes the domain x of a function f(x) and we have the correct outputs for a bunch of the domain, hence the goal becomes to get a function estimate or a mapping from domain to range, that then can be used to give results for new data.

In practice, it is extremely hard to completely model a function, so what we are looking for is a good enough approximation.

Note: Don't think of x and f(x) as one-dimensional function, infact in most cases x represents a grid of attributes, i.e an n-dimension matrix.

Some example of inductive learning:
-   **Credit risk assessment**.
    -   The x is the properties of the customer.
    -   The f(x) is credit approved or not.
-   **Disease diagnosis**.
    -   The x are the properties of the patient.
    -   The f(x) is the disease they suffer from.
-   **Face recognition**.
    -   The x are bitmaps of peoples faces.
    -   The f(x) is to assign a name to the face.
-   **Automatic steering**.
    -   The x are bitmap images from a camera in front of the car.
    -   The f(x) is the degree the steering wheel should be turned.


### Use of Inductive learning:
Following are some good use of Inductive learning
4 problems where inductive learning might be a good idea:

-   **Problems where there is no human expert**. If people do not know the answer they cannot write a program to solve it. These are areas of true discovery.
-   **Humans can perform the task but no one can describe how to do it**. There are problems where humans can do things that computer cannot do or do well. Examples include riding a bike or **driving a car.**
-   **Problems where the desired function changes frequently**. Humans could describe it and they could write a program to do it, but the problem changes too often. It is not cost effective. Examples include the stock market.
-   **Problems where each user needs a custom function**. It is not cost effective to write a custom program for each user. **Example is recommendations of movies or books on Netflix or Amazon**.

## Some important discussion on Inductive learning:
Writing a function that perfectly fits the test data is not enough as the behvious is important on new inputs, and at that might a function might end up being really bad.
Hence that data is not enough, as the prediction can be anything, this would be a situation where we are assuming nothing about the problem, hence human ingenuity needs to play a role to properly define the parameters

We can give 1000s of classifier to our program as input states, but that would be just stupidly resource intensive and inefficienct. 

We can form hypotheses about what our functions and how it should work, how it should luck, but these theories then need to be tested against real world scenarios.

Now we present two major ideas in inductive thinking:
- **Learning is removal of uncertainty** : Having data removes some uncertainty, and the goal becomes to remove more uncertainty.
- **Learning is guessing a good and small hyphothesis class** : We do guessing, we don't know the answer, we are using trial and error to figure things out, but if the domain is atleast properly defined then we are not aiming in the dark.

**Here we can be wrong:**
- Our prior knowledge can be wrong.
- Our guess of hypothesis class can be wrong.



## A structure for Inductive learning :
Terminology used in machine learning:

-   **Training example**: a sample from x including its output from the target function
-   **Target function**: the mapping function f from x to f(x)
-   **Hypothesis**: approximation of f, a candidate function.
-   **Concept**: A boolean target function, positive examples and negative examples for the 1/0 class values.
-   **Classifier**: Learning program outputs a classifier that can be used to classify.
-   **Learner**: Process that creates the classifier.
-   **Hypothesis space**: set of possible approximations of f that the algorithm can create.
-   **Version space**: subset of the hypothesis space that is consistent with the observed data.

#### The three concerns when choosing :
-   **Size**: number of hypotheses to choose from
-   **Randomness**: stochastic or deterministic
-   **Parameter**: the number and type of parameters

#### The properties that can be considered when choosing an algo:
-   **Search procedure**
    -   **Direct computation**: No search, just calculate what is needed.
    -   **Local**: Search though the hypothesis space to refine the hypothesis.
    -   **Constructive**: Build the hypothesis piece by piece.
-   **Timing**
    -   **Eager**: Learning performed up front. Most algorithms are eager.
    -   **Lazy**: Learning performed at the time that it is needed
-   **Online vs Batch**
    -   **Online**: Learning based on each pattern as it is observed.
    -   **Batch**: Learning over groups of patterns. Most algorithms are batch.


#### Key issues in machine learning:

-   What are good hypothesis space?
-   What algorithms work with that space?
-   What can I do to optimize accuracy on unseen data?
-   How do we have confidence in the model?
-   Are there learning problems that are computationally intractable?
-   How can we formulate application problems as machine learning problems?
