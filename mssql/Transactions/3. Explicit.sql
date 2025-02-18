-- Explicit Transactions Mode

-- Restore AdventureWorks Database, this can be found in the exercise files
USE [AdventureWorks2022];

-- View Active Transaction
SELECT @@TRANCOUNT;

-- Create Transaction
-- This puts you into explicit transaction mode
BEGIN TRANSACTION

SELECT * FROM [Sales].[SalesOrderDetail]
WHERE [SalesOrderDetailID]  = 602;

SELECT @@TRANCOUNT; -- 1

COMMIT TRANSACTION

SELECT @@TRANCOUNT; -- 0