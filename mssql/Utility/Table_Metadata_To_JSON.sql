DECLARE @json NVARCHAR(max) = NULL;

SET @json =
( 
       SELECT DB_NAME() AS dbname, 
              t.table_type, 
              c.table_name, 
              c.table_schema, 
              c.column_name, 
              c.ordinal_position, 
              c.is_nullable, 
              c.data_type, 
              c.character_maximum_length, 
              c.character_octet_length, 
              c.numeric_precision, 
              c.numeric_precision, 
              c.datetime_precision, 
              character_set_name, 
              collation_name, 
              GETDATE() AS gendate 
       FROM   information_schema.tables T 
       JOIN   information_schema.columns C 
       ON     c.table_name = t.table_name FOR json auto) ;
       
       PRINT @json;