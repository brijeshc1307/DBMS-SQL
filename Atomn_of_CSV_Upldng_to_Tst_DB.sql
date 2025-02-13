--- Step 1: Declare Variables
DECLARE @TableName NVARCHAR(50);
DECLARE @SQLL NVARCHAR (MAX);
SET @TableName = 'Inventory_' + FORMAT (GETDATE(), 'dd MM_yyyy');

--Step 2: Create a Table Dynamically
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

EXEC sp executesql @SQLL;

-- PRINT 'Table ' + @TableName + created successfully.';

-- Step 3: Enable xp_cmdshell to Access File System
EXEC sp_configure 'show advanced options', 1;
RECONFIGURE;
EXEC sp configure 'xp.cmdshell', 1;
RECONFIGURE;

-- Step 4: Find the Latest CSV File and Import Data
--Step 4.1: Declare More Variables
DECLARE @FileName NVARCHAR(255);
DECLARE @FilePath NVARCHAR(512);
DECLARE @Directory NVARCHAR(255) = 'I:\RawData\';
DECLARE @SQL NVARCHAR (MAX);


---Step 4.2: Create and Populate Temporary Table to Hold File List
IF OBJECT_ID('tempdb..#FileList') IS NOT NULL
  DROP TABLE #FileList;

CREATE TABLE #FileList ( 
  FileDetails NVARCHAR(512) 
  );

INSERT INTO #FileList (FileDetails)
EXEC xp_cmdshell 'DIR I:\RawData\*.csv /0-D/B';

--Step 4.3: Select the Most Recent CSV File
SELECT TOP 1 @FileName = FileDetails 
FROM #FileList
WHERE FileDetails IS NOT NULL AND FileDetails LIKE '%.csv';

--Step 4.4: Construct and Execute Bulk Insert Query
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

PRINT 'Importing file: '+ @FilePath;  --- Prints the file name being imported.
EXEC sp_executesql @SQL;  -- Executes the BULK INSERT command.

--Step 5: Cleanup
DROP TABLE #FileList;

--Step 6: Disables xp_cmdshell for security reasons.
EXEC sp_configure 'xp_cmdshell', θ;
RECONFIGURE;
