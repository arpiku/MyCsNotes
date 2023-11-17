# Research on recommendation engines:
ijcatr06021005.pdf [[ijcatr06021005.pdf]]
1. The techniques discussed in this paper are [[Content Based filtering]] [[Collaborative filtering ]] [[Hybrid Content-content based filtering]] [[k-mean clustering Based]] [[Naive Bayes filtering]]
2. [[Matrix Factorisation]]
3. [[Churn]]
4. [[Latent Dirichlet allocation]] for unsupervised article tagging.

## Google news recommendation system
http://www2007.org/papers/paper570.pdf

They use collaborative filtering system for building their news recommendation system.
Methods used:
1. [[MinHash clustering]]
2.[[ Probabilistic Latent Semantic Indexing (PLSI)]]
3.[[ Convisitation counts ]]

**Approach is content agnostic and con-  
sequently domain independent, making it easily adaptable  
for other applications and languages with minimal effort**

NOTE: Data Science is different in the sense that it is in-fact more of a research field rather than a professional product creation methodology, the problems need to approached with an R&D mindset rather than creation of a product ASAP philosophy seen in software engineering.

## Issues:
1. The dataset Google is dealing with is extremely dynamic (which is not the case a lot of times) facing changes every few minutes, this means a strategy where the model is retrained for new data ever so often is usable as the compute requirements would be unreasonable.
2. The scale of amazon is similar however because they use it on products their data more or less remains static for long durations, that is not the case with something like news.

## Problem Stament:
1. Google deals with 4,500 news sources, with varying languages and regions and combine them together for personalised recommendation.
2. If not logged in the recommendation are generally based on stop stories in general, however still being representative of the zeitgeist of the user's place.
3. If logged in Google does the following things:
	1. Record your clicks on news articles from it's search engine.
	2. Show 'For you' section for recommended stories based on history of clicks.
4. **Assumption:** How the clicks are collected is not considered and it is assumed that it's a positive metric.
5. **Issue with assumption:** While clicks can be used to capture positive user interest, they don’t say anything about a user’s negative interest.
6. A set of users U, a set of content stories S, and a set of content stories read by user Cu to create a set of recommendations K.
7. This recommendation needs to be done instantly once the user is in to give instant gratification.
8. Google's recommendation system only has few millisecond do all this, as rest of the time is consumed when creating the webpage for display. 

### Our Issue vs google's issue
1. **While google used free content and their recommendation snippets are so good that the user might not click even if they are interested, because they get satisfied just by the snippet!, which in contrast to us where we need to convince them enough to pay for a story.** 
2. The overlapping part is the fact that we might use good recommendation to convert flyby user user to a flirt over time.

### Scale of google: 
1. Several million of news articles churning every month with per user having hundreds if not thousands of clicks.
2. The strict time requirement as mentioned earlier to process all the necessary information.

## Understanding their approach.
1. Both the **Content based filtering**  and **Collaborative filtering systems** have been used for while for news recommendation systems.
2. Definitions: 
	1. **Content-based filtering** Uses item features to recommend other items similar to what the user likes, based on their previous actions or explicit feedback.
	2. **Collaborative filtering :** Collaborative filtering uses _similarities between users and items simultaneously_ to provide recommendations. This allows for serendipitous recommendations; that is, collaborative filtering models can recommend an item to user A based on the interests of a similar user B. Furthermore, the embeddings can be learned automatically, without relying on hand-engineering of features, they are also typically **content-agnostic** (*definition below*).
	 Note : Matrix factorisation is Collaborative filtering technique.
3. **Google however took a more general approach to the problem**, their system is **content agnostic**, i.e it can be used for recommendation in general not just for news but for images, music, videos etc.
4. **NOTE!!: They do admit that a simple content based filtering system might do just as good, which is something they need to explore.**

## **Their algorithms:**  
**Memory-Based algorithm :** Weighted average of the ratings given by other users where the weight is proportional to the “similarity” between users. The similarity is calculated using something like **cosine-similarity**( what was initially proposed for content similarity), or  Pearson correlation coefficient.
$$r_{u_a},s_k =

\Sigma_{i\neq a} I(u_i,s_k)w(u_a, u_i)$$


This technique however was not suitable for google due to the following reasons:
- Not scalable to the extend of problem's needs.
- Prediction of old and stale news, irrelevant due to extreme churn rate.

**Model-Based algorithm** : Instead of relying on data from previous encounters, try to **model** the user based on the past behaviour and then use that, this is done using cluster and bayesian models. Simply classify the user into a particular type (i.e a politics fanatic, a sports guy etc.) 
Algos : latent semantic indexing (LSI), Bayesian clustering, probabilistic latent semantic indexing (PLSI), multiple multiplicative Factor Model, Markov Decision process  and Latent Dirichlet Allocation.

Issues :
	- Very compute expensive, not scalable
	- A single user might have multiple interest and that is not well represented in this method.
	- 
# **TLDR for google**'s  approach
Google used a hybrid approach where they combined both of these techniques primarily marliy employing the following algos: 
1. [[MinHash clustering]] (Later locality sensitive hashing is used.)
2.[[ Probabilistic Latent Semantic Indexing (PLSI)]]
3.[[ Covisitation counts ]]

using PLSI and MinHash for clustering (memory based approach) and then Covisitation counts (model approach).
All of these algorithms would be used to give a story a score based on user preference, the weights however were pre-selected, later they want to look into applying SVM to the problem.

The system presented both offline and online computation, with two servers handling different computation needs while two databases handle different data needs.
There is plenty of parallelisation  and caching of data to keep things efficient.

# Results!
1. They have have used different servers for updating the data, and computation of the said data for recommendation.
2. They used the **Popular algorithm** (simple recommendation based on number of clicks) as their baseline for comparison sion.
3. Any of the individual algorithms on their actually performed much better than the Popular algorithm, however not all of their combinations were that good, in fact combining MinHash and PLSI gave worse results!
4. The combination of all three was on an average 38% better than the popular algorithm.


# Takeaways:
1. A base model to understand how we may deploy our system.
2. A methodology to test our system.
3. Some of the information may be directly applicable, we can use the **action** info of anonymous users to score the stories.

# Issues:
1. The parallelised  and cached structure would need to figured out.
2. The data the were generating was of the size of 80 GB.
3. The offline and online computation cost and how these metrics would be defined in our case.
4. Are there existing code bases that can be used to implement all of the algorithms or something custom would need to be built for our needs.



