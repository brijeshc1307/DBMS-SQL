## 🔷 1. What is Database Security?

Database Security protects your data against unauthorized access, misuse, and threats by implementing mechanisms like **authentication**, **authorization**, and **encryption**.

---

## 🔷 2. Authentication (Who are you?)

Authentication verifies the identity of a user or system trying to connect to the database.

### SQL Server

* Supports **Windows Authentication** (integrated security) and **SQL Server Authentication** (username/password).
* Example: Connect using Windows Authentication in SSMS.

```sql
-- Create a SQL Server login
CREATE LOGIN MyUser WITH PASSWORD = 'StrongPass!2025';
```

### MySQL

* Uses username/password, optionally integrates with LDAP or PAM.

```sql
CREATE USER 'myuser'@'localhost' IDENTIFIED BY 'StrongPass!2025';
```

### PostgreSQL

* Supports password, Kerberos, LDAP, and certificate authentication.

```sql
CREATE ROLE myuser LOGIN PASSWORD 'StrongPass!2025';
```

---

## 🔷 3. Authorization (What can you do?)

Authorization controls what authenticated users are allowed to do in the database.

### Granting Permissions

| Permission  | Meaning                  |
| ----------- | ------------------------ |
| **SELECT**  | Read data                |
| **INSERT**  | Add data                 |
| **UPDATE**  | Modify data              |
| **DELETE**  | Remove data              |
| **EXECUTE** | Run stored procedures    |
| **CONTROL** | Full control over object |

---

### Examples

#### SQL Server

```sql
-- Grant SELECT permission on Students table
GRANT SELECT ON dbo.Students TO MyUser;

-- Revoke permission
REVOKE SELECT ON dbo.Students FROM MyUser;
```

#### MySQL

```sql
GRANT SELECT ON SchoolDB.Students TO 'myuser'@'localhost';
FLUSH PRIVILEGES;
```

#### PostgreSQL

```sql
GRANT SELECT ON TABLE Students TO myuser;
```

---

## 🔷 4. Encryption (Protect data confidentiality)

Encryption protects data at rest and in transit.

### Types of Encryption

| Type                                  | Description                                                              |
| ------------------------------------- | ------------------------------------------------------------------------ |
| **Transparent Data Encryption (TDE)** | Encrypts database files on disk (SQL Server, PostgreSQL with extensions) |
| **Column-level encryption**           | Encrypt specific sensitive columns                                       |
| **Transport Layer Security (TLS)**    | Encrypts data sent over the network                                      |

---

### SQL Server Encryption Example

```sql
-- Enable TDE (simplified)
CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_256
ENCRYPTION BY SERVER CERTIFICATE MyServerCert;

ALTER DATABASE SchoolDB SET ENCRYPTION ON;
```

### MySQL Encryption

* Use **InnoDB tablespace encryption** or **AES\_ENCRYPT** function for column encryption.

```sql
SELECT AES_ENCRYPT('SensitiveData', 'encryption_key');
```

### PostgreSQL Encryption

* Use **pgcrypto** extension for column encryption.

```sql
CREATE EXTENSION pgcrypto;

SELECT pgp_sym_encrypt('SensitiveData', 'encryption_key');
```

---

## 🔷 5. Additional Security Best Practices

* Use **least privilege principle** — grant only necessary permissions.
* Regularly **update passwords** and rotate keys.
* Enable **auditing and logging** to monitor access.
* Keep DBMS software up to date with security patches.
* Use **firewalls and network security** to restrict access.

---

## 🔷 6. Summary Table

| Security Aspect | SQL Server                  | MySQL                               | PostgreSQL                      |
| --------------- | --------------------------- | ----------------------------------- | ------------------------------- |
| Authentication  | Windows & SQL Auth          | Username/password, LDAP, PAM        | Password, LDAP, Kerberos, certs |
| Authorization   | GRANT/REVOKE on objects     | GRANT/REVOKE on DB & tables         | GRANT/REVOKE on DB objects      |
| Encryption      | TDE, Column Encryption, TLS | Tablespace encryption, AES\_ENCRYPT | pgcrypto extension, TLS         |

---

Would you like me to provide sample scripts for setting up secure users and encrypting data in your database?
