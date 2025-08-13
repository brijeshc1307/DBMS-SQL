

### **1. Definition of SQL (Structured Query Language):**

**SQL** is a **domain-specific language** used in programming and managing **relational databases**. It allows users to **create**, **read**, **update**, and **delete** data (often abbreviated as **CRUD**) stored in relational database management systems (RDBMS).

---

### **2. Types of SQL Commands:**

SQL commands are broadly categorized into the following types:

| Type                                   | Description                                     | Examples                               |
| -------------------------------------- | ----------------------------------------------- | -------------------------------------- |
| **DDL** (Data Definition Language)     | Defines or alters the structure of the database | `CREATE`, `ALTER`, `DROP`              |
| **DML** (Data Manipulation Language)   | Used to manipulate data                         | `SELECT`, `INSERT`, `UPDATE`, `DELETE` |
| **DCL** (Data Control Language)        | Controls access to data                         | `GRANT`, `REVOKE`                      |
| **TCL** (Transaction Control Language) | Manages transactions                            | `COMMIT`, `ROLLBACK`, `SAVEPOINT`      |
| **DQL** (Data Query Language)          | Used to query the database                      | `SELECT`                               |

---

### **3. Why Use SQL?**

* **Data Management:** Helps in storing, retrieving, and manipulating structured data.
* **Standardized Language:** Used by most relational database systems (e.g., MySQL, PostgreSQL, SQL Server, Oracle).
* **Easy to Learn & Use:** Has simple syntax similar to English.
* **Data Analysis & Reporting:** Powerful querying capabilities.
* **Integration:** Works well with most programming languages and data tools.

---

### **4. Basic SQL Syntax:**

```sql
-- Selecting all records from a table
SELECT * FROM employees;

-- Inserting a new record
INSERT INTO employees (id, name, department) VALUES (1, 'Alice', 'HR');

-- Updating a record
UPDATE employees SET department = 'Finance' WHERE id = 1;

-- Deleting a record
DELETE FROM employees WHERE id = 1;
```

---

### **5. Example: Simple SQL Queries**

#### **a. Creating a Table (DDL)**

```sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50)
);
```

#### **b. Inserting Data (DML)**

```sql
INSERT INTO employees (id, name, department)
VALUES (1, 'Alice', 'HR'), (2, 'Bob', 'IT');
```

#### **c. Querying Data (DQL)**

```sql
SELECT name FROM employees WHERE department = 'IT';
```

#### **d. Updating Data**

```sql
UPDATE employees SET department = 'Finance' WHERE name = 'Alice';
```

#### **e. Deleting Data**

```sql
DELETE FROM employees WHERE id = 2;
```

---

Let me know if you want this as a formatted PDF or cheat sheet version!
