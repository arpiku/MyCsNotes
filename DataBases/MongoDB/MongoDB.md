# MongoDB


MongoDB is something called NoSQL database using JSON documents to store data, the data is represented strucutres that are similar to the concept of 'structs' in C++, the data then can be accessed using any of the available 
driver langugae including Python, C++, JavaScript or C#.

[[ExampleAggregationCode]].


# Aggregation 

Aggregation is one of the most important tools available in MongoDB

[[aggregation.jpeg]]

aggragation in MongoShell looks like this 
~~~python
db.<collection_name>.aggregate([])
~~~

where '[]' takes in the array of MongoDB *operators* [[OperatorsMogoDB]], to process the documents in desired manner.