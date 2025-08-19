/*
    Скрипт демонстрирует типичные ошибки, связанные с SQL-инъекциями (SQL Injection) в SQL Server.
    Основные функции:
    - Примеры небезопасного формирования динамического SQL
    - Сравнение EXEC и sp_executesql для предотвращения инъекций
    - Демонстрация уязвимости при прямой подстановке параметров
    - Рекомендации по безопасному использованию параметров
*/
SET NOCOUNT ON

DECLARE @param VARCHAR(MAX) = SCHEMA_ID()
--SET @param = '1; select ''hack'''

DECLARE @SQL NVARCHAR(MAX)
SET @SQL = 'SELECT TOP(5) name FROM sys.objects WHERE schema_id = ' + @param

PRINT @SQL
EXEC (@SQL) -- 4k chars

SET @SQL = 'SELECT TOP(5) name FROM sys.objects WHERE schema_id = @schema_id'

PRINT @SQL
EXEC sys.sp_executesql @SQL
                     , N'@schema_id INT'
                     , @schema_id = @param