-- Auto-commit Transactions Mode

-- Restore AdventureWorks Database, this can be found in the exercise files
USE [AdventureWorks2022]

-- Autocommit transaction mode is on by default
-- Each operation will be committed

/*
@@TRANCOUNT is a system function in Microsoft SQL Server that returns the number of active transactions for the current session.
Return Value: @@TRANCOUNT returns an integer value representing the number of active transactions.
Initial State: Before any transactions begin, @@TRANCOUNT is 0.
After BEGIN TRANSACTION: When a BEGIN TRANSACTION statement is executed, @@TRANCOUNT increments by 1.
Nested Transactions: If you execute another BEGIN TRANSACTION within an already active transaction, @@TRANCOUNT increments again.
COMMIT TRANSACTION: When a COMMIT TRANSACTION is executed, @@TRANCOUNT decrements by 1.
ROLLBACK TRANSACTION: Rolling back to a savepoint or the outer transaction will reset @@TRANCOUNT to 0 if it's the outermost transaction being rolled back.
*/
SELECT @@TRANCOUNT;






-- Select Table
SELECT * FROM [Sales].[SalesOrderDetail]
WHERE [SalesOrderDetailID]  = 600;

SELECT @@TRANCOUNT;







-- update the table
UPDATE [Sales].[SalesOrderDetail]
SET UnitPrice = 5000
WHERE  [SalesOrderDetailID]  = 600;

SELECT @@TRANCOUNT;


-- reset the table
UPDATE [Sales].[SalesOrderDetail]
SET UnitPrice = 20.1865
WHERE  [SalesOrderDetailID]  = 600;

SELECT @@TRANCOUNT;









---view table in a different query window to verify no issues
SELECT * FROM [Sales].[SalesOrderDetail]
WHERE [SalesOrderDetailID]  = 600;