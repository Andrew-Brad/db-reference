-- Implicit Transactions Mode

-- Restore AdventureWorks Database, this can be found in the exercise files
USE [AdventureWorks2022]

-- Turn Implicit Transaction ON
SET IMPLICIT_TRANSACTIONS ON;

-- View Active Transaction
SELECT @@TRANCOUNT; -- verify 0 transactions






-- Select Table
SELECT * FROM [Sales].[SalesOrderDetail]
WHERE [SalesOrderDetailID]  = 601;

SELECT @@TRANCOUNT; -- 1





-- Include COMMIT
SELECT * FROM [Sales].[SalesOrderDetail]
WHERE [SalesOrderDetailID]  = 601;
COMMIT TRANSACTION

SELECT @@TRANCOUNT;

-- Update the Table
UPDATE [Sales].[SalesOrderDetail]
SET UnitPrice = 5000
WHERE  [SalesOrderDetailID]  = 601;


-- COMMIT TRANSACTION = COMMIT TRAN = COMMIT
ROLLBACK
COMMIT
