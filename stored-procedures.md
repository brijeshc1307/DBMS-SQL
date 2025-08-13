
## 🔷 1. **Definition**

### ✅ Stored Procedure:

A **stored procedure** is a **saved block of SQL code** (including logic) that you can execute multiple times. It can take **input/output parameters**, run **queries**, perform **inserts/updates**, and more.

### ✅ Function:

A **function** is similar to a procedure but **returns a single value** and is often used **inside SELECT statements**.

---

## 🔷 2. **Why Use Them?**

* Reuse code logic
* Improve performance (precompiled)
* Enforce business rules in the database
* Make code easier to maintain
* Secure database logic (restrict raw SQL access)

---

## 🔷 3. **Sample Table**

We’ll use a basic table to demonstrate stored procedures and functions:

```sql
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10,2),
    department VARCHAR(50)
);
```

---

## 🔷 4. **Stored Procedures**

---

### ▶️ **A. SQL Server: Create and Execute Stored Procedure**

```sql
-- Create a stored procedure to get employees by department
CREATE PROCEDURE GetEmployeesByDepartment
    @Dept VARCHAR(50)
AS
BEGIN
    SELECT * FROM employees
    WHERE department = @Dept;
END;
GO

-- Execute the procedure
EXEC GetEmployeesByDepartment 'HR';
```

---

### ▶️ **B. MySQL: Create and Execute Stored Procedure**

```sql
DELIMITER //

CREATE PROCEDURE GetEmployeesByDepartment(IN Dept VARCHAR(50))
BEGIN
    SELECT * FROM employees
    WHERE department = Dept;
END;
//

DELIMITER ;

-- Call the procedure
CALL GetEmployeesByDepartment('HR');
```

---

### ▶️ **C. PostgreSQL: Create and Execute Stored Procedure**

> PostgreSQL uses `CALL` for procedures (since version 11)

```sql
CREATE PROCEDURE GetEmployeesByDepartment(IN dept TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT * FROM employees WHERE department = dept;
END;
$$;

-- Execute procedure
CALL GetEmployeesByDepartment('HR');
```

---

## 🔷 5. **Functions**

---

### ▶️ **A. SQL Server: Scalar Function**

```sql
-- Return annual salary (monthly salary * 12)
CREATE FUNCTION GetAnnualSalary (@MonthlySalary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @MonthlySalary * 12;
END;

-- Use in a query
SELECT name, dbo.GetAnnualSalary(salary) AS annual_salary FROM employees;
```

---

### ▶️ **B. MySQL: Scalar Function**

```sql
DELIMITER //

CREATE FUNCTION GetAnnualSalary(monthly DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN monthly * 12;
END;
//

DELIMITER ;

-- Use the function
SELECT name, GetAnnualSalary(salary) AS annual_salary FROM employees;
```

---

### ▶️ **C. PostgreSQL: Scalar Function**

```sql
CREATE OR REPLACE FUNCTION GetAnnualSalary(monthly NUMERIC)
RETURNS NUMERIC AS $$
BEGIN
    RETURN monthly * 12;
END;
$$ LANGUAGE plpgsql;

-- Use the function
SELECT name, GetAnnualSalary(salary) AS annual_salary FROM employees;
```

---

## 🔷 6. **Best Practices**

| Practice                                                       | Reason                                |
| -------------------------------------------------------------- | ------------------------------------- |
| Use **parameters**                                             | Increases reusability                 |
| Keep logic inside **stored procedures**                        | Improves security and maintainability |
| Use **functions for reusable calculations**                    | Can be embedded in queries            |
| Avoid complex business logic inside functions that modify data | Use procedures instead                |

---

## 🔷 7. Bonus: Procedure with INSERT (MySQL Example)

```sql
DELIMITER //

CREATE PROCEDURE AddEmployee(
    IN emp_id INT,
    IN emp_name VARCHAR(100),
    IN emp_salary DECIMAL(10,2),
    IN emp_dept VARCHAR(50)
)
BEGIN
    INSERT INTO employees (id, name, salary, department)
    VALUES (emp_id, emp_name, emp_salary, emp_dept);
END;
//

DELIMITER ;

-- Call it:
CALL AddEmployee(10, 'John Doe', 4500.00, 'Finance');
```

---

Would you like a downloadable cheat sheet or ER diagram for these examples?
