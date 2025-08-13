## **1. Definition: Joins and Subqueries**

* **Joins**: Combine rows from two or more tables based on a related column (usually a foreign key).
* **Subqueries**: A query nested inside another SQL query, used to filter, calculate, or return data dynamically.

---

## **2. Types of Joins (With Examples for SQL Server, MySQL, PostgreSQL)**

### ✅ **A. INNER JOIN**

Returns only the matching rows from both tables.

```sql
-- SQL Server / MySQL / PostgreSQL (Same syntax)
SELECT e.name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.id;
```

---

### ✅ **B. LEFT JOIN (or LEFT OUTER JOIN)**

Returns all rows from the left table and matching rows from the right table. If no match, NULLs are returned.

```sql
SELECT e.name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.id;
```

---

### ✅ **C. RIGHT JOIN (or RIGHT OUTER JOIN)**

Returns all rows from the right table and matching rows from the left. If no match, NULLs are returned.

```sql
-- Note: Supported in SQL Server and PostgreSQL. MySQL also supports it.
SELECT e.name, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.id;
```

---

### ✅ **D. CROSS JOIN**

Returns the Cartesian product (all possible combinations of rows). Use with caution.

```sql
SELECT e.name, d.department_name
FROM employees e
CROSS JOIN departments d;
```

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

## **4. Compatibility Notes**

| Feature                                               | SQL Server | MySQL                      | PostgreSQL |
| ----------------------------------------------------- | ---------- | -------------------------- | ---------- |
| `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `CROSS JOIN` | ✅          | ✅                          | ✅          |
| `FULL OUTER JOIN`                                     | ✅          | ❌ *(use UNION workaround)* | ✅          |
| `EXISTS`, `IN`, subqueries                            | ✅          | ✅                          | ✅          |
| Aliases in subqueries                                 | ✅          | ✅                          | ✅          |

---

## **5. Best Practices**

* Always use **table aliases** (`e`, `d`) for clarity.
* Use **`INNER JOIN`** when you want matching data only.
* Use **`LEFT JOIN`** when you need all data from one table, regardless of matches.
* Use **`EXISTS`** for performance with large subqueries.
* Avoid **`CROSS JOIN`** unless necessary (can produce huge result sets).

---

Let me know if you'd like a diagram or cheat sheet to visualize JOIN types!
