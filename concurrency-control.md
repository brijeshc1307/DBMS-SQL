

## 🔷 1. What is Concurrency Control?

Concurrency control ensures that multiple database transactions can execute simultaneously **without interfering** with each other, preserving **data consistency and integrity**.

---

## 🔷 2. Why is it Important?

* Avoid **dirty reads** (reading uncommitted data)
* Prevent **lost updates** (overwriting changes)
* Handle **phantom reads** (new rows appearing during a transaction)
* Maintain **transaction isolation**

---

## 🔷 3. Locking Mechanisms

| Lock Type              | Description                           | When Used                        |
| ---------------------- | ------------------------------------- | -------------------------------- |
| **Shared Lock (S)**    | Allows reading but not writing        | During SELECT queries            |
| **Exclusive Lock (X)** | Allows writing, blocks others         | During INSERT, UPDATE, DELETE    |
| **Update Lock (U)**    | Prevents deadlocks in updates         | During certain read-modify-write |
| **Intent Locks**       | Indicate intention to lock a resource | Manage hierarchy of locks        |

---

## 🔷 4. Transaction Isolation Levels

| Level                     | Behavior                                         | Common Use Cases                |
| ------------------------- | ------------------------------------------------ | ------------------------------- |
| **READ UNCOMMITTED**      | Dirty reads allowed                              | Fast but risky                  |
| **READ COMMITTED**        | No dirty reads; shared locks during read         | Default in most DBMS            |
| **REPEATABLE READ**       | Prevents non-repeatable reads; locks range       | Medium isolation                |
| **SERIALIZABLE**          | Highest isolation; transactions run sequentially | Avoids phantom reads            |
| **SNAPSHOT** (SQL Server) | Uses versioning to avoid locks                   | High concurrency, less blocking |

---

## 🔷 5. Setting Isolation Levels (SQL Examples)

### SQL Server

```sql
-- Set READ COMMITTED (default)
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN TRAN;
-- Your queries here
COMMIT TRAN;
```

### MySQL

```sql
-- Set REPEATABLE READ (default)
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

START TRANSACTION;
-- Your queries here
COMMIT;
```

### PostgreSQL

```sql
-- Set SERIALIZABLE
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
-- Your queries here
COMMIT;
```

---

## 🔷 6. Locking Example (SQL Server)

```sql
BEGIN TRAN;

-- Acquire exclusive lock on row with StudentID = 1
UPDATE Students
SET Grade = 'A+'
WHERE StudentID = 1;

-- Lock held until COMMIT
COMMIT TRAN;
```

---

## 🔷 7. Handling Deadlocks

* Occur when two transactions wait for each other’s locks
* DBMS detects deadlocks and kills one transaction automatically
* Minimize deadlocks by:

  * Accessing objects in the same order
  * Keeping transactions short
  * Using lower isolation levels if acceptable

---

## 🔷 8. Optimistic vs Pessimistic Concurrency

| Type            | Description                              | Usage                               |
| --------------- | ---------------------------------------- | ----------------------------------- |
| **Pessimistic** | Locks data during transaction            | SQL Server default behavior         |
| **Optimistic**  | No locks, checks for conflicts on commit | PostgreSQL MVCC, Snapshot isolation |

---

## 🔷 9. Summary Table

| Feature               | SQL Server                        | MySQL                   | PostgreSQL       |
| --------------------- | --------------------------------- | ----------------------- | ---------------- |
| Default Isolation     | READ COMMITTED                    | REPEATABLE READ         | READ COMMITTED   |
| Snapshot Isolation    | Supported                         | Supported (with InnoDB) | Supported (MVCC) |
| Set Isolation Command | `SET TRANSACTION ISOLATION LEVEL` | Same                    | Same             |
| Deadlock Handling     | Automatic detection & kill        | Automatic               | Automatic        |

---

If you want, I can provide **sample scripts simulating concurrent transactions** or explain **how to monitor locks and blocking** in your database. Would you like that?
