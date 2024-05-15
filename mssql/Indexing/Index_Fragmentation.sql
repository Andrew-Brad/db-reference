-- All fragmented indexes on current db, % fragmentation > 30 
SELECT indexStats.index_id               AS [IndexId], 
       OBJECT_NAME(indexStats.object_id) AS [ObjectName], 
       NAME, 
       avg_fragmentation_in_percent      AS [Percentage Fragmentation] 
FROM   sys.Dm_db_index_physical_stats(Db_id(Db_name()), NULL, NULL, NULL, NULL) 
       AS 
       indexStats 
       JOIN sys.indexes AS b
         ON indexStats.object_id = b.object_id 
            AND indexStats.index_id = b.index_id 
WHERE  avg_fragmentation_in_percent > 30 
ORDER  BY avg_fragmentation_in_percent DESC; 

GO

-- Execute a manual rebuild for all indexes on a given table 
ALTER INDEX ALL ON dbo.nportexception rebuild WITH ( 
--FILLFACTOR = 80,  
--SORT_IN_TEMPDB = ON, 
--STATISTICS_NORECOMPUTE = ON, 
ONLINE = ON); 

GO