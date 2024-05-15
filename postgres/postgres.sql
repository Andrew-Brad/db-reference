-- Database Size
SELECT pg_size_pretty(pg_database_size('northwind'));

-- Table Size
SELECT pg_size_pretty(pg_relation_size('table_name'));

SET enable_seqscan = OFF;
EXPLAIN (ANALYZE, COSTS, VERBOSE, BUFFERS, FORMAT JSON)
