--https://docs.microsoft.com/en-us/sql/relational-databases/search/improve-the-performance-of-full-text-queries?view=sql-server-ver15
-- Restrict your choice of full-text key columns to a small column. Although a 900-byte column is supported, we recommend using a smaller key column in a full-text index. int and bigint provide the best performance.

--Defragment the index of the base table
ALTER INDEX FTI_NAME ON [dbo].[table] REORGANIZE WITH ( 
--FILLFACTOR = 80,
--SORT_IN_TEMPDB = ON,
--STATISTICS_NORECOMPUTE = ON,
ONLINE = ON);
GO

-- Rebuild/org the Catalog itself
ALTER FULLTEXT CATALOG ftCatalog REBUILD
WITH ACCENT_SENSITIVITY=OFF;
--REORGANIZE; -- 
GO