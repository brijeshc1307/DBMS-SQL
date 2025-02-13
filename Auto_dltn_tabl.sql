DECLARE @TableName NVARCHAR(MAX); DECLARE @sql NVARCHAR(MAX);
WITH TableWithRowNumbers AS (
) AND ISDATE(RIGHT (t. [name], CHARINDEX('', REVERSE(t. [name])) - 1)) = 1
SELECT
t. [name] AS TableName, ROW_NUMBER() OVER ( ORDER BY TRY_CAST( RIGHT (t. [name], CHARINDEX('_', REVERSE(t. [name])) - 1 ) AS DATE) ASC ) AS RowNum
FROM sys.tables t INNER JOIN sys.schemas s ON t. [schema_id] = s. [schema_id]
WHERE s. [name] = 'Test'
AND t. [name] LIKE 'testTable %'
AND CHARINDEX('_', REVERSE (t. [name])) > 1
SELECT TableName
INTO #Tables ToDelete FROM TableWithRowNumbers WHERE RowNum <= (SELECT COUNT(*) FROM TableWithRowNumbers) - 3;
DECLARE TableCursor CURSOR FOR
SELECT TableName FROM #TablesToDelete;
OPEN TableCursor;
FETCH NEXT FROM TableCursor INTO @TableName;
WHILE @@FETCH_STATUS = 0
BEGIN
SET @sql = 'DROP TABLE Test.'+QUOTENAME(@TableName);
EXEC sp executesql @sql;
FETCH NEXT FROM TableCursor INTO @TableName;
END;
CLOSE TableCursor;
DEALLOCATE TableCursor;
DROP TABLE #Tables ToDelete;
