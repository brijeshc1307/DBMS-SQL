## **Step 1: Declare Variables**
```sql
DECLARE @TableName NVARCHAR(50);
DECLARE @SQLL NVARCHAR (MAX);
SET @TableName = 'Inventory_' + FORMAT (GETDATE(), 'dd_MM_yyyy');
```
- Declares two variables:
  - `@TableName`: Stores the dynamically generated table name, which includes the current date in `dd_MM_yyyy` format (e.g., `Inventory_13_02_2025` for Feb 13, 2025).
  - `@SQLL`: Stores the SQL statement to create the table.

---

## **Step 2: Create a Table Dynamically**
```sql
SET @SQLL = '

CREATE TABLE dbo.' + @TableName + '(

[DeviceId] [varchar] (1024) NULL,
[DeviceName] [varchar] (1024) NULL,
[OSDescription] [varchar] (1024) NULL,
[OSVersion] [varchar] (1024) NULL,
[Platform] [varchar] (1024) NULL,
[UserId] [varchar] (1024) NULL,
[EmailAddress] [varchar] (1024) NULL,
[UserName] [varchar] (1024) NULL

) ON [PRIMARY];';

EXEC sp_executesql @SQLL;
```
- Constructs a `CREATE TABLE` statement dynamically using `@TableName`.
- Executes the SQL statement using `sp_executesql`, creating a new table with columns like `DeviceId`, `DeviceName`, `OSDescription`, etc.
- The table is created in the `dbo` schema.

---

## **Step 3: Enable `xp_cmdshell` to Access File System**
```sql
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp_configure 'xp_cmdshell', 1;
RECONFIGURE;
```
- Enables advanced options in SQL Server.
- Turns on `xp_cmdshell`, which allows SQL Server to execute Windows command-line commands.

---

## **Step 4: Find the Latest CSV File and Import Data**
### **Step 4.1: Declare More Variables**
```sql
DECLARE @FileName NVARCHAR(255);
DECLARE @FilePath NVARCHAR(512);
DECLARE @Directory NVARCHAR(255) = 'I:\RawData\';
DECLARE @SQL NVARCHAR (MAX);
```
- `@FileName`: Stores the name of the CSV file.
- `@FilePath`: Stores the full path of the CSV file.
- `@Directory`: Defines the directory where the CSV files are stored.
- `@SQL`: Stores the SQL query for bulk data import.

---

### **Step 4.2: Create and Populate Temporary Table to Hold File List**
```sql
IF OBJECT_ID('tempdb..#FileList') IS NOT NULL
  DROP TABLE #FileList;

CREATE TABLE #FileList ( 
  FileDetails NVARCHAR(512) 
);

INSERT INTO #FileList (FileDetails)
EXEC xp_cmdshell 'DIR I:\RawData\*.csv /O-D /B';
```
- Checks if a temporary table `#FileList` exists; if yes, it drops it.
- Creates a temporary table `#FileList` to store file names.
- Uses `xp_cmdshell` to list all `.csv` files in the `I:\RawData\` directory.
  - `/O-D`: Orders files by date (latest first).
  - `/B`: Returns only file names, not full details.

---

### **Step 4.3: Select the Most Recent CSV File**
```sql
SELECT TOP 1 @FileName = FileDetails 
FROM #FileList
WHERE FileDetails IS NOT NULL AND FileDetails LIKE '%.csv';
```
- Selects the **most recent** CSV file from `#FileList` and stores its name in `@FileName`.

---

### **Step 4.4: Construct and Execute Bulk Insert Query**
```sql
SET @FilePath = @Directory + @FileName;

SET @SQL = N'
  BULK INSERT dbo.'+ @TableName +'
FROM '''+ @FilePath +'''
WITH (
  FIELDTERMINATOR = '','',
  ROWTERMINATOR = ''\n'',
  FIRSTROW = 2,
  TABLOCK,
  ERRORFILE = ''C:\temp\error_' + REPLACE(@FileName, '.csv', '.log') + '''
 );';
```
- Combines `@Directory` and `@FileName` to form the full file path.
- Constructs a **BULK INSERT** SQL statement dynamically:
  - **`BULK INSERT dbo.@TableName`** → Imports data into the dynamically created table.
  - **`FIELDTERMINATOR = ','`** → Assumes CSV files are comma-separated.
  - **`ROWTERMINATOR = '\n'`** → Each row ends with a newline.
  - **`FIRSTROW = 2`** → Skips the first row (header).
  - **`ERRORFILE = 'C:\temp\error_<filename>.log'`** → Saves any errors in a log file.

```sql
PRINT 'Importing file: '+ @FilePath;
EXEC sp_executesql @SQL;
```
- Prints the file name being imported.
- Executes the **BULK INSERT** command.

---

## **Step 5: Cleanup**
```sql
DROP TABLE #FileList;
  
EXEC sp_configure 'xp_cmdshell', 0;
RECONFIGURE;
```
- Drops the temporary table `#FileList` after processing.
- Disables `xp_cmdshell` for security reasons.

---

## **Summary**
1. **Creates a new table (`Inventory_dd MM_yyyy`) dynamically with the current date.**
2. **Enables `xp_cmdshell` to interact with the file system.**
3. **Finds the most recent CSV file from `I:\RawData\`.**
4. **Imports CSV data into the new table using `BULK INSERT`.**
5. **Disables `xp_cmdshell` after execution.**

---
