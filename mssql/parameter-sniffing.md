# Azure SQL Parameter Sniffing: A Detailed Technical Overview

## Introduction

Parameter sniffing is a query optimization strategy in SQL Server that creates execution plans based on the first set of parameter values used when a stored procedure is compiled. This technique aims to improve query performance by generating an efficient, reusable execution plan.

## How Parameter Sniffing Works

When a stored procedure is first executed, the SQL Server query optimizer creates an execution plan optimized for the specific parameter values used in that initial execution. This plan is then cached and reused for subsequent executions of the same procedure, reducing compilation overhead.

### Example Scenario

Consider the following stored procedure:

```sql
CREATE PROCEDURE GetCustomerOrders
    @CustomerType NVARCHAR(50)
AS
BEGIN
    SELECT * FROM Orders
    WHERE CustomerType = @CustomerType
    AND OrderDate > DATEADD(month, -6, GETDATE())
END
```

#### Potential Execution Scenarios

1. **First Execution**: Premium customer with 1000 orders
   - Optimizer creates a plan with an index scan
   - Assumes a large result set
   - Allocates significant memory and processing resources

2. **Subsequent Execution**: Basic customer with 10 orders
   - The previously optimized plan may now be inefficient
   - Plan was "sniffed" based on initial parameter values
   - May not represent typical or most common use cases

## Symptoms of Problematic Parameter Sniffing

- Inconsistent query performance
- Unexpectedly slow queries
- Significant variations in execution time for the same procedure

## Mitigation Strategies

### 1. Recompile Hint

```sql
CREATE PROCEDURE GetCustomerOrders
    @CustomerType NVARCHAR(50)
AS
BEGIN
    SELECT * FROM Orders WITH (RECOMPILE)
    WHERE CustomerType = @CustomerType
    AND OrderDate > DATEADD(month, -6, GETDATE())
END
```

The `WITH (RECOMPILE)` hint forces SQL Server to generate a new execution plan for each execution, based on current parameter values.

### 2. Optimize for Unknown

```sql
CREATE PROCEDURE GetCustomerOrders
    @CustomerType NVARCHAR(50)
AS
BEGIN
    SELECT * FROM Orders
    WHERE CustomerType = @CustomerType
    OPTION (OPTIMIZE FOR UNKNOWN)
END
```

This approach creates a more "generic" execution plan that works reasonably well across different parameter scenarios.

### 3. Local Variables

```sql
CREATE PROCEDURE GetCustomerOrders
    @CustomerType NVARCHAR(50)
AS
BEGIN
    DECLARE @LocalCustomerType NVARCHAR(50) = @CustomerType
    
    SELECT * FROM Orders
    WHERE CustomerType = @LocalCustomerType
    AND OrderDate > DATEADD(month, -6, GETDATE())
END
```

Using a local variable can sometimes help the optimizer create a more balanced execution plan.

## Advanced Considerations

- Parameter sniffing is more pronounced in procedures with complex logic
- Significant performance implications in data warehouses
- Modern SQL Server versions have improved parameter sniffing algorithms

## Practical Recommendations

1. Do not reflexively disable parameter sniffing
2. Profile your specific use cases
3. Measure performance
4. Apply targeted optimizations

Identify procedures in your database where parameter sniffing might cause performance variations:

- Procedures with widely varying data distributions
- Complex join conditions
- Significant differences in result set sizes based on input parameters
