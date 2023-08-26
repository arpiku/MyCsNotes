[[t-SNE]]
- **t-distributed stochastic neighbour embedding** (**t-SNE**) is a [statistical](https://en.wikipedia.org/wiki/Statistical "Statistical") method for visualising high-dimensional data by giving each datapoint a location in a two or three-dimensional map. It is based on Stochastic Neighbour Embedding originally developed by Sam Roweis and [Geoffrey Hinton](https://en.wikipedia.org/wiki/Geoffrey_Hinton "Geoffrey Hinton").
- The embedding is done by finding the similarity between two high dimentional datapoints, that is doing using the value
- 
- ![[Pasted image 20230306132930.png]]
- In the above (i != j) and set pi|i = 0 and ![[Pasted image 20230306133053.png]] . As Van der Maaten and Hinton explained, the similarity is equal to the conditional probability pj|i, the xi would pick xj as it's neighbour.

- Now you can define ![[Pasted image 20230306133209.png]] 

