/*
 Скрипт предназначен для демонстрации различий между операторами UNION и UNION ALL, а также их влияния на производительность и результат выборки в SQL Server.
 Основные функции:
 - Сравнение поведения операторов UNION и UNION ALL при объединении результатов.
 - Анализ влияния на статистику ввода-вывода и производительность запросов.
 - Примеры использования операторов для оптимизации выборки.
*/
USE AdventureWorks2014
GO

SELECT [object_id]
FROM sys.system_objects
UNION
SELECT [object_id]
FROM sys.objects

SELECT [object_id]
FROM sys.system_objects
UNION ALL
SELECT [object_id]
FROM sys.objects

------------------------------------------------------------------

SET STATISTICS IO ON

DECLARE @AddressLine NVARCHAR(60)
SET @AddressLine = '4775 Kentucky Dr.'

SELECT TOP(1) AddressID
FROM Person.[Address]
WHERE AddressLine1 = @AddressLine
    OR AddressLine2 = @AddressLine
--OPTION(RECOMPILE, QUERYTRACEON 9130)

SELECT TOP(1) AddressID
FROM (
    SELECT TOP(1) AddressID
    FROM Person.[Address]
    WHERE AddressLine1 = @AddressLine

    UNION ALL

    SELECT TOP(1) AddressID
    FROM Person.[Address]
    WHERE AddressLine2 = @AddressLine
) t
--OPTION(RECOMPILE, QUERYTRACEON 9130)

SET STATISTICS IO OFF