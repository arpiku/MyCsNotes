https://stackoverflow.com/questions/46571842/how-do-i-make-buckets-according-to-date-in-mongodb

1. Bucketing based on date
~~~javascript
db.foo.aggregate([
  {$group: {_id:"$timestamp", n:{$sum:1}}}
  ,{$addFields: {datestr: {$dateToString: {format: "%Y-%m-%d", date: "$_id"}}}}

              ]);
~~~

2. A nice way to program
~~~python

import pandas as pd
from pymongo import MongoClient


def _connect_mongo(host, port, username, password, db):
    """ A util for making a connection to mongo """

    if username and password:
        mongo_uri = 'mongodb://%s:%s@%s:%s/%s' % (username, password, host, port, db)
        conn = MongoClient(mongo_uri)
    else:
        conn = MongoClient(host, port)


    return conn[db]


def read_mongo(db, collection, query={}, host='localhost', port=27017, username=None, password=None, no_id=True):
    """ Read from Mongo and Store into DataFrame """

    # Connect to MongoDB
    db = _connect_mongo(host=host, port=port, username=username, password=password, db=db)

    # Make a query to the specific DB and Collection
    cursor = db[collection].find(query)

    # Expand the cursor and construct the DataFrame
    df =  pd.DataFrame(list(cursor))

    # Delete the _id
    if no_id:
        del df['_id']

    return df
~~~
