-- Top 10 most resource-intensive queries
SELECT TOP 10 
    total_worker_time / execution_count as avg_cpu_time,
    total_logical_reads / execution_count as avg_logical_reads,
    total_elapsed_time / execution_count as avg_elapsed_time,
    query_hash,
    SUBSTRING(qt.text, (qs.statement_start_offset/2) + 1,
        ((CASE qs.statement_end_offset
            WHEN -1 THEN DATALENGTH(qt.text)
            ELSE qs.statement_end_offset
        END - qs.statement_start_offset)/2) + 1) AS query_text
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt
ORDER BY avg_cpu_time DESC