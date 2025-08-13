Here’s a complete breakdown of **SQL Queries**, covering **definition, types (SELECT, INSERT, UPDATE, DELETE), why they're used, and examples**:

---

## **1. Definition: SQL Queries**

SQL **queries** are commands used to **interact with data** stored in a relational database. They allow users to **retrieve**, **insert**, **modify**, or **remove** data using specific SQL statements.

---

## **2. Types of SQL Queries**

The most commonly used SQL Data Manipulation Language (DML) commands include:

| Query Type | Description                            |
| ---------- | -------------------------------------- |
| `SELECT`   | Retrieves data from one or more tables |
| `INSERT`   | Adds new data (rows) into a table      |
| `UPDATE`   | Modifies existing data                 |
| `DELETE`   | Removes data from a table              |

---

## **3. Why Use These SQL Queries?**

* **`SELECT`**: To fetch specific data from one or more tables based on conditions.
* **`INSERT`**: To add new records (e.g., user registration).
* **`UPDATE`**: To change existing records (e.g., update email address).
* **`DELETE`**: To remove unnecessary or old records.

These operations form the foundation of **CRUD** functionality:

* **C**reate → `INSERT`
* **R**ead → `SELECT`
* **U**pdate → `UPDATE`
* **D**elete → `DELETE`

---

## **4. Examples of SQL Queries**

### **A. SELECT Query**

Retrieve all employees:

```sql
SELECT * FROM employees;
```

Retrieve specific columns:

```sql
SELECT name, salary FROM employees WHERE department = 'IT';
```

---

### **B. INSERT Query**

Insert a new employee:

```sql
INSERT INTO employees (id, name, department, salary)
VALUES (1, 'Alice', 'HR', 55000);
```

---

### **C. UPDATE Query**

Update salary of an employee:

```sql
UPDATE employees
SET salary = 60000
WHERE id = 1;
```

---

### **D. DELETE Query**

Delete an employee record:

```sql
DELETE FROM employees
WHERE id = 1;
```

---

## **5. Best Practices:**

* **Use WHERE clauses** with `UPDATE` and `DELETE` to avoid unintentional changes to all records.
* Always **back up data** before running destructive queries like `DELETE`.
* Test queries on a small dataset or in a development environment.
* Use **parameterized queries** in applications to avoid SQL injection.

---

Let me know if you'd like a practice worksheet or sample database to test these commands on!
