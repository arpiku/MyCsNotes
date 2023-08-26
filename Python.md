```python
import pymongo
from mongodb_change_streams import ChangeStream
from clickhouse_driver import Client

# Connect to MongoDB
client = pymongo.MongoClient('mongodb://localhost:27017/')
db = client['database_name']
collection = db['collection_name']

# Connect to ClickHouse
clickhouse_client = Client(host='localhost', port=9000)

# Create table in ClickHouse if it doesn't exist
clickhouse_client.execute(
    'CREATE TABLE IF NOT EXISTS database_name.collection_name '
    '(id Int64, name String, age Int64) ENGINE = MergeTree()'
)

# Create a change stream for the MongoDB collection
change_stream = ChangeStream(collection)

# Iterate over the change stream and synchronize changes with ClickHouse
for change in change_stream:
    operation_type = change['operationType']
    document = change['fullDocument']
    
    if operation_type == 'insert':
        clickhouse_client.execute(
            'INSERT INTO database_name.collection_name '
            '(id, name, age) VALUES',
            [(document['_id'], document['name'], document['age'])]
        )
    elif operation_type == 'update':
        clickhouse_client.execute(
            'UPDATE database_name.collection_name SET '
            'name = {}, age = {} WHERE id = {}'.format(
                document['name'], document['age'], document['_id']
            )
        )
    elif operation_type == 'delete':
        clickhouse_client.execute(
            'DELETE FROM database_name.collection_name WHERE id = {}'.format(
                document['_id']
            )
        )

```