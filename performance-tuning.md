

## 🔷 1. What is Performance Tuning?

Performance tuning is the process of improving the speed and efficiency of database queries and operations to reduce response time and resource consumption.

---

## 🔷 2. Query Optimization Basics

* Write **SARGable** queries (Search ARGument Able) — use indexed columns in WHERE clauses without functions.
* Avoid `SELECT *` — select only required columns.
* Use **joins** wisely; prefer INNER JOIN over OUTER JOIN if possible.
* Avoid unnecessary subqueries; use joins or CTEs.
* Filter data early to reduce dataset size.

---

## 🔷 3. Indexing Strategies

| Index Type              | Purpose                                    | When to Use                                 |
| ----------------------- | ------------------------------------------ | ------------------------------------------- |
| **Clustered Index**     | Determines the physical order of data rows | Usually on primary key; only one per table  |
| **Non-Clustered Index** | Separate structure pointing to data rows   | On frequently queried columns in WHERE/JOIN |
| **Covering Index**      | Includes all columns needed by a query     | To avoid lookup operations                  |
| **Composite Index**     | Index on multiple columns                  | For queries filtering on multiple columns   |
| **Full-Text Index**     | For searching text within columns          | When doing keyword searches                 |

---

## 🔷 4. Creating Indexes Examples

### SQL Server, MySQL, PostgreSQL (Syntax similar)

```sql
-- Clustered index (SQL Server only, PRIMARY KEY creates clustered by default)
CREATE CLUSTERED INDEX IX_Students_Age ON Students(Age);

-- Non-clustered index
CREATE INDEX IX_Students_Name ON Students(Name);

-- Composite index
CREATE INDEX IX_Orders_CustomerDate ON Orders(CustomerID, OrderDate);
```

---

## 🔷 5. Execution Plans

Execution plans show how the database engine executes a query.

* Look for **Index Scan** vs **Index Seek**: Seek is faster.
* Avoid **Table Scan** on large tables.
* Watch for **Warnings** or **Expensive Operators**.

### Viewing Execution Plans

| Database   | How to View Execution Plan                                                                |
| ---------- | ----------------------------------------------------------------------------------------- |
| SQL Server | In SSMS: Press `Ctrl + M` before query execution or click “Include Actual Execution Plan” |
| MySQL      | Use `EXPLAIN SELECT ...`                                                                  |
| PostgreSQL | Use `EXPLAIN ANALYZE SELECT ...`                                                          |

---

### Example: Viewing Execution Plan in SQL Server

```sql
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT * FROM Students WHERE Name = 'Alice';

-- Then check execution plan tab in SSMS.
```

---

## 🔷 6. Sample Query Optimization

### Before (Non-SARGable)

```sql
SELECT * FROM Students WHERE LOWER(Name) = 'alice';
```

### After (SARGable)

```sql
SELECT * FROM Students WHERE Name = 'Alice';
```

*Create an index on `Name` column for better performance.*

---

## 🔷 7. Other Tips

* Use **Query Profiler** (SQL Server) or **Performance Schema** (MySQL).
* Avoid cursors if possible — use set-based operations.
* Update statistics regularly.
* Monitor long-running queries.
* Partition large tables for better management.

---

## 🔷 8. Summary Table

| Task                      | SQL Server                                | MySQL                | PostgreSQL                     |
| ------------------------- | ----------------------------------------- | -------------------- | ------------------------------ |
| Create Index              | `CREATE INDEX idx_name ON table(column);` | Same                 | Same                           |
| View Execution Plan       | SSMS GUI or `SET SHOWPLAN_ALL ON`         | `EXPLAIN SELECT ...` | `EXPLAIN ANALYZE SELECT ...`   |
| Analyze Query Performance | SQL Profiler, Extended Events             | Performance Schema   | pg\_stat\_statements extension |

---

Would you like me to help you generate example indexes and optimized queries for your own database schema?
