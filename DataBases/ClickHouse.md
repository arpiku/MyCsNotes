#### Basic Commands

```sql

CREATE DATABASE IF NOT EXISTS helloworld
-- To create a table
CREATE TABLE helloworld.my_first_table
(
    user_id UInt32,
    message String,
    timestamp DateTime,
    metric Float32
)
ENGINE = MergeTree()
PRIMARY KEY (user_id, timestamp)

-- primary key is different than other implementation, it is also a sorting key
-- for the database, 8192 rows, 
-- primary key must be a subset of the sort order (order by)


INSERT INTO helloworld.my_first_table (user_id, message, timestamp, metric) VALUES    (101, 'Hello, ClickHouse!',                                 now(),       -1.0    ),    (102, 'Insert a lot of rows per batch',                     yesterday(), 1.41421 ),    (102, 'Sort your data based on your commonly-used queries', today(),     2.718   ),    (101, 'Granules are the smallest chunks of data read',      now() + 5,   3.14159 )

-- Formating options 
SELECT *
FROM helloworld.my_first_table
ORDER BY timestamp
FORMAT TabSeparated

clickhouse-client --host HOSTNAME.REGION.CSP.clickhouse.cloud \--secure --port 9440 \--user default \--password <password> \--query='INSERT INTO helloworld.my_first_table FORMAT CSV' < data.csv

SELECT DISTINCT(pickup_ntaname) FROM trips -- for the 'trips' dataset

SELECT round(avg(tip_amount), 2) FROM trips

SELECT
    pickup_datetime,
    dropoff_datetime,
    total_amount,
    pickup_nyct2010_gid,
    dropoff_nyct2010_gid,
    CASE
        WHEN dropoff_nyct2010_gid = 138 THEN 'LGA'
        WHEN dropoff_nyct2010_gid = 132 THEN 'JFK'
    END AS airport_code,
    EXTRACT(YEAR FROM pickup_datetime) AS year,
    EXTRACT(DAY FROM pickup_datetime) AS day,
    EXTRACT(HOUR FROM pickup_datetime) AS hour
FROM trips
WHERE dropoff_nyct2010_gid IN (132, 138)
ORDER BY pickup_datetime

--Dictionaries!!!!!!
CREATE DICTIONARY taxi_zone_dictionary(  `LocationID` UInt16 DEFAULT 0,  `Borough` String,  `Zone` String,  `service_zone` String)PRIMARY KEY LocationIDSOURCE(HTTP(URL 'https://datasets-documentation.s3.eu-west-3.amazonaws.com/nyc-taxi/taxi_zone_lookup.csv' FORMAT 'CSVWithNames'))LIFETIME(MIN 0 MAX 0)LAYOUT(HASHED_ARRAY())

-- Lifetime, setup to update with the source the dictionary


CREATE TABLE uk_price_paid(    price UInt32,    date Date,    postcode1 LowCardinality(String),    postcode2 LowCardinality(String),    type Enum8('terraced' = 1, 'semi-detached' = 2, 'detached' = 3, 'flat' = 4, 'other' = 0),    is_new UInt8,    duration Enum8('freehold' = 1, 'leasehold' = 2, 'unknown' = 0),    addr1 String,    addr2 String,    street LowCardinality(String),    locality LowCardinality(String),    town LowCardinality(String),    district LowCardinality(String),    county LowCardinality(String))ENGINE = MergeTreeORDER BY (postcode1, postcode2, addr1, addr2);

--- WILL have to update the schema to store low cardinality values like country, city etc.


INSERT INTO uk_price_paid
WITH
   splitByChar(' ', postcode) AS p
SELECT
    toUInt32(price_string) AS price,
    parseDateTimeBestEffortUS(time) AS date,
    p[1] AS postcode1,
    p[2] AS postcode2,
    transform(a, ['T', 'S', 'D', 'F', 'O'], ['terraced', 'semi-detached', 'detached', 'flat', 'other']) AS type,
    b = 'Y' AS is_new,
    transform(c, ['F', 'L', 'U'], ['freehold', 'leasehold', 'unknown']) AS duration,
    addr1,
    addr2,
    street,
    locality,
    town,
    district,
    county
FROM url(
    'http://prod.publicdata.landregistry.gov.uk.s3-website-eu-west-1.amazonaws.com/pp-complete.csv',
    'CSV',
    'uuid_string String,
    price_string String,
    time String,
    postcode String,
    a String,
    b String,
    c String,
    addr1 String,
    addr2 String,
    street String,
    locality String,
    town String,
    district String,
    county String,
    d String,
    e String'
) SETTINGS max_http_get_redirects=10;


---- IMPORTANT STUFF !!!!!!!!!!!!!!
ALTER TABLE uk_price_paid
    ADD PROJECTION projection_by_year_district_town
    (
        SELECT
            toYear(date),
            district,
            town,
            avg(price),
            sum(price),
            count()
        GROUP BY
            toYear(date),
            district,
            town
    )

-- Materialize it to run it over the entire dataset otherwise, it wil process only the newly inserted data

CREATE TABLE trips (
    trip_id             UInt32,
    pickup_datetime     DateTime,
    dropoff_datetime    DateTime,
    pickup_longitude    Nullable(Float64),
    pickup_latitude     Nullable(Float64),
    dropoff_longitude   Nullable(Float64),
    dropoff_latitude    Nullable(Float64),
    passenger_count     UInt8,
    trip_distance       Float32,
    fare_amount         Float32,
    extra               Float32,
    tip_amount          Float32,
    tolls_amount        Float32,
    total_amount        Float32,
    payment_type        Enum('CSH' = 1, 'CRE' = 2, 'NOC' = 3, 'DIS' = 4, 'UNK' = 5),
    pickup_ntaname      LowCardinality(String),
    dropoff_ntaname     LowCardinality(String)
)
ENGINE = MergeTree
PRIMARY KEY (pickup_datetime, dropoff_datetime)

--- Basic Syntax

[WITH expr_list|(subquery)]
SELECT [DISTINCT [ON (column1, column2, ...)]] expr_list
[FROM [db.]table | (subquery) | table_function] [FINAL]
[SAMPLE sample_coeff]
[ARRAY JOIN ...]
[GLOBAL] [ANY|ALL|ASOF] [INNER|LEFT|RIGHT|FULL|CROSS] [OUTER|SEMI|ANTI] JOIN (subquery)|table (ON <expr_list>)|(USING <column_list>)
[PREWHERE expr]
[WHERE expr]
[GROUP BY expr_list] [WITH ROLLUP|WITH CUBE] [WITH TOTALS]
[HAVING expr]
[ORDER BY expr_list] [WITH FILL] [FROM expr] [TO expr] [STEP expr] [INTERPOLATE [(expr_list)]]
[LIMIT [offset_value, ]n BY columns]
[LIMIT [n, ]m] [WITH TIES]
[SETTINGS ...]
[UNION  ...]
[INTO OUTFILE filename [COMPRESSION type [LEVEL level]] ]
[FORMAT format]
















```



