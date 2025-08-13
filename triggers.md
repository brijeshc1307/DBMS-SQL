

## 🔷 **1. What Are Triggers?**

A **trigger** is a special type of stored program that **automatically executes** (fires) **in response to an event** on a table — such as an `INSERT`, `UPDATE`, or `DELETE`.

---

## 🔷 **2. Why Use Triggers?**

* **Enforce business rules**
* **Maintain audit logs**
* **Automatically validate or modify data**
* **Synchronize tables**
* **Prevent invalid operations**

---

## 🔷 **3. Sample Tables**

Let’s create two tables:

```sql
-- Main table
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10,2)
);

-- Audit log table
CREATE TABLE employee_audit (
    audit_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, -- Use AUTO_INCREMENT / SERIAL if needed
    employee_id INT,
    action VARCHAR(50),
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

## 🔷 **4. Trigger Examples by SQL Dialect**

---

### ✅ **A. SQL Server: AFTER INSERT Trigger**

```sql
CREATE TRIGGER trg_AfterInsert_Employee
ON employees
AFTER INSERT
AS
BEGIN
    INSERT INTO employee_audit (employee_id, action)
    SELECT id, 'INSERTED' FROM inserted;
END;
```

🔹 Explanation:

* `inserted` is a special SQL Server table containing newly inserted rows.

---

### ✅ **B. MySQL: AFTER INSERT Trigger**

```sql
DELIMITER //

CREATE TRIGGER trg_after_insert_employee
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (employee_id, action)
    VALUES (NEW.id, 'INSERTED');
END;
//

DELIMITER ;
```

🔹 Explanation:

* `NEW` holds values of the inserted row.

---

### ✅ **C. PostgreSQL: AFTER INSERT Trigger**

```sql
-- Step 1: Create function
CREATE OR REPLACE FUNCTION log_employee_insert()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO employee_audit (employee_id, action)
    VALUES (NEW.id, 'INSERTED');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Step 2: Create trigger
CREATE TRIGGER trg_after_insert_employee
AFTER INSERT ON employees
FOR EACH ROW
EXECUTE FUNCTION log_employee_insert();
```

---

## 🔷 **5. Trigger on UPDATE Example**

### MySQL Example (also similar in SQL Server/PostgreSQL):

```sql
DELIMITER //

CREATE TRIGGER trg_after_update_employee
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (employee_id, action)
    VALUES (NEW.id, 'UPDATED');
END;
//

DELIMITER ;
```

---

## 🔷 **6. Trigger on DELETE Example**

### PostgreSQL Example:

```sql
-- Function
CREATE OR REPLACE FUNCTION log_employee_delete()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO employee_audit (employee_id, action)
    VALUES (OLD.id, 'DELETED');
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER trg_after_delete_employee
AFTER DELETE ON employees
FOR EACH ROW
EXECUTE FUNCTION log_employee_delete();
```

---

## 🔷 **7. Testing the Trigger (Insert Example)**

```sql
-- Insert a new employee
INSERT INTO employees (id, name, salary) VALUES (1, 'Alice', 5000.00);

-- Check audit log
SELECT * FROM employee_audit;
```

---

## 🔷 **8. Best Practices**

| Practice                                             | Benefit                           |
| ---------------------------------------------------- | --------------------------------- |
| Keep trigger logic simple                            | Avoid performance issues          |
| Avoid recursion (trigger triggering another trigger) | Prevent infinite loops            |
| Use AFTER triggers for logging                       | Ensures changes actually occurred |
| Test with all operations (INSERT/UPDATE/DELETE)      | Catch unintended behavior         |

---

Would you like a complete project (SQL script) with table creation, data insertion, and triggers for practice in your preferred DBMS?
