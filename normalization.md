Here's a clear and practical explanation of **Normalization** with examples and SQL queries for **SQL Server, MySQL, and PostgreSQL**.

---

## 🔷 1. What is Normalization?

Normalization is the process of organizing data in a database to **reduce redundancy** and **improve data integrity**. It involves decomposing a table into smaller tables and defining relationships between them.

---

## 🔷 2. Normal Forms Overview

| Normal Form                  | Description                                                                                 |
| ---------------------------- | ------------------------------------------------------------------------------------------- |
| **1NF (First Normal Form)**  | Eliminate repeating groups; each field contains atomic values only.                         |
| **2NF (Second Normal Form)** | Achieve 1NF and remove partial dependencies (no dependency on part of a composite key).     |
| **3NF (Third Normal Form)**  | Achieve 2NF and remove transitive dependencies (non-key attributes depend only on the key). |

---

## 🔷 3. Example Scenario

Suppose you have a **single table** storing order info:

| OrderID | CustomerName | CustomerPhone | Product1 | Product2 | Product3 |
| ------- | ------------ | ------------- | -------- | -------- | -------- |
| 101     | Alice        | 555-1234      | Laptop   | Mouse    | NULL     |
| 102     | Bob          | 555-5678      | Tablet   | NULL     | NULL     |

---

## 🔷 4. **1NF: Eliminate repeating groups**

### Problem:

* `Product1`, `Product2`, `Product3` columns are repeating groups.
* Violates atomicity.

### Solution: Use multiple rows instead of multiple columns for products.

---

### Table in 1NF (Orders):

| OrderID | CustomerName | CustomerPhone | Product |
| ------- | ------------ | ------------- | ------- |
| 101     | Alice        | 555-1234      | Laptop  |
| 101     | Alice        | 555-1234      | Mouse   |
| 102     | Bob          | 555-5678      | Tablet  |

---

## 🔷 5. **2NF: Remove partial dependencies**

* If `OrderID` and `Product` form a composite key, but `CustomerName` and `CustomerPhone` depend only on `OrderID`, then there is partial dependency.
* Move customer info to a separate table.

### Tables in 2NF:

* **Orders**

| OrderID | CustomerID |
| ------- | ---------- |
| 101     | 1          |
| 102     | 2          |

* **Customers**

| CustomerID | CustomerName | CustomerPhone |
| ---------- | ------------ | ------------- |
| 1          | Alice        | 555-1234      |
| 2          | Bob          | 555-5678      |

* **OrderProducts**

| OrderID | Product |
| ------- | ------- |
| 101     | Laptop  |
| 101     | Mouse   |
| 102     | Tablet  |

---

## 🔷 6. **3NF: Remove transitive dependencies**

* Suppose Product has info like `Category`.
* If `Category` depends on `Product`, not on the key (`OrderID`), move it to a separate table.

### Tables in 3NF:

* **Products**

| Product | Category    |
| ------- | ----------- |
| Laptop  | Electronics |
| Mouse   | Electronics |
| Tablet  | Electronics |

---

## 🔷 7. SQL Table Creation Examples

---

### Step 1: Create normalized tables in all DBMS

```sql
-- Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    CustomerPhone VARCHAR(20)
);

-- Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Products table
CREATE TABLE Products (
    Product VARCHAR(100) PRIMARY KEY,
    Category VARCHAR(100)
);

-- OrderProducts table (many-to-many relation)
CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(100),
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (Product) REFERENCES Products(Product)
);
```

---

## 🔷 8. Insert Sample Data

```sql
INSERT INTO Customers VALUES (1, 'Alice', '555-1234'), (2, 'Bob', '555-5678');

INSERT INTO Orders VALUES (101, 1), (102, 2);

INSERT INTO Products VALUES 
('Laptop', 'Electronics'),
('Mouse', 'Electronics'),
('Tablet', 'Electronics');

INSERT INTO OrderProducts VALUES
(101, 'Laptop'),
(101, 'Mouse'),
(102, 'Tablet');
```

---

## 🔷 9. Querying Normalized Data

Get orders with customer and product info:

```sql
SELECT o.OrderID, c.CustomerName, c.CustomerPhone, p.Product, p.Category
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderProducts op ON o.OrderID = op.OrderID
JOIN Products p ON op.Product = p.Product;
```

---

## 🔷 10. Notes on SQL Dialects

* These SQL statements work the **same in SQL Server, MySQL, and PostgreSQL**.
* Just ensure you use correct datatypes if adapting to specific SQL dialects.

---

Would you like me to prepare a script file with all table creations, inserts, and select queries for easy testing?
