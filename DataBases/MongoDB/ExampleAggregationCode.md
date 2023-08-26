## Example aggregation Code

~~~python
from pymongo import MongoClient

# Requires the PyMongo package.
# https://api.mongodb.com/python/current

client = MongoClient('')
result = client['dataBaseName']['collectionName'].aggregate([
    {
    #Following is a basic aggregation pipeline
        '$project': {
            'clientId': 1,
            'createdAt': 1,
            'funnelStage': 1,
            'paywallType': 1,
            'action': 1
        }
    }, {
        '$sort': {
            'createdAt': -1
        }
    }
])
~~~

The above code uses things called *operators* [[OperatorsMogoDB]], to apply condition to incoming data and output the resutls in the same kind of 
documet structures it was stored in the first place.

There are multiple ways to solve the same problem, the MongoDB software suit GUI *MongDB compass* aslo provides aggregation tab to 
do the aggregation without much programming "directly" and then resulting code can be exported in the desired *driver* language.

