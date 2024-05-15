-- You might now have VIEW STATE permissions in a production environment
-- Keep in mind there are a number of dependent objects - stoplists, languages, etc.
GRANT VIEW DEFINITION
    ON FULLTEXT CATALOG :: [Catalog_Name]
    TO [andrew.brad];

-- Get running count of populated items and completion stats
SELECT
    FULLTEXTCATALOGPROPERTY(cat.name,'ItemCount') AS [ItemCount],
    FULLTEXTCATALOGPROPERTY(cat.name,'MergeStatus') AS [MergeStatus],
    FULLTEXTCATALOGPROPERTY(cat.name,'PopulateCompletionAge') AS [PopulateCompletionAge],
    FULLTEXTCATALOGPROPERTY(cat.name,'PopulateStatus') AS [PopulateStatus],
    FULLTEXTCATALOGPROPERTY(cat.name,'ImportStatus') AS [ImportStatus]
FROM sys.fulltext_catalogs AS cat

-- Current Population Status
DECLARE @CatalogName VARCHAR(MAX)
SET     @CatalogName = 'Name_Of_FullText_Catalog'

SELECT
    DATEADD(ss, FULLTEXTCATALOGPROPERTY(@CatalogName,'PopulateCompletionAge'), '1/1/1990') AS LastPopulated
    ,(SELECT CASE FULLTEXTCATALOGPROPERTY(@CatalogName,'PopulateStatus')
        WHEN 0 THEN 'Idle'
        WHEN 1 THEN 'Full Population In Progress'
        WHEN 2 THEN 'Paused'
        WHEN 3 THEN 'Throttled'
        WHEN 4 THEN 'Recovering'
        WHEN 5 THEN 'Shutdown'
        WHEN 6 THEN 'Incremental Population In Progress'
        WHEN 7 THEN 'Building Index'
        WHEN 8 THEN 'Disk Full.  Paused'
        WHEN 9 THEN 'Change Tracking' END) AS PopulateStatus
FROM sys.fulltext_catalogs AS cat


-- Get size of the FTI across tables
SELECT 
   [Table] = OBJECT_SCHEMA_NAME(table_id) + '.' + OBJECT_NAME(table_id), 
   [Size_in_KB] = CONVERT(DECIMAL(12,2), SUM(data_size/1024.0))
 FROM sys.fulltext_index_fragments
 -- WHERE table_id = OBJECT_ID('dbo.specific_table_name')
 GROUP BY table_id;

 -- Catalog sys tables/views from the docs:
 -- https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/full-text-search-and-semantic-search-catalog-views-transact-sql?view=sql-server-ver15

 SELECT TOP 20 * FROM sys.fulltext_catalogs WITH(NOLOCK)