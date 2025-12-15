# Data inspection
- Jag börjar med att kolla vilka tabeller som hittades.

- Detta hämtar datan från DuckDB om vilka tabeller som finns i schemat 'lab_database'

```sql tables_in_db
select table_name, table_schema
from information_schema.tables
where table_schema = 'lab_database'
```

```sql my_actors
select * from lab_database.actors
limit 5
```