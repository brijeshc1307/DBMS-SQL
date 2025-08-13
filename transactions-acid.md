Here's a **complete and practical guide** to **Transactions & ACID Properties in SQL**, including:

* ✅ What transactions are
* ✅ Explanation of ACID properties
* ✅ Syntax with examples for **SQL Server**, **MySQL**, and **PostgreSQL**
* ✅ Sample tables + real-life scenarios

---

## 🔷 1. **What is a Transaction?**

A **transaction** is a group of one or more SQL statements that are **executed as a single unit**. Either **all statements succeed** (commit) or **none of them take effect** (rollback).

---

## 🔷 2. **ACID Properties**

| Property        | Meaning                                                           |
| --------------- | ----------------------------------------------------------------- |
| **A**tomicity   | All or nothing. A transaction is fully completed or not at all.   |
| **C**onsistency | Ensures the database moves from one valid state to another.       |
| **I**solation   | Concurrent transactions don’t interfere with each other.          |
| **D**urability  | Once committed, data changes are permanent — even during crashes. |

---

## 🔷 3. **Create Sample Table**

We'll use a simple **banking** example:

```sql
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    account_name VARCHAR(100),
    balance DECIMAL(10, 2)
);
```

Insert sample data:

```sql
INSERT INTO accounts VALUES
(1, 'Alice', 1000.00),
(2, 'Bob', 500.00);
```

---

## 🔷 4. **Use Case: Money Transfer**

Let's say Alice transfers ₹200 to Bob. This requires:

* Deduct ₹200 from Alice
* Add ₹200 to Bob

This **must be atomic** — if one step fails, the other must not happen.

---

## 🔷 5. **Transaction Syntax in SQL Server, MySQL, PostgreSQL**

### ✅ **SQL Server**

```sql
BEGIN TRANSACTION;

UPDATE accounts SET balance = balance - 200 WHERE account_id = 1;  -- Alice
UPDATE accounts SET balance = balance + 200 WHERE account_id = 2;  -- Bob

-- Check and commit
IF @@ERROR = 0
    COMMIT;
ELSE
    ROLLBACK;
```

---

### ✅ **MySQL**

```sql
START TRANSACTION;

UPDATE accounts SET balance = balance - 200 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 200 WHERE account_id = 2;

-- If no error
COMMIT;

-- If any error occurs, use ROLLBACK;
```

> ⚠️ In MySQL, make sure you're using a storage engine that supports transactions (e.g., **InnoDB**).

---

### ✅ **PostgreSQL**

```sql
BEGIN;

UPDATE accounts SET balance = balance - 200 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 200 WHERE account_id = 2;

-- Commit changes
COMMIT;

-- Or if something goes wrong:
-- ROLLBACK;
```

---

## 🔷 6. **Simulating Rollback (Error Handling)**

Example: Trying to transfer more than the available balance

```sql
BEGIN;

-- Alice only has 1000
UPDATE accounts SET balance = balance - 1500 WHERE account_id = 1;

-- Check balance after update (logic you'd implement in app/backend)
-- If negative, ROLLBACK
-- Otherwise, continue

-- This causes insufficient funds (simulate)
ROLLBACK; -- undo the deduction
```

---

## 🔷 7. **Check Results**

```sql
SELECT * FROM accounts;
```

Use this to verify balances before and after transactions.

---

## 🔷 8. **Isolation Levels** (Advanced)

Databases support isolation levels to manage concurrency:

| Level                | Description                           |
| -------------------- | ------------------------------------- |
| **READ UNCOMMITTED** | See uncommitted changes (dirty reads) |
| **READ COMMITTED**   | Only see committed data               |
| **REPEATABLE READ**  | Prevents non-repeatable reads         |
| **SERIALIZABLE**     | Highest isolation, strict locking     |

### SQL Server:

```sql
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRANSACTION;
-- your operations here
COMMIT;
```

### MySQL & PostgreSQL:

```sql
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;
-- your operations
COMMIT;
```

---

## 🔷 9. **Best Practices**

| Tip                                               | Reason                              |
| ------------------------------------------------- | ----------------------------------- |
| Always use transactions for multi-step operations | Ensures data integrity              |
| Use `ROLLBACK` on error                           | Prevents partial updates            |
| Keep transactions short                           | Avoids blocking other users         |
| Use appropriate isolation level                   | Balances consistency vs performance |

---

## 🔷 10. Summary

| Command   | SQL Server                            | MySQL               | PostgreSQL |
| --------- | ------------------------------------- | ------------------- | ---------- |
| Start     | `BEGIN TRANSACTION`                   | `START TRANSACTION` | `BEGIN`    |
| Commit    | `COMMIT`                              | `COMMIT`            | `COMMIT`   |
| Rollback  | `ROLLBACK`                            | `ROLLBACK`          | `ROLLBACK` |
| Isolation | `SET TRANSACTION ISOLATION LEVEL ...` | Same                | Same       |

---

Would you like a downloadable `.sql` script with all these examples to test on your system?
