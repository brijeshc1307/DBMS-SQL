### **1. Definition of SQL Data Types:**

In SQL, **data types** define the **kind of value** that can be stored in a column of a table. They help the database understand what type of data is being stored (text, number, date, etc.) and how much space to allocate.

---

### **2. Types of SQL Data Types:**

SQL data types are broadly categorized into:

#### **A. Numeric Data Types**

Used for storing numbers (integers, decimals, etc.)

| Data Type                        | Description                                    |
| -------------------------------- | ---------------------------------------------- |
| `INT`, `INTEGER`                 | Whole numbers                                  |
| `SMALLINT`, `BIGINT`             | Smaller or larger range of integers            |
| `DECIMAL(p, s)`, `NUMERIC(p, s)` | Exact numeric with precision (p) and scale (s) |
| `FLOAT`, `REAL`, `DOUBLE`        | Approximate numeric types                      |

---

#### **B. Character/String Data Types**

Used for storing text

| Data Type    | Description            |
| ------------ | ---------------------- |
| `CHAR(n)`    | Fixed-length string    |
| `VARCHAR(n)` | Variable-length string |
| `TEXT`       | Large text data        |

---

#### **C. Date and Time Data Types**

Used for date and time values

| Data Type               | Description            |
| ----------------------- | ---------------------- |
| `DATE`                  | Date only (YYYY-MM-DD) |
| `TIME`                  | Time only (HH\:MM\:SS) |
| `DATETIME`, `TIMESTAMP` | Date and time combined |

---

#### **D. Boolean Data Type**

Used for true/false values

| Data Type | Description                                        |
| --------- | -------------------------------------------------- |
| `BOOLEAN` | TRUE, FALSE (may be stored as 0/1 in some systems) |

---

#### **E. Other Data Types**

| Data Type | Description                               |
| --------- | ----------------------------------------- |
| `BLOB`    | Binary large object (e.g., images, files) |
| `UUID`    | Universally unique identifier             |

---

### **3. SQL Constraints (Related to Data Types):**

Constraints help enforce rules at the column level to maintain data integrity:

| Constraint    | Description                              |
| ------------- | ---------------------------------------- |
| `NOT NULL`    | Column must have a value                 |
| `UNIQUE`      | No duplicate values allowed              |
| `PRIMARY KEY` | Uniquely identifies each row             |
| `FOREIGN KEY` | Links to a primary key in another table  |
| `CHECK`       | Validates data based on a condition      |
| `DEFAULT`     | Sets a default value if none is provided |

---

### **4. Why Use SQL Data Types?**

* **Data Accuracy:** Ensures correct format and type of data.
* **Storage Efficiency:** Allocates memory appropriately based on data type.
* **Validation:** Prevents invalid data using constraints.
* **Improves Performance:** Optimizes queries by using proper types.

---

### **5. Example: Using Data Types and Constraints**

```sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2) CHECK (salary > 0),
    hire_date DATE DEFAULT CURRENT_DATE,
    is_active BOOLEAN DEFAULT TRUE
);
```

---

### **6. Best Practices:**

* Use the **most appropriate data type** (e.g., don't use `TEXT` when `VARCHAR(50)` is enough).
* **Avoid NULLs** when possible by using `NOT NULL`.
* Use **`DECIMAL`** instead of `FLOAT` for financial data.
* Always define **constraints** to ensure data integrity.
* Be aware of **database-specific limitations** (e.g., MySQL vs PostgreSQL).

---

Let me know if you'd like this summarized as a study sheet or visual diagram!
