## **1. Definition: Joins and Subqueries**

* **Joins**: Combine rows from two or more tables based on a related column (usually a foreign key).
* **Subqueries**: A query nested inside another SQL query, used to filter, calculate, or return data dynamically.

---

## **2. Types of Joins (With Examples for SQL Server, MySQL, PostgreSQL)**

Great idea! Let's take **two sample tables** and demonstrate each type of SQL **JOIN** using realistic data and queries. This will help clarify how each join works.

---

## 🔹 **Sample Tables**

### 🧾 **Table 1: `employees`**

| id | name    | department\_id |
| -- | ------- | -------------- |
| 1  | Alice   | 101            |
| 2  | Bob     | 102            |
| 3  | Charlie | NULL           |
| 4  | David   | 104            |

---

### 🧾 **Table 2: `departments`**

| id  | department\_name |
| --- | ---------------- |
| 101 | HR               |
| 102 | IT               |
| 103 | Finance          |

---

Now we’ll use these tables in various JOINs:

---

## 🔸 **1. INNER JOIN**

> ✅ Only returns rows with matching `department_id`.

```sql
SELECT e.name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.id;
```

### 🔍 Result:

| name  | department\_name |
| ----- | ---------------- |
| Alice | HR               |
| Bob   | IT               |

---

## 🔸 **2. LEFT JOIN**

> ✅ Returns all employees, including those without a matching department.

```sql
SELECT e.name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id;
```

### 🔍 Result:

| name    | department\_name |
| ------- | ---------------- |
| Alice   | HR               |
| Bob     | IT               |
| Charlie | NULL             |
| David   | NULL             |

---

## 🔸 **3. RIGHT JOIN**

> ✅ Returns all departments, including those with no employees.

```sql
SELECT e.name, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.id;
```

### 🔍 Result:

| name  | department\_name |
| ----- | ---------------- |
| Alice | HR               |
| Bob   | IT               |
| NULL  | Finance          |

> 🔔 Note: MySQL and PostgreSQL support RIGHT JOIN. SQL Server supports it too, though it's less commonly used.

---

## 🔸 **4. FULL OUTER JOIN** *(if supported)*

> ✅ Returns all rows from both tables. If no match, fills with NULLs.

```sql
-- PostgreSQL or SQL Server
SELECT e.name, d.department_name
FROM employees e
FULL OUTER JOIN departments d ON e.department_id = d.id;
```

### 🔍 Result:

| name    | department\_name |
| ------- | ---------------- |
| Alice   | HR               |
| Bob     | IT               |
| Charlie | NULL             |
| David   | NULL             |
| NULL    | Finance          |

> 🔁 **MySQL workaround** (since it doesn't support FULL OUTER JOIN):

```sql
SELECT e.name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id
UNION
SELECT e.name, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.id;
```

---

## 🔸 **5. CROSS JOIN**

> No condition — combines every employee with every department (Cartesian product).

```sql
SELECT e.name, d.department_name
FROM employees e
CROSS JOIN departments d;
```

### 🔍 Result (4 employees × 3 departments = 12 rows):

| name    | department\_name |
| ------- | ---------------- |
| Alice   | HR               |
| Alice   | IT               |
| Alice   | Finance          |
| Bob     | HR               |
| Bob     | IT               |
| Bob     | Finance          |
| Charlie | HR               |
| Charlie | IT               |
| Charlie | Finance          |
| David   | HR               |
| David   | IT               |
| David   | Finance          |

---

## **3. Subqueries (Nested Queries)**

Subqueries can be used in:

* `SELECT` (inline views)
* `FROM` clause
* `WHERE` clause
* `HAVING` clause

---

### ✅ **A. Subquery in WHERE Clause**

Find employees with salaries above the average:

```sql
SELECT name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary) FROM employees
);
```

---

### ✅ **B. Subquery in FROM Clause (Inline View)**

```sql
SELECT department_id, avg_salary
FROM (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS dept_avg;
```

---

### ✅ **C. Subquery with EXISTS**

Check if a department has employees:

```sql
SELECT department_name
FROM departments d
WHERE EXISTS (
    SELECT 1 FROM employees e WHERE e.department_id = d.id
);
```

---


## **5. Best Practices**

* Always use **table aliases** (`e`, `d`) for clarity.
* Use **`INNER JOIN`** when you want matching data only.
* Use **`LEFT JOIN`** when you need all data from one table, regardless of matches.
* Use **`EXISTS`** for performance with large subqueries.
* Avoid **`CROSS JOIN`** unless necessary (can produce huge result sets).


