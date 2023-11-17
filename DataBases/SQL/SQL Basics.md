# SQL
```SQL
```sql
INSERT INTO Table2
    SELECT * FROM Table1 t1
    WHERE NOT EXISTS (
        SELECT * FROM Table2 t2
        WHERE t1.column1 = t2.column1
    )
```

```