```sql
-- ChatGPT outputs


SELECT clientId, COUNT(DISTINCT userId) AS num_users
FROM payments
WHERE paymentDate >= DATEADD(day, -7, GETDATE())
GROUP BY clientId


SELECT clientId,
       COUNT(DISTINCT userId) AS num_users,
       SUM(CASE WHEN paymentType = 'monthly' THEN 1 ELSE 0 END) AS monthly_users,
       SUM(CASE WHEN paymentType = 'weekly' THEN 1 ELSE 0 END) AS weekly_users
FROM users
GROUP BY clientId


---------

SELECT

count(distinct userId) as userCount,

count(

distinct (

case

when accessType != 1

AND toDate(createdAt) >= today() - 7 day then userId

else ''

end

)

) as WAPU,

count(

distinct (

case

when accessType != 1

AND toDate(createdAt) >= today() - 30 day then userId

else ''

end

)

) as MAPU

from

eventsBeta;
```


```sql
FOR MAPU WAPU

SELECT

COUNT (DISTINCT (CASE WHEN accessType != 1 AND toDate(createdAt) >= today() - INTERVAL 7 day then userId else '' end)) As r_users,

COUNT (DISTINCT (CASE WHEN accessType != 1 AND toDate(createdAt) >= today() - INTERVAL 30 day then userId else '' end)) As vr_users

from eventsBeta

where clientId is not null ;
```


```sql
SELECT DATE_PART('dow', purchase_date) AS day_of_week, DATE_PART('hour', purchase_date) AS hour_of_day, AVG(revenue) AS avg_revenue FROM purchases GROUP BY DATE_PART('dow', purchase_date), DATE_PART('hour', purchase_date);
```


```sql
ALTER TABLE tbl_nm ADD clm_nm <data_type>

FORIEGN KEY userId references users(id)
